import 'package:aptm/src/features/audio_books/data/providers/audio_provider.dart';
import 'package:aptm/src/features/audio_books/presentation/widgets/player_buttons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

class DownloadAudioPlayer extends ConsumerStatefulWidget {
  final String audioBookId;
  final String description;
  final String title;
  final String dir;
  const DownloadAudioPlayer(
      {super.key,
      required this.audioBookId,
      required this.description,
      required this.title,
      required this.dir});
  static const path = 'download-audio-player';

  @override
  _DownloadAudioPlayerState createState() => _DownloadAudioPlayerState();
}

class _DownloadAudioPlayerState extends ConsumerState<DownloadAudioPlayer> {
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
    final audioBookId = widget.dir;
    String trimmedPath = audioBookId.replaceAll('removeblackslap', '/');
    _audioPlayer
        .setAudioSource(ConcatenatingAudioSource(children: [
      AudioSource.uri(Uri.parse('$trimmedPath/${widget.audioBookId}.mp3')),
    ]))
        .catchError((error) {
      // catch load errors: 404, invalid url ...
      if (kDebugMode) {
        print("An error occured $error");
      }
      return null;
    });

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
              '',
              // 'https://aptmbeta.s3.ap-southeast-1.amazonaws.com/mp3/images/${data.audioBook.coverPhoto}',
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
              widget.title,
              style: const TextStyle(
                  color: Color(0xff222222),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'),
            ),
            const SizedBox(
              height: 8,
            ),
            // Text(
            //   data.audioBook.author,
            //   style: const TextStyle(
            //       color: Color(0xff666666),
            //       fontSize: 16,
            //       fontWeight: FontWeight.normal,
            //       fontFamily: 'Poppins'),
            // ),
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
                    widget.description,
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
  }
}
