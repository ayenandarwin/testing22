import 'package:aptm/src/features/main/home_screen.dart';
import 'package:aptm/src/features/profile/data/providers/profile_detail_provider.dart';
import 'package:aptm/src/features/videos/video_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class VideoFav extends ConsumerWidget {
  const VideoFav({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vidofav = ref.watch(profileFav);
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
        vidofav.when(
          data: (data) {
            if (data.favorites[0].video.isEmpty || data.favorites.isEmpty) {
              return Container();
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: data.favorites[0].video.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {
                          return context.go(
                              '${HomeScreen.path}${VideoDetailScreen.path}/${data.favorites[0].video[index].id}');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            height: 250,
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
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: Image.network(
                                    'https://aptmbeta.s3.ap-southeast-1.amazonaws.com/mp4/images/${data.favorites[0].video[index].coverPhoto}',
                                    height: 120.0,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        data.favorites[0].video[index].title,
                                        style: const TextStyle(
                                            color: Color(0xff222222),
                                            fontFamily: 'Poppins',
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      // Text(
                                      //  books.videoBooks[index].title,
                                      //   style: TextStyle(
                                      //       color: Color(0xff666666),
                                      //       fontFamily: 'Poppins',
                                      //       fontSize: 12,
                                      //       fontWeight: FontWeight.normal),
                                      // ),
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
                                            data.favorites[0].video[index].rate
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
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.white),
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      const Color(0xffe5ffed)),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  side: const BorderSide(
                                                    color: Color(0xffe5ffed),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onPressed: () {},
                                            child: const Text(
                                              'Free Video',
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'Poppins',
                                                color: Color(0xff0e8738),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.play_circle_fill,
                                                size: 18,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                data.favorites[0].video[index]
                                                    .duration!,
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xff222222),
                                                ),
                                              )
                                            ],
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
                                ),
                              ],
                            ),
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
