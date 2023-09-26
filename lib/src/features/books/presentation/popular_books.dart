import 'package:aptm/gen/assets.gen.dart';
import 'package:aptm/src/features/books/presentation/book_detail_screen.dart';
import 'package:aptm/src/features/main/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PopularBooksScreen extends StatelessWidget {
  const PopularBooksScreen({super.key});
  static const path = 'popular_books';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff0000ff),
          title: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Popular Books',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                // color: Color(0xff222222),
              ),
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                return context
                    .go('${HomeScreen.path} + ${BookDetailScreen.path}');
              },
              child: Container(
                height: 135,
                width: size.width,
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
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
                          'https://images.unsplash.com/photo-1532012197267-da84d127e765?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
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
                        const Text(
                          'The Girl with the Dragon',
                          style: TextStyle(
                              color: Color(0xff222222),
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                        const Text(
                          'Muharrem Kavak',
                          style: TextStyle(
                              color: Color(0xff666666),
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.normal),
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.star_rounded,
                              color: Color(0xfff2ad70),
                              size: 18,
                            ),
                            Icon(
                              Icons.star_rounded,
                              color: Color(0xfff2ad70),
                              size: 18,
                            ),
                            Icon(
                              Icons.star_outline_rounded,
                              color: Color(0xfff2ad70),
                              size: 18,
                            ),
                            Icon(
                              Icons.star_outline_rounded,
                              color: Color(0xfff2ad70),
                              size: 18,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '4.5',
                              style: TextStyle(
                                  color: Color(0xff222222),
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color(0xfffee6e6)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: const BorderSide(
                                      color: Color(0xfffee6e6),
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'Paid',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins',
                                  color: Color(0xff870e0e),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                'Popular',
                                style: TextStyle(
                                  color: Color(0xff277dcd),
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )));
  }
}
