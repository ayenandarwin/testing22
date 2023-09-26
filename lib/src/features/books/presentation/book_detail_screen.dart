import 'package:aptm/src/features/books/presentation/book_reader.dart';
import 'package:aptm/src/features/books/presentation/downloading_dialog.dart';
import 'package:aptm/src/features/main/home_screen.dart';
import 'package:aptm/src/features/profile/data/providers/profile_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/providers/books_provider.dart';

class BookDetailScreen extends ConsumerWidget {
  final String bookId;
  const BookDetailScreen({super.key, required this.bookId});
  static const path = 'book-detail';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookDetailsAsync = ref.watch(bookDetailsProvider(bookId));
    // final bookFavAsync = ref.read(bookFavProvider(bookId));
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
                                    .read(bookFavProvider(bookId).future);
                                final snackbar =
                                    SnackBar(content: Text(favBook.msg));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                                if (favBook.msg ==
                                    'Successfully remove from favorite list !') {
                                  Set() {
                                    --data.book.favorite.length;
                                  }
                                } else {
                                  ++data.book.favorite.length;
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
                            InkWell(
                              onTap: () async {
                                final downloadBook = await ref
                                    .read(bookDownloadProvider(bookId).future);
                                if (downloadBook.success == true) {
                                  ref.read(profileDownload);
                                }
                                showDialog(
                                  context: context,
                                  builder: (context) => DownloadingDialog(
                                    urllink:
                                        '${data.pdfLocation}/${data.book.pdf.file}',
                                    file: '${data.book.id}.pdf',
                                  ),
                                );
                              },
                              child: const ListTile(
                                leading: Icon(Icons.download),
                                title: Text('Download'),
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
                'http://ed-mypages.s3.amazonaws.com/pdf/images/${data.book.coverPhoto}',
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
                height: 30,
              ),
              Text(
                data.book.title,
                style: const TextStyle(
                    color: Color(0xff222222),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                data.book.author,
                style: const TextStyle(
                    color: Color(0xff666666),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Poppins'),
              ),
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
                            data.book.read.length.toString(),
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
                            '2',
                            // data.book.rate.toString(),
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
                          print('object');
                          // ref.read(bookFavProvider(bookId));
                          final favBook =
                              await ref.read(bookFavProvider(bookId).future);
                          final snackbar = SnackBar(content: Text(favBook.msg));
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          if (favBook.msg ==
                              'Successfully remove from favorite list !') {
                            Set() {
                              --data.book.favorite.length;
                            }
                          } else {
                            ++data.book.favorite.length;
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
                            data.book.favorite.length.toString(),
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
                          final downloadBook = await ref
                              .read(bookDownloadProvider(bookId).future);
                          if (downloadBook.success == true) {
                            ref.read(profileDownload);
                          }
                          showDialog(
                            context: context,
                            builder: (context) => DownloadingDialog(
                              urllink:
                                  '${data.pdfLocation}/${data.book.pdf.file}',
                              file: '${data.book.id}.pdf',
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.download,
                          size: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Download',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins'),
                          ),
                          Text(
                            data.book.download.length.toString(),
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
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: size.width * 0.9,
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xff0000ff),
                    ),
                  ),
                  onPressed: () {
                    // books.books[index].id.toString()
                    return context.go(
                        '${HomeScreen.path}${BookDetailScreen.path}/$bookId/${BookReader.path}/${data.book.id.toString()}');
                  },
                  icon: const Icon(
                    Icons.menu_book_outlined,
                    size: 20.0,
                  ),
                  label: const Text(
                    'Start Reading',
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
                      data.book.description,
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
