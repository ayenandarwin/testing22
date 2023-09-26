import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayerButtons extends StatefulWidget {
  const PlayerButtons(this._audioPlayer, {super.key});

  final AudioPlayer _audioPlayer;

  @override
  State<PlayerButtons> createState() => _PlayerButtonsState();
}

class _PlayerButtonsState extends State<PlayerButtons> {
  double _progressValue = 0.0;
  @override
  void initState() {
    super.initState();
    widget._audioPlayer.play();
    widget._audioPlayer.positionStream.listen((position) {
      final duration = widget._audioPlayer.duration;
      if (duration != null) {
        setState(() {
          _progressValue = position.inMilliseconds / duration.inMilliseconds;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final audioDuration = widget._audioPlayer.duration;

    return SizedBox(
      width: size.width * 0.9,
      child: Column(
        children: [
          LinearProgressIndicator(value: _progressValue),
          SizedBox(
            height: 32.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget._audioPlayer.position.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(widget._audioPlayer.position.inSeconds.remainder(60)).toString().padLeft(2, '0')}',
                  style: TextStyle(fontSize: 12.0),
                ),
                Text(
                  '${audioDuration?.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(widget._audioPlayer.duration?.inSeconds.remainder(60)).toString().padLeft(2, '0')}',
                  style: TextStyle(fontSize: 12.0),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              StreamBuilder<SequenceState?>(
                stream: widget._audioPlayer.sequenceStateStream,
                builder: (_, __) {
                  return _previousButton();
                },
              ),
              StreamBuilder<Duration>(
                stream: widget._audioPlayer.positionStream,
                builder: (_, __) {
                  return _previousSecodsButton();
                },
              ),
              StreamBuilder<PlayerState?>(
                stream: widget._audioPlayer.playerStateStream,
                builder: (_, snapshot) {
                  final playerState = snapshot.data;
                  final processingState = playerState?.processingState;
                  if (processingState == ProcessingState.loading ||
                      processingState == ProcessingState.buffering) {
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      width: 64.0,
                      height: 64.0,
                      child: const CircularProgressIndicator(),
                    );
                  } else if (widget._audioPlayer.playing != true) {
                    return IconButton(
                      icon: const Icon(Icons.play_arrow),
                      iconSize: 64.0,
                      onPressed: widget._audioPlayer.play,
                    );
                  } else if (processingState != ProcessingState.completed) {
                    return IconButton(
                      icon: const Icon(Icons.pause),
                      iconSize: 64.0,
                      onPressed: widget._audioPlayer.pause,
                    );
                  } else {
                    return IconButton(
                      icon: const Icon(Icons.replay),
                      iconSize: 64.0,
                      onPressed: () => widget._audioPlayer.seek(Duration.zero,
                          index: widget._audioPlayer.effectiveIndices!.first),
                    );
                  }
                  // return _playPauseButton(playerState!);
                },
              ),
              StreamBuilder<Duration>(
                stream: widget._audioPlayer.positionStream,
                builder: (_, __) {
                  return _skipSecondsButton();
                },
              ),
              StreamBuilder<SequenceState?>(
                stream: widget._audioPlayer.sequenceStateStream,
                builder: (_, __) {
                  return _nextButton();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget _playPauseButton(PlayerState playerState) {
  //   final processingState = playerState.processingState;
  //   if (processingState == ProcessingState.loading ||
  //       processingState == ProcessingState.buffering) {
  //     return Container(
  //       margin: const EdgeInsets.all(8.0),
  //       width: 64.0,
  //       height: 64.0,
  //       child: const CircularProgressIndicator(),
  //     );
  //   } else if (widget._audioPlayer.playing != true) {
  //     return IconButton(
  //       icon: const Icon(Icons.play_arrow),
  //       iconSize: 64.0,
  //       onPressed: widget._audioPlayer.play,
  //     );
  //   } else if (processingState != ProcessingState.completed) {
  //     return IconButton(
  //       icon: const Icon(Icons.pause),
  //       iconSize: 64.0,
  //       onPressed: widget._audioPlayer.pause,
  //     );
  //   } else {
  //     return IconButton(
  //       icon: const Icon(Icons.replay),
  //       iconSize: 64.0,
  //       onPressed: () => widget._audioPlayer.seek(Duration.zero,
  //           index: widget._audioPlayer.effectiveIndices!.first),
  //     );
  //   }
  // }

  Widget _shuffleButton(BuildContext context, bool isEnabled) {
    return IconButton(
      icon: isEnabled
          ? const Icon(Icons.shuffle, color: Colors.blueAccent)
          : const Icon(Icons.shuffle),
      onPressed: () async {
        final enable = !isEnabled;
        if (enable) {
          await widget._audioPlayer.shuffle();
        }
        await widget._audioPlayer.setShuffleModeEnabled(enable);
      },
    );
  }

  Widget _previousButton() {
    return IconButton(
      icon: const Icon(Icons.skip_previous),
      onPressed: widget._audioPlayer.hasPrevious
          ? widget._audioPlayer.seekToPrevious
          : null,
    );
  }

  Widget _previousSecodsButton() {
    return IconButton(
      icon: const Icon(Icons.replay_10),
      onPressed: () async {
        final currentPosition = await widget._audioPlayer.position;
        final newPosition = currentPosition - const Duration(seconds: 10);
        await widget._audioPlayer.seek(newPosition);
      },
    );
  }

  Widget _nextButton() {
    return IconButton(
      icon: const Icon(Icons.skip_next),
      onPressed:
          widget._audioPlayer.hasNext ? widget._audioPlayer.seekToNext : null,
    );
  }

  Widget _skipSecondsButton() {
    return IconButton(
      icon: Icon(Icons.forward_10),
      onPressed: () {
        widget._audioPlayer.seek(
            Duration(seconds: widget._audioPlayer.position.inSeconds + 10));
      },
    );
  }

  Widget _repeatButton(BuildContext context, LoopMode loopMode) {
    final icons = [
      const Icon(Icons.repeat),
      Icon(Icons.repeat, color: Theme.of(context).colorScheme.secondary),
      Icon(Icons.repeat_one, color: Theme.of(context).colorScheme.secondary),
    ];
    const cycleModes = [
      LoopMode.off,
      LoopMode.all,
      LoopMode.one,
    ];
    final index = cycleModes.indexOf(loopMode);
    return IconButton(
      icon: icons[index],
      onPressed: () {
        widget._audioPlayer.setLoopMode(
            cycleModes[(cycleModes.indexOf(loopMode) + 1) % cycleModes.length]);
      },
    );
  }
}
