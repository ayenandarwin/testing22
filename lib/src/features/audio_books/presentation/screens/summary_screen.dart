import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../data/providers/audio_provider.dart';

class SummaryScreen extends ConsumerWidget {
  final String audioBookId;
  const SummaryScreen({super.key, required this.audioBookId});
  static const path = 'audio-detail';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final bookDetailsAsync = ref.watch(audioBookDetailsProvider(audioBookId));
    final String htmlContent;

    return bookDetailsAsync.when(
      data: (data) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(child: Html(data: data.audioBook!.mp3!.summary)),
        ),
      ),
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stackTrace) => Text('Error: $error'),
    );
  }
}
