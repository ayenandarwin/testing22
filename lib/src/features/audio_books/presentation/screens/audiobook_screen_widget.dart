import 'package:aptm/src/features/audio_books/presentation/screens/audio_detail_screen.dart';
import 'package:aptm/src/features/main/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/providers/audio_provider.dart';

class AudioBookScreenWidget extends ConsumerWidget {
  const AudioBookScreenWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksAsyncValue = ref.watch(audioBooksProvider);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20, left: 16, bottom: 5),
          child: Row(
            children: const [
              Text(
                'Explore ',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Color(0xff666666)),
              ),
              Text(
                'Audio Books !',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Color(0xff0000ff)),
              ),
            ],
          ),
        ),
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
        booksAsyncValue.when(
          data: (books) => Expanded(
            child: ListView.builder(
              itemCount: books.audioBooks!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      // ignore: prefer_interpolation_to_compose_strings
                      return context.go(HomeScreen.path +
                          AudioDetailScreen.path +
                          '/' +
                          books.audioBooks![index].id.toString());
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width * 0.9,
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
                                child:
                                    // books.audioBooks![index].coverPhoto != null
                                    Image.network(
                                  books.mp3ImageLocation! +
                                      books.audioBooks![index].coverPhoto!,
                                  // height: 250.0,
                                  // width: 80.0,
                                  height:
                                      MediaQuery.of(context).size.height * 0.13,
                                  width:
                                      MediaQuery.of(context).size.width * 0.21,
                                  fit: BoxFit.cover,
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    // This function is called when the image fails to load
                                    // Return a new widget to display a dummy image from the internet
                                    return Image.network(
                                      'https://via.placeholder.com/250x250.png?text=Image+Failed+to+Load',
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.13,
                                      width: MediaQuery.of(context).size.width *
                                          0.21,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                )
                                // : Image.network(
                                //     'https://via.placeholder.com/250x250.png?text=Image+Failed+to+Load',
                                //     //  'https://th.bing.com/th?id=OSS.TOOL8B098D4A5DCC7698F911B3C98CA50C79354E5F52A38F23A36F86265116185B06&w=246&h=233&c=7&o=6&dpr=1.5&pid=Retail',
                                //     height:
                                //         MediaQuery.of(context).size.height *
                                //             0.13,
                                //     width: MediaQuery.of(context).size.width *
                                //         0.21,
                                //     fit: BoxFit.cover,
                                //   ),
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
                                books.audioBooks![index].title!,
                                style: const TextStyle(
                                    color: Color(0xff222222),
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                books.audioBooks![index].author!,
                                style: const TextStyle(
                                    color: Color(0xff666666),
                                    fontFamily: 'Poppins',
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    color: Color(0xfff2ad70),
                                    size: 15,
                                  ),
                                  const Icon(
                                    Icons.star_rounded,
                                    color: Color(0xfff2ad70),
                                    size: 15,
                                  ),
                                  const Icon(
                                    Icons.star_outline_rounded,
                                    color: Color(0xfff2ad70),
                                    size: 15,
                                  ),
                                  const Icon(
                                    Icons.star_outline_rounded,
                                    color: Color(0xfff2ad70),
                                    size: 15,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    books.audioBooks![index].rate.toString(),
                                    style: const TextStyle(
                                        color: Color(0xff222222),
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 30,
                                    child: TextButton(
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
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Poppins',
                                          color: Color(0xff0e8738),
                                        ),
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
                                        size: 15,
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        books.audioBooks![index].duration!,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Poppins',
                                          color: Color(0xff222222),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 35,
                                  ),
                                  const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 15,
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
          ),
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => Text('Error: $error'),
        ),
      ],
    );
  }
}
