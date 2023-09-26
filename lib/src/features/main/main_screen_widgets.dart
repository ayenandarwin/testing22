import 'package:aptm/src/features/addons/presentation/addons_screen.dart';
import 'package:aptm/src/features/auth/data/providers/login_provider.dart';
import 'package:aptm/src/features/auth/presentation/screens/login_screen.dart';
import 'package:aptm/src/features/books/data/providers/books_provider.dart';
import 'package:aptm/src/features/books/presentation/book_detail_screen.dart';
import 'package:aptm/src/features/books/presentation/book_gallery.dart';
import 'package:aptm/src/features/books/presentation/new_added.dart';
import 'package:aptm/src/features/books/presentation/popular_books.dart';
import 'package:aptm/src/features/main/home_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:aptm/gen/assets.gen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import '../profile/data/providers/profile_detail_provider.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: prefer_generic_function_type_aliases
typedef void IntCallback(int id);

class MainScreenWidget extends ConsumerWidget {
  final IntCallback onIndexChanged;
  const MainScreenWidget({super.key, required this.onIndexChanged});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.refresh(profilDetailsProvider);
    final newBooks = ref.watch(newAddedBooksProvider);
    final books = ref.watch(booksProvider);
    final popularBooks = ref.watch(popularBooksProvider);
    final adds = ref.watch(addsProvider);
    final size = MediaQuery.of(context).size;
    const storage = FlutterSecureStorage();
    final username = storage.read(key: 'username');
    usernamedata(ref);

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.only(top: 40, bottom: 20, left: 0, right: 0),
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: FutureBuilder(
                        future: usernamedata(ref),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator(); // Show a loading indicator while fetching the name
                          } else if (snapshot.hasError) {
                            return const Text(
                                'Error fetching username'); // Handle error state
                          } else {
                            final username = snapshot.data;
                            return Container(
                                margin: const EdgeInsets.only(right: 16),
                                child: Text(
                                  'Hi, $username',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  ),
                                ));
                          }
                        }),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'What are you gonna listen today?',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Poppins',
                      color: Color(0xff666666),
                    ),
                  ),
                  SizedBox(
                    width: size.width,
                    height: 135,
                    child: adds.when(
                      data: (data) {
                        return CarouselSlider.builder(
                          itemCount: data.adds?.length,
                          itemBuilder: (context, index, realIndex) {
                            String uri = data.adds![index].image;
                            final UriData? data1 = Uri.parse(uri).data;
                            Uint8List image = data1!.contentAsBytes();
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: InkWell(
                                onTap: () async {
                                  var url = Uri.parse(data.adds![index].link);
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: Container(
                                  height: 135,
                                  width: 340,
                                  decoration: const BoxDecoration(
                                    color: Color(0xfff5faff),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Image.memory(
                                            image,
                                            fit: BoxFit.cover,
                                            errorBuilder: (BuildContext context,
                                                Object exception,
                                                StackTrace? stackTrace) {
                                              // This function is called when the image fails to load
                                              // Return a new widget to display a placeholder image
                                              return Image.network(
                                                'https://via.placeholder.com/250x250.png?text=Image+Failed+to+Load',
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.adds![index].title,
                                              style: const TextStyle(
                                                color: Color(0xff222222),
                                                fontFamily: 'Poppins',
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            height: 135,
                            aspectRatio: 340 / 135,
                            enableInfiniteScroll: true,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            pauseAutoPlayOnTouch: true,
                            viewportFraction: 0.9,
                          ),
                        );
                      },
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      error: (error, stackTrace) => Text('Error: $error'),
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   margin: const EdgeInsets.only(bottom: 40),
            //   width: size.width,
            //   height: 95,
            //   color: const Color(0xffd9d9d9),
            // ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Popular Books',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: Color(0xff222222),
                        ),
                      ),
                      // InkWell(
                      //   onTap: () async {
                      //     // return context
                      //     //     .go(HomeScreen.path + PopularBooksScreen.path);
                      //   },
                      //   child: const Text(
                      //     'View All',
                      //     style: TextStyle(
                      //       fontSize: 16,
                      //       fontWeight: FontWeight.normal,
                      //       fontFamily: 'Poppins',
                      //       color: Color(0xff222222),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                      width: size.width,
                      height: 135,
                      child: popularBooks.when(
                        data: (data) {
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.books.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: InkWell(
                                      onTap: () async {
                                        return context.go(
                                            '${HomeScreen.path}${BookDetailScreen.path}/${data.books[index].id}');
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        decoration: const BoxDecoration(
                                            color: Color(0xfff5faff),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.network(
                                                  'https://aptmbeta.s3.ap-southeast-1.amazonaws.com/pdf/images/${data.books[index].coverPhoto}',
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.13,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.21,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (BuildContext
                                                          context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                    // This function is called when the image fails to load
                                                    // Return a new widget to display a dummy image from the internet
                                                    return Image.network(
                                                      'https://via.placeholder.com/250x250.png?text=Image+Failed+to+Load',
                                                      fit: BoxFit.cover,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.13,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.21,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 4),
                                                  child: Text(
                                                    data.books[index].title,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xff222222),
                                                        fontFamily: 'Poppins',
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  data.books[index].author,
                                                  style: const TextStyle(
                                                      color: Color(0xff666666),
                                                      fontFamily: 'Poppins',
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                                SizedBox(
                                                  height: 4,
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
                                                      Icons
                                                          .star_outline_rounded,
                                                      color: Color(0xfff2ad70),
                                                      size: 15,
                                                    ),
                                                    const Icon(
                                                      Icons
                                                          .star_outline_rounded,
                                                      color: Color(0xfff2ad70),
                                                      size: 15,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    // Text(
                                                    //   data.books[index].rate
                                                    //       .toString(),
                                                    //   style: const TextStyle(
                                                    //       color:
                                                    //           Color(0xff222222),
                                                    //       fontFamily: 'Poppins',
                                                    //       fontSize: 12,
                                                    //       fontWeight:
                                                    //           FontWeight.bold),
                                                    // )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      height: 30,
                                                      child: TextButton(
                                                        style: ButtonStyle(
                                                          foregroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(
                                                                      Colors
                                                                          .white),
                                                          backgroundColor:
                                                              MaterialStateProperty.all<
                                                                      Color>(
                                                                  const Color(
                                                                      0xfffee6e6)),
                                                          shape: MaterialStateProperty
                                                              .all<
                                                                  RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              side:
                                                                  const BorderSide(
                                                                color: Color(
                                                                    0xfffee6e6),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        onPressed: () {},
                                                        child: Text(
                                                          data.books[index]
                                                              .packagePlan,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Color(
                                                                0xff870e0e),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.all(16.0),
                                                      child: Text(
                                                        'Popular',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff277dcd),
                                                          fontFamily: 'Poppins',
                                                          fontSize: 10,
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
                                    ));
                              });
                        },
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        error: (error, stackTrace) => Text('Error: $error'),
                      )),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Newely Added',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: Color(0xff222222),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          return context
                              .go(HomeScreen.path + NewAddedScreen.path);
                        },
                        child: const Text(
                          'View All',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppins',
                            color: Color(0xff222222),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                      width: size.width,
                      height: size.height * 0.18,
                      child: newBooks.when(
                        data: (data) => ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.books.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Column(
                                children: [
                                  Container(
                                    height: 110,
                                    width: 80,
                                    decoration: const BoxDecoration(
                                      color: Color(0xfff5faff),
                                      // borderRadius: BorderRadius.all(
                                      //     Radius.circular(10))
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        return context.go(
                                            '${HomeScreen.path}${BookDetailScreen.path}/${data.books[index].id}');
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                          color:
                                              Color.fromARGB(0, 223, 227, 230),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            data.pdfImageLocation +
                                                data.books[index].coverPhoto,
                                            height: 250.0,
                                            width: 90.0,
                                            fit: BoxFit.cover,
                                            errorBuilder: (BuildContext context,
                                                Object exception,
                                                StackTrace? stackTrace) {
                                              // This function is called when the image fails to load
                                              // Return a new widget to display a dummy image from the internet
                                              return Image.network(
                                                'https://via.placeholder.com/250x250.png?text=Image+Failed+to+Load',
                                                fit: BoxFit.cover,
                                                height: 250.0,
                                                width: 100.0,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Text(
                                  //   data.books[index].title.length > 10
                                  //       ? '${data.books[index].title.substring(0, 10)}..'
                                  //       : data.books[index].title,
                                  // ),
                                ],
                              ),
                            );
                          },
                        ),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        error: (error, stackTrace) => Text('Error: $error'),
                      )
                      // child: ListView.builder(
                      //   scrollDirection: Axis.horizontal,
                      //   itemCount: 20,
                      //   itemBuilder: (context, index) {
                      //     return Padding(
                      //         padding: const EdgeInsets.all(10),
                      //         child: Container(
                      //           height: 120,
                      //           width: 98,
                      //           decoration: const BoxDecoration(
                      //               color: Color(0xfff5faff),
                      //               borderRadius:
                      //                   BorderRadius.all(Radius.circular(10))),
                      //           child: InkWell(
                      //             onTap: () {
                      //               return context.go(
                      //                   HomeScreen.path + BookDetailScreen.path);
                      //             },
                      //             child: Container(
                      //               margin: const EdgeInsets.all(20),
                      //               alignment: Alignment.center,
                      //               decoration: const BoxDecoration(
                      //                 color: Colors.blue,
                      //               ),
                      //               child: ClipRRect(
                      //                 child: Image.asset(
                      //                   Assets.images.book1.path,
                      //                   height: 250.0,
                      //                   width: 100.0,
                      //                   fit: BoxFit.cover,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ));
                      //   },
                      // ),
                      ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              width: size.width,
              decoration: const BoxDecoration(
                  color: Color(0xff683a6e),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                        margin: const EdgeInsets.only(left: 16),
                        child:
                            Image.asset(Assets.images.dictionaryAmico1.path)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 18, left: 48, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'Don’t judge a book by it cover',
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins',
                              color: Color(0xffffffcc),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Book Library',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Poppins',
                              color: Color(0xffffff00),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          const Text(
                            '10,000 books',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              color: Color(0xffffffcc),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: SizedBox(
                                  height: 30,
                                  child: TextButton(
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              const Color(0xffffff00)),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: const BorderSide(
                                            color: Color(0xffffff00),
                                          ),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      onIndexChanged(1);
                                    },
                                    child: const Text(
                                      'Read Now',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Poppins',
                                        color: Color(0xff000066),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              width: size.width,
              decoration: const BoxDecoration(
                color: Color(0xff025d5e),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                        margin: const EdgeInsets.only(left: 16),
                        child: Image.asset(Assets.images.audiobookBro1.path)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 18, left: 48),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'Listen to all your favorite authors.',
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins',
                              color: Color(0xffccccff),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Audio Book Library',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Poppins',
                              color: Color(0xffffffff),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          const Text(
                            '10,000 books',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              color: Color(0xffffffff),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 16, bottom: 10),
                                child: SizedBox(
                                  height: 30,
                                  child: TextButton(
                                      style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                const Color(0xff333300)),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: const BorderSide(
                                              color: Color(0xff333300),
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        onIndexChanged(2);
                                      },
                                      child: const Text(
                                        'Listen Now',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Poppins',
                                          color: Color(0xffffffff),
                                        ),
                                      )),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              width: size.width,
              decoration: const BoxDecoration(
                color: Color(0xff00257a),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                        margin: const EdgeInsets.only(left: 16),
                        child:
                            Image.asset(Assets.images.videoUploadRafiki1.path)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 18, left: 48),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'Feed your brain with APTM',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins',
                              color: Color(0xffccccff),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Video Library',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Poppins',
                              color: Color(0xffffffff),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          const Text(
                            '2,000 books',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              color: Color(0xffffffff),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 16, bottom: 10),
                                child: SizedBox(
                                  height: 30,
                                  child: TextButton(
                                      style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: const BorderSide(
                                              color: Color(0xffffffff),
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        onIndexChanged(3);
                                      },
                                      child: const Text(
                                        'Watch Now',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Poppins',
                                          color: Color(0xff000066),
                                        ),
                                      )),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 40),
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
                  Expanded(
                    flex: 1,
                    child: Container(
                        margin: const EdgeInsets.only(left: 16),
                        child: Image.asset(Assets.images.thesisPana1.path)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 18, left: 48),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'Add-on Services',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Poppins',
                              color: Color(0xff222222),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          const Text(
                            '2,000 books',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins',
                              color: Color(0xff666666),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          const Text(
                            '180 Authors',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins',
                              color: Color(0xff666666),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 16, bottom: 5),
                                child: SizedBox(
                                  child: TextButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: const BorderSide(
                                              color: Color(0xff333300),
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        return context.go(HomeScreen.path +
                                            AddonsScreen.path);
                                      },
                                      child: const Text(
                                        'Learn More',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Poppins',
                                          color: Color(0xff333300),
                                        ),
                                      )),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 40),
              width: size.width,
              color: const Color(0xfff5faff),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Books Gallery',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Color(0xff222222),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            return context
                                .go(HomeScreen.path + BookGalleryScreen.path);
                          },
                          child: const Text(
                            'View All',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins',
                              color: Color(0xff222222),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  books.when(data: (books) {
                    return Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          //childAspectRatio: (100 / 134),
                          childAspectRatio: 0.7,
                          crossAxisCount: 3,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          children: List.generate(
                              9,
                              (index) => Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          //height: 110,
                                          height: size.height * 0.14,
                                          width: 90,
                                          decoration: const BoxDecoration(
                                            color: Color(0xfff5faff),
                                            // borderRadius: BorderRadius.all(
                                            //     Radius.circular(10))
                                          ),
                                          child: InkWell(
                                            onTap: () async {
                                              return context.go(
                                                  '${HomeScreen.path}${BookDetailScreen.path}/${books.books[index].id}');
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    0, 223, 227, 230),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.network(
                                                  books.pdfImageLocation +
                                                      books.books[index]
                                                          .coverPhoto,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.14,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.23,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (BuildContext
                                                          context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                    // This function is called when the image fails to load
                                                    // Return a new widget to display a dummy image from the internet
                                                    return Image.network(
                                                      'https://via.placeholder.com/250x250.png?text=Image+Failed+to+Load',
                                                      fit: BoxFit.cover,
                                                      // height: 250.0,
                                                      // width: 100.0,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.14,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.23,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Text(
                                        //   books.books[index].title.length > 10
                                        //       ? '${books.books[index].title.substring(0, 10)}..'
                                        //       : books.books[index].title,
                                        // ),
                                      ],
                                    ),
                                  )),
                        ));
                  }, loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }, error: (e, _) {
                    return const Center(
                      child: Text('Error'),
                    );
                  }),
                  // Container(
                  //     padding: const EdgeInsets.only(left: 16, right: 16),
                  //     child: GridView.count(
                  //       physics: const NeverScrollableScrollPhysics(),
                  //       shrinkWrap: true,
                  //       childAspectRatio: (109 / 134),
                  //       crossAxisCount: 3,
                  //       crossAxisSpacing: 20,
                  //       mainAxisSpacing: 20,
                  //       children: List.generate(
                  //         9,
                  //         (index) => InkWell(
                  //           onTap: () {
                  //             return context.go(
                  //                 '${HomeScreen.path}${BookDetailScreen.path}/${ref.watch(booksProvider).when(
                  //                       data: (books) => books.books[index].id,
                  //                       loading: () => '',
                  //                       error: (e, _) => throw e,
                  //                     )}');
                  //           },
                  //           child: ClipRRect(
                  //             borderRadius: BorderRadius.circular(8.0),
                  //             child: Image.network(
                  //               ref.watch(booksProvider).when(
                  //                     data: (books) =>
                  //                         books.pdfImageLocation +
                  //                         books.books[index].coverPhoto,
                  //                     loading: () => '',
                  //                     error: (e, _) => throw e,
                  //                   ),
                  //               height: 250.0,
                  //               width: 100.0,
                  //               fit: BoxFit.cover,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> usernamedata(WidgetRef ref) async {
    final username = await storage.read(key: 'username');
    print('$username eijfiehefh');
    return username ?? '';
    // You can use the `username` value in further operations or assignments if needed
  }
}

// Future<void> _dialogBuilder(BuildContext context, WidgetRef ref) {
//   return showDialog<void>(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text(
//           'Logout',
//           style: TextStyle(color: Colors.red),
//         ),
//         content: const Text('Login Again'),
//         actions: <Widget>[
//           TextButton(
//             child: const Text(
//               'Login',
//               style: TextStyle(color: Colors.red),
//             ),
//             onPressed: () async {
//               await ref.read(loginProvider.notifier).logout();
//               return context.go(LoginScreen.path);
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
