import 'package:aptm/src/features/books/presentation/book_detail_screen.dart';
import 'package:aptm/src/features/main/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/providers/books_provider.dart';

class BookScreenWidget extends ConsumerWidget {
  const BookScreenWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksAsyncValue = ref.watch(booksProvider);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20, left: 16, bottom: 5),
          child: const Row(
            children: [
              Text(
                'Explore ',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Color(0xff666666)),
              ),
              Text(
                'Books !',
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
              itemCount: books.books.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                    
                      // ignore: prefer_interpolation_to_compose_strings
                      return context.go(HomeScreen.path +
                          BookDetailScreen.path +
                          '/' +
                          books.books[index].id.toString());
                    },
                    child: Container(
                      // height: 120,
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width * 0.9,
                      //  width: 340,
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
                              child: Image.network(
                                books.pdfImageLocation +
                                    books.books[index].coverPhoto,
                                //  height: 250.0,
                                // height:

                                height:
                                    MediaQuery.of(context).size.height * 0.13,
                                width: MediaQuery.of(context).size.width * 0.21,
                                // width: 80.0,
                                fit: BoxFit.cover,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  // This function is called when the image fails to load
                                  // Return a new widget to display a dummy image from the internet
                                  return Image.network(
                                    'https://via.placeholder.com/250x250.png?text=Image+Failed+to+Load',
                                    height: MediaQuery.of(context).size.height *
                                        0.13,
                                    width: MediaQuery.of(context).size.width *
                                        0.21,
                                    fit: BoxFit.cover,
                                  );
                                },
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
                                books.books[index].title,
                                style: const TextStyle(
                                    color: Color(0xff222222),
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                books.books[index].author,
                                style: const TextStyle(
                                    color: Color(0xff666666),
                                    fontFamily: 'Poppins',
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 5,
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
                                    'rate',
                                    // books.books[index].rate.toString(),
                                    style: const TextStyle(
                                        color: Color(0xff222222),
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
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
                                      child: Text(
                                        books.books[index].free
                                            ? 'Free'
                                            : 'Paid',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Poppins',
                                          color: Color(0xff0e8738),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 140,
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
