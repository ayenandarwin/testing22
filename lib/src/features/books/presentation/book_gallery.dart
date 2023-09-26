import 'package:aptm/gen/assets.gen.dart';
import 'package:aptm/src/features/books/data/providers/books_provider.dart';
import 'package:aptm/src/features/books/presentation/book_detail_screen.dart';
import 'package:aptm/src/features/main/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BookGalleryScreen extends ConsumerWidget {
  const BookGalleryScreen({super.key});
  static const path = 'gallery';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
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
      body: Container(
        margin: const EdgeInsets.only(top: 40, left: 16, right: 16),
        child: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                childAspectRatio: (109 / 134),
                crossAxisCount: 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: List.generate(
                  ref
                      .watch(booksProvider)
                      .when(
                        data: (books) => books.books,
                        loading: () => [],
                        error: (e, _) => throw e,
                      )
                      .length,
                  (index) => InkWell(
                    onTap: () {
                      return context.go(
                          '${HomeScreen.path}${BookDetailScreen.path}/${ref.watch(booksProvider).when(
                                data: (books) => books.books[index].id,
                                loading: () => '',
                                error: (e, _) => throw e,
                              )}');
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        ref.watch(booksProvider).when(
                              data: (books) =>
                                  books.pdfImageLocation +
                                  books.books[index].coverPhoto,
                              loading: () => '',
                              error: (e, _) => throw e,
                            ),
                        height: 250.0,
                        width: 100.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
