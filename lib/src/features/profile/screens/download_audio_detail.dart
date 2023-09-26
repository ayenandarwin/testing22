import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';

import 'download_audio_player.dart';

class DownloadAudioDetail extends ConsumerWidget {
  final String audioBookId;
  final String description;
  final String title;
  const DownloadAudioDetail(
      {super.key,
      required this.audioBookId,
      required this.description,
      required this.title});
  static const path = 'download-audio-detail';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
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
              title,
              // data.audioBook.title,
              style: const TextStyle(
                  color: Color(0xff222222),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              '',
              // data.audioBook.author,
              style: TextStyle(
                  color: Color(0xff666666),
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins'),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.visibility_rounded),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Read',
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'),
                        ),
                        // Text(
                        //   '',
                        //   // 'data.audioBook.read.length.toString(),'
                        //   style: const TextStyle(
                        //       color: Color(0xff666666),
                        //       fontSize: 13,
                        //       fontWeight: FontWeight.normal,
                        //       fontFamily: 'Poppins'),
                        // ),
                      ],
                    )
                  ],
                ),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.star_half_rounded,
                      color: Color(0xffdd8538),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Rating',
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'),
                        ),
                        // Text(
                        //   '',
                        //   // data.audioBook.rate.toString(),
                        //   style: const TextStyle(
                        //       color: Color(0xff666666),
                        //       fontSize: 13,
                        //       fontWeight: FontWeight.normal,
                        //       fontFamily: 'Poppins'),
                        // ),
                      ],
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        // ref.read(bookFavProvider(bookId));
                        // ref.watch(audioFavProvider(audioBookId)).when(
                        //       data: (data) {
                        //         print(data.msg);
                        //         return const SnackBar(content: Text('haha'));
                        //       },
                        //       loading: () => const CircularProgressIndicator(),
                        //       error: (error, stackTrace) =>
                        //           Text('Error: $error'),
                        //     );
                      },
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Favorite',
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'),
                        ),
                        // Text(
                        //   '',
                        //   // data.audioBook.favorite.length.toString(),
                        //   style: const TextStyle(
                        //       color: Color(0xff666666),
                        //       fontSize: 13,
                        //       fontWeight: FontWeight.normal,
                        //       fontFamily: 'Poppins'),
                        // ),
                      ],
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () async {
                        // final downloadBook = await ref
                        //     .read(audioDownloadProvider(audioBookId).future);
                        // if (downloadBook.success == true) {
                        //   ref.read(profileDownload);
                        // }
                        // showDialog(
                        //   context: context,
                        //   builder: (context) => DownloadingDialog(
                        //     urllink:
                        //         '${data.mp3Location}/${data.audioBook.mp3.file}',
                        //     file: '${data.audioBook.id}.mp3',
                        //   ),
                        // );
                      },
                      child: const Icon(
                        Icons.download,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Download',
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'),
                        ),
                        // Text(
                        //   '',
                        //   // data.audioBook.download.length.toString(),
                        //   style: const TextStyle(
                        //       color: Color(0xff666666),
                        //       fontSize: 13,
                        //       fontWeight: FontWeight.normal,
                        //       fontFamily: 'Poppins'),
                        // )
                      ],
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: size.width * 0.4,
                  height: 45,
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xff0000ff),
                      ),
                    ),
                    onPressed: () async {
                      final dirlocation =
                          await getApplicationDocumentsDirectory();
                      final String dir = dirlocation.path;
                      String trimmedPath =
                          dir.replaceAll('/', 'removeblackslap');
                      return context.go(
                          '/${DownloadAudioPlayer.path}/$audioBookId/$title/$description/$trimmedPath');
                    },
                    icon: const Icon(
                      Icons.headphones,
                      size: 24.0,
                    ),
                    label: const Text(
                      'Play audio',
                      style: TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 48,
            ),
            SizedBox(
              width: size.width * 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description',
                    style: TextStyle(
                        color: Color(0xff222222),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins'),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                        color: Color(0xff666666),
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Poppins'),
                  ),
                ],
              ),
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
