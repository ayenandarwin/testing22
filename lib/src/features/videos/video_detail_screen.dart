import 'package:aptm/src/features/books/data/providers/books_provider.dart';
import 'package:aptm/src/features/videos/data/providers/video_provider.dart';
import 'package:aptm/src/features/videos/presentation/youtube_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../main/home_screen.dart';

class VideoDetailScreen extends ConsumerWidget {
  final String videoBookId;
  const VideoDetailScreen({super.key, required this.videoBookId});
  static const path = 'video-detail';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookDetailsAsync = ref.watch(videoBookDetailsProvider(videoBookId));
    final size = MediaQuery.of(context).size;
    return bookDetailsAsync.when(
      data: (data) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Wrap(
                          children: [
                            InkWell(
                              onTap: () async {
                                final favBook = await ref
                                    .read(bookFavProvider(videoBookId).future);
                                final snackbar =
                                    SnackBar(content: Text(favBook.msg));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                                if (favBook.msg ==
                                    'Successfully remove from favorite list !') {
                                  Set() {
                                    --data.videoBook.favorite.length;
                                  }
                                } else {
                                  ++data.videoBook.favorite.length;
                                }
                              },
                              child: const ListTile(
                                leading: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                                title: Text('Add to favorite list'),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const ListTile(
                                leading: Icon(Icons.turned_in),
                                title: Text('Save'),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const ListTile(
                                leading: Icon(Icons.ios_share),
                                title: Text('Share'),
                              ),
                            ),
                          ],
                        );
                      });
                },
                icon: const Icon(Icons.more_vert))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                'https://aptmbeta.s3.ap-southeast-1.amazonaws.com/mp4/images/${data.videoBook.coverPhoto}',
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                data.videoBook.title,
                style: const TextStyle(
                    color: Color(0xff222222),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
              ),
              const SizedBox(
                height: 8,
              ),
              // Text(
              //   data.videoBook.author,
              //   style: const TextStyle(
              //       color: Color(0xff666666),
              //       fontSize: 16,
              //       fontWeight: FontWeight.normal,
              //       fontFamily: 'Poppins'),
              // ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.visibility_rounded,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Read',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins'),
                          ),
                          Text(
                            data.videoBook.read.length.toString(),
                            style: const TextStyle(
                                color: Color(0xff666666),
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins'),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.star_half_rounded,
                        size: 15,
                        color: Color(0xffdd8538),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Rating',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins'),
                          ),
                          Text(
                            data.videoBook.rate.toString(),
                            style: const TextStyle(
                                color: Color(0xff666666),
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins'),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () async {
                          final favBook = await ref
                              .read(videoFavProvider(videoBookId).future);
                          final snackbar = SnackBar(content: Text(favBook.msg));
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          if (favBook.msg ==
                              'Successfully remove from favorite list !') {
                            Set() {
                              --data.videoBook.favorite.length;
                            }
                          } else {
                            ++data.videoBook.favorite.length;
                          }
                        },
                        child: const Icon(
                          Icons.favorite,
                          size: 15,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Favorite',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins'),
                          ),
                          Text(
                            data.videoBook.favorite.length.toString(),
                            style: const TextStyle(
                                color: Color(0xff666666),
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins'),
                          )
                        ],
                      )
                    ],
                  ),
                  // Container(
                  //   padding: const EdgeInsets.only(left: 10, right: 10),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       const Icon(
                  //         Icons.download,
                  //       ),
                  //       const SizedBox(
                  //         width: 10,
                  //       ),
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.end,
                  //         children: [
                  //           const Text(
                  //             'Download',
                  //             style: TextStyle(
                  //                 color: Color(0xff333333),
                  //                 fontSize: 13,
                  //                 fontWeight: FontWeight.w500,
                  //                 fontFamily: 'Poppins'),
                  //           ),
                  //           Text(
                  //             data.videoBook.download.length.toString(),
                  //             style: const TextStyle(
                  //                 color: Color(0xff666666),
                  //                 fontSize: 13,
                  //                 fontWeight: FontWeight.normal,
                  //                 fontFamily: 'Poppins'),
                  //           )
                  //         ],
                  //       )
                  //     ],
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: size.width * 0.9,
                height: 40,
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xff0000ff),
                    ),
                  ),
                  onPressed: () {
                    return context.go(
                        '${HomeScreen.path}${VideoDetailScreen.path}/${data.videoBook.id.toString()}/${VideoPlayerScreen.path}/${data.videoBook.id.toString()}');
                  },
                  icon: const Icon(
                    Icons.smart_display,
                    size: 20.0,
                  ),
                  label: const Text(
                    'Play video',
                    style: TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Poppins'),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
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
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins'),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      data.videoBook.description,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                          color: Color(0xff666666),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins'),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 48,
              ),
            ],
          ),
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
