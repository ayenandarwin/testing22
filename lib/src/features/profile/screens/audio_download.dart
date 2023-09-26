import 'dart:io';

import 'package:aptm/src/features/profile/data/providers/profile_detail_provider.dart';
import 'package:aptm/src/features/profile/screens/download_audio_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class AudioDownload extends ConsumerWidget {
  const AudioDownload({super.key});
  static const path = 'favscreen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadlocal = ref.watch(downloadLocal);
    Future<String> _getFilePath() async {
      final dir = await getApplicationDocumentsDirectory();
      final filePath = dir.path;
      return filePath;
    }

    void someFunction() async {
      final filePath = await _getFilePath();
      print(filePath);
    }

    return Column(
      children: [
        // Container(
        //   padding: const EdgeInsets.only(left: 16),
        //   height: 50,
        //   child: ListView.builder(
        //       scrollDirection: Axis.horizontal,
        //       itemCount: 1,
        //       itemBuilder: (context, index) {
        //         return TextButton(
        //           style: ButtonStyle(
        //             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //               RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(50.0),
        //                 side: const BorderSide(
        //                   color: Color(0xffaaaaaa),
        //                 ),
        //               ),
        //             ),
        //           ),
        //           onPressed: () {},
        //           child: const Text(
        //             ' Marketing ',
        //             style: TextStyle(
        //                 fontSize: 13,
        //                 fontWeight: FontWeight.normal,
        //                 fontFamily: 'Poppins',
        //                 color: Color(0xff666666),
        //                 letterSpacing: 1),
        //           ),
        //         );
        //       }),
        // ),
        const SizedBox(
          height: 5,
        ),
        downloadlocal.when(
          data: (data) {
            if (data.downloads.isEmpty) {
              return Container();
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: data.downloads[0].audio.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () async {
                          return context.go(
                              '/${DownloadAudioDetail.path}/${data.downloads[0].audio[index].id}/${data.downloads[0].audio[index].title}/${data.downloads[0].audio[index].description}');
                        },
                        child: Container(
                          height: 135,
                          width: 340,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 5,
                                offset: const Offset(
                                    0, 2), // changes position of shadow
                              ),
                            ],
                            color: const Color(0xfff5faff),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    // ignore: unnecessary_null_comparison
                                    child: const SizedBox(
                                      height: 250.0,
                                      width: 80.0,
                                    )),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    data.downloads[0].audio[index].title,
                                    style: const TextStyle(
                                        color: Color(0xff222222),
                                        fontFamily: 'Poppins',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    data.downloads[0].audio[index].author,
                                    style: const TextStyle(
                                        color: Color(0xff666666),
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        color: Color(0xfff2ad70),
                                        size: 18,
                                      ),
                                      const Icon(
                                        Icons.star_rounded,
                                        color: Color(0xfff2ad70),
                                        size: 18,
                                      ),
                                      const Icon(
                                        Icons.star_outline_rounded,
                                        color: Color(0xfff2ad70),
                                        size: 18,
                                      ),
                                      const Icon(
                                        Icons.star_outline_rounded,
                                        color: Color(0xfff2ad70),
                                        size: 18,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        data.downloads[0].audio[index].rate
                                            .toString(),
                                        style: const TextStyle(
                                            color: Color(0xff222222),
                                            fontFamily: 'Poppins',
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  const Color(0xffe5ffed)),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              side: const BorderSide(
                                                color: Color(0xffe5ffed),
                                              ),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: const Text(
                                          'Free Book',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Poppins',
                                            color: Color(0xff0e8738),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => Text('Error: $error'),
        ),
      ],
    );
  }
}

class PdfViewerScreen extends StatelessWidget {
  final String filePath;

  const PdfViewerScreen({required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: SfPdfViewer.file(File(filePath)),
    );
  }
}
