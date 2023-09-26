import 'package:aptm/gen/assets.gen.dart';
import 'package:aptm/src/features/books/presentation/book_detail_screen.dart';
import 'package:aptm/src/features/main/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/providers/books_provider.dart';

class NewAddedScreen extends ConsumerWidget {
  const NewAddedScreen({super.key});
  static const path = 'new_added';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0000ff),
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Book Gallery',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              // color: Color(0xff222222),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: ref.watch(newAddedBooksProvider).when(
              data: (books) => books.books.length,
              error: (e, _) => throw e,
              loading: () {},
            ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                // ignore: prefer_interpolation_to_compose_strings
                return context.go(
                  HomeScreen.path +
                      BookDetailScreen.path +
                      '/' +
                      ref.watch(newAddedBooksProvider).when(
                            data: (books) => books.books[index].id,
                            error: (e, _) => throw e,
                            loading: () => '',
                          ),
                );
              },
              child: Container(
                // height: 135,
                // width: 340,
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: const Offset(0, 2), // changes position of shadow
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
                          ref.watch(newAddedBooksProvider).when(
                                    data: (books) => books.pdfImageLocation,
                                    error: (e, _) => throw e,
                                    loading: () => '',
                                  ) +
                              ref.watch(newAddedBooksProvider).when(
                                    data: (books) =>
                                        books.books[index].coverPhoto,
                                    error: (e, _) => throw e,
                                    loading: () => '',
                                  ),
                          height: MediaQuery.of(context).size.height * 0.13,
                          width: MediaQuery.of(context).size.width * 0.21,
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            // This function is called when the image fails to load
                            // Return a new widget to display a dummy image from the internet
                            return Image.network(
                              'https://via.placeholder.com/250x250.png?text=Image+Failed+to+Load',
                              height: MediaQuery.of(context).size.height * 0.13,
                              width: MediaQuery.of(context).size.width * 0.21,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ref.watch(newAddedBooksProvider).when(
                                data: (books) => books.books[index].title,
                                error: (e, _) => throw e,
                                loading: () => '',
                              ),
                          style: const TextStyle(
                              color: Color(0xff222222),
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          ref.watch(newAddedBooksProvider).when(
                                data: (books) => books.books[index].author,
                                error: (e, _) => throw e,
                                loading: () => '',
                              ),
                          style: const TextStyle(
                              color: Color(0xff666666),
                              fontFamily: 'Poppins',
                              fontSize: 10,
                              fontWeight: FontWeight.normal),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      borderRadius: BorderRadius.circular(8.0),
                                      side: const BorderSide(
                                        color: Color(0xffe5ffed),
                                      ),
                                    ),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  ref.watch(newAddedBooksProvider).when(
                                            data: (books) =>
                                                books.books[index].free,
                                            error: (e, _) => throw e,
                                            loading: () {
                                              return false;
                                            },
                                          )
                                      ? 'Free'
                                      : 'Paid',
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
      // Container(
      //   margin: const EdgeInsets.only(top: 40, left: 16, right: 16),
      //   child: SingleChildScrollView(
      //     child: Container(
      //         padding: const EdgeInsets.only(left: 16, right: 16),
      //         child: GridView.count(
      //           physics: const NeverScrollableScrollPhysics(),
      //           shrinkWrap: true,
      //           childAspectRatio: (109 / 134),
      //           crossAxisCount: 3,
      //           crossAxisSpacing: 20,
      //           mainAxisSpacing: 20,
      //           children: List.generate(
      //             ref
      //                 .watch(newAddedBooksProvider)
      //                 .when(
      //                   data: (books) => books.books,
      //                   loading: () => [],
      //                   error: (e, _) => throw e,
      //                 )
      //                 .length,
      //             (index) => InkWell(
      //               onTap: () {
      //                 return context.go(
      //                     '${HomeScreen.path}${BookDetailScreen.path}/${ref.watch(newAddedBooksProvider).when(
      //                           data: (books) => books.books[index].id,
      //                           loading: () => '',
      //                           error: (e, _) => throw e,
      //                         )}');
      //               },
      //               child: ClipRRect(
      //                 borderRadius: BorderRadius.circular(8.0),
      //                 child: Image.network(
      //                   ref.watch(newAddedBooksProvider).when(
      //                         data: (books) =>
      //                             books.pdfImageLocation +
      //                             books.books[index].coverPhoto,
      //                         loading: () => '',
      //                         error: (e, _) => throw e,
      //                       ),
      //                   height: 250.0,
      //                   width: 100.0,
      //                   fit: BoxFit.cover,
      //                 ),
      //               ),
      //             ),
      //           ),
      //         )),
      //   ),
      // ),
    );
  }
}
