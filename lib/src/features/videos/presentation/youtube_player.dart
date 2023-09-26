import 'package:aptm/src/features/videos/data/providers/video_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends ConsumerWidget {
  final String videoBookId;
  const VideoPlayerScreen({super.key, required this.videoBookId});
  static const path = 'video-detail';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookDetailsAsync = ref.watch(videoBookDetailsProvider(videoBookId));
    return bookDetailsAsync.when(
      data: (data) => Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(
              color: Colors.white, //change your color here
            ),
          ),
          body: GestureDetector(
            onTap: () {
              SystemChrome.setPreferredOrientations(
                  [DeviceOrientation.landscapeLeft]);
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                  overlays: []);
            },
            child: Center(
              child: YoutubePlayerBuilder(
                  player: YoutubePlayer(
                    controller: YoutubePlayerController(
                      initialVideoId:
                          Uri.parse(data.videoBook.mp4.file).pathSegments.last,
                      flags: const YoutubePlayerFlags(
                        autoPlay: true,
                        mute: false,
                      ),
                    ),
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.blueAccent,
                  ),
                  builder: (context, player) {
                    return Column(
                      children: [
                        Expanded(child: player),
                      ],
                    );
                  }),
            ),
          )),
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stackTrace) => Text('Error: $error'),
    );
  }
}
