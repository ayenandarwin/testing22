import 'package:aptm/src/features/audio_books/presentation/screens/audio_detail_screen.dart';
import 'package:aptm/src/features/main/home_screen.dart';
import 'package:aptm/src/features/profile/data/providers/profile_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AudioFav extends ConsumerWidget {
  const AudioFav({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioFav = ref.watch(profileFav);

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
        audioFav.when(
          data: (data) {
            if (data.favorites[0].audio.isEmpty || data.favorites.isEmpty) {
              return Container();
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: data.favorites[0].audio.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {
                          // ignore: prefer_interpolation_to_compose_strings
                          return context.go(HomeScreen.path +
                              AudioDetailScreen.path +
                              '/' +
                              data.favorites[0].audio[index].id.toString());
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
                                  child: data.favorites[0].audio[index]
                                              .coverPhoto !=
                                          null
                                      ? Image.network(
                                          'https://aptmbeta.s3.ap-southeast-1.amazonaws.com/mp3/images/${data.favorites[0].audio[index].coverPhoto}',
                                          height: 250.0,
                                          width: 80.0,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          'https://dummyimage.com/250x80/cccccc/000000',
                                          height: 250.0,
                                          width: 80.0,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    data.favorites[0].audio[index].title,
                                    style: const TextStyle(
                                        color: Color(0xff222222),
                                        fontFamily: 'Poppins',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    data.favorites[0].audio[index].author!,
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
                                        data.favorites[0].audio[index].rate
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
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.headphones,
                                            size: 18,
                                          ),
                                          Text(
                                            data.favorites[0].audio[index]
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
