import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import '../widgets/player_buttons.dart';
import '../../data/providers/audio_provider.dart';

class AudioPlayerScreen extends ConsumerStatefulWidget {
  final String audioBookId;
  const AudioPlayerScreen({super.key, required this.audioBookId});
  static const path = 'audio-player';

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends ConsumerState<AudioPlayerScreen> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final audioBookId = widget.audioBookId;
    final bookDetailsAsync = ref.watch(audioBookDetailsProvider(audioBookId));
    _audioPlayer
        .setAudioSource(ConcatenatingAudioSource(children: [
      AudioSource.uri(Uri.parse(
          '${bookDetailsAsync.value!.mp3Location}/${bookDetailsAsync.value!.audioBook!.mp3!.file}')),
    ]))
        .catchError((error) {
      // catch load errors: 404, invalid url ...
      if (kDebugMode) {
        print("An error occured $error");
      }
      return null;
    });

    return bookDetailsAsync.when(
      data: (data) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(
              color: Colors.white, //change your color here
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Image.network(
                  'https://aptmbeta.s3.ap-southeast-1.amazonaws.com/mp3/images/${data.audioBook!.coverPhoto}',
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    // This function is called when the image fails to load
                    // Return a new widget to display a dummy image from the internet
                    return Image.network(
                      'https://via.placeholder.com/500x250.png?text=Image+Failed+to+Load',
                    );
                  },
                ),
                const SizedBox(
                  height: 49,
                ),
                Text(
                  data.audioBook!.title.toString(),
                  style: const TextStyle(
                      color: Color(0xff222222),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  data.audioBook!.author.toString(),
                  style: const TextStyle(
                      color: Color(0xff666666),
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Poppins'),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: size.width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        data.audioBook!.description.toString(),
                        style: const TextStyle(
                            color: Color(0xff666666),
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppins'),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                PlayerButtons(_audioPlayer),
                //               assetsAudioPlayer.open(
//     Audio("assets/audios/song1.mp3"),
// ),
                const SizedBox(
                  height: 48,
                ),
                const SizedBox(
                  height: 48,
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stackTrace) => Text('Error: $error'),
    );
  }
}
