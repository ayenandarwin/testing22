import 'package:aptm/src/features/books/presentation/book_detail_screen.dart';
import 'package:aptm/src/features/main/home_screen.dart';
import 'package:aptm/src/features/profile/data/providers/profile_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BookFav extends ConsumerWidget {
  const BookFav({Key? key}) : super(key: key);
  static const path = 'favscreen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.refresh(
        profileFav); // Refresh the profileFav provider to reload the data

    final profleFav = ref.watch(profileFav);
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        profleFav.when(
          data: (data) {
            if (data.favorites.isEmpty || data.favorites[0].book.isEmpty) {
              return Container();
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: data.favorites[0].book.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {
                          return context.go(
                            '${HomeScreen.path}${BookDetailScreen.path}/${data.favorites[0].book[index].id}',
                          );
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
                                  0,
                                  2,
                                ), // changes position of shadow
                              ),
                            ],
                            color: const Color(0xfff5faff),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    data.favorites[0].book[index].title,
                                    style: const TextStyle(
                                      color: Color(0xff222222),
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    data.favorites[0].book[index].author!,
                                    style: const TextStyle(
                                      color: Color(0xff666666),
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
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
                                        data.favorites[0].book[index].rate
                                            .toString(),
                                        style: const TextStyle(
                                          color: Color(0xff222222),
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
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
                                            Colors.white,
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                            const Color(0xffe5ffed),
                                          ),
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
