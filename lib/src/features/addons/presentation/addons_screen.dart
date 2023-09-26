import 'package:aptm/src/features/addons/presentation/addons_detail_screen.dart';
import 'package:aptm/src/features/addons/presentation/tag_bar.dart';
import 'package:aptm/src/features/books/data/providers/books_provider.dart';
import 'package:aptm/src/features/books/presentation/book_detail_screen.dart';
import 'package:aptm/src/features/main/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddonsScreen extends ConsumerWidget {
  const AddonsScreen({super.key});
  static const path = 'addons-screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addonsinfo = ref.watch(addons);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Addons'),
        backgroundColor: const Color(0xff0000ff),
      ),
      body: Column(
        children: [
          Column(
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
                      'Addons Service',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: Color(0xff0000ff)),
                    ),
                  ],
                ),
              ),
              const TabBarCus(),
            ],
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
          addonsinfo.when(
            data: (addon) => Expanded(
              child: ListView.builder(
                itemCount: addon.addons.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {
                        return context.go(
                            '/${AddonsScreen.path}/${AddonDetailScreen.path}/${addon.addons[index].id.toString()}');
                      },
                      child: Container(
                        height: 150,
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
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(200),
                                    child: Image.network(
                                      'https://via.placeholder.com/250x250.png?text=Image+Failed+to+Load',
                                      height: 100.0,
                                      width: 100.0,
                                      fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        // This function is called when the image fails to load
                                        // Return a new widget to display a dummy image from the internet
                                        return Image.network(
                                          'https://via.placeholder.com/250x250.png?text=Image+Failed+to+Load',
                                          height: 250.0,
                                          width: 80.0,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                // InkWell(
                                //   onTap: () {},
                                //   child: const Row(
                                //     children: [
                                //       Text(
                                //         'View All Book',
                                //         style: TextStyle(
                                //           fontSize: 16,
                                //           fontWeight: FontWeight.normal,
                                //           fontFamily: 'Poppins',
                                //           color: Color(0xff0000ff),
                                //         ),
                                //       ),
                                //       Icon(
                                //         Icons.keyboard_arrow_right,
                                //         color: Color(0xff0000ff),
                                //       )
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'author',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 119, 119, 119),
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    addon.addons[index].name,
                                    style: const TextStyle(
                                        color: Color(0xff222222),
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${addon.addons[index].books.length} series books',
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 22, 22, 22),
                                        fontFamily: 'Poppins',
                                        fontSize: 13,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  // const Row(
                                  //   children: [
                                  //      Icon(
                                  //       Icons.star_rounded,
                                  //       color: Color(0xfff2ad70),
                                  //       size: 18,
                                  //     ),
                                  //     const Icon(
                                  //       Icons.star_rounded,
                                  //       color: Color(0xfff2ad70),
                                  //       size: 18,
                                  //     ),
                                  //     const Icon(
                                  //       Icons.star_outline_rounded,
                                  //       color: Color(0xfff2ad70),
                                  //       size: 18,
                                  //     ),
                                  //     const Icon(
                                  //       Icons.star_outline_rounded,
                                  //       color: Color(0xfff2ad70),
                                  //       size: 18,
                                  //     ),
                                  //     const SizedBox(
                                  //       width: 10,
                                  //     ),
                                  //   ],
                                  // ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     TextButton(
                                  //       style: ButtonStyle(
                                  //         foregroundColor:
                                  //             MaterialStateProperty.all<Color>(
                                  //                 Colors.white),
                                  //         backgroundColor:
                                  //             MaterialStateProperty.all<Color>(
                                  //                 const Color(0xffe5ffed)),
                                  //         shape: MaterialStateProperty.all<
                                  //             RoundedRectangleBorder>(
                                  //           RoundedRectangleBorder(
                                  //             borderRadius:
                                  //                 BorderRadius.circular(8.0),
                                  //             side: const BorderSide(
                                  //               color: Color(0xffe5ffed),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       onPressed: () {},
                                  //       child: Text(
                                  //         '${addon.addons[index].price}',
                                  //         style: const TextStyle(
                                  //           fontSize: 13,
                                  //           fontWeight: FontWeight.normal,
                                  //           fontFamily: 'Poppins',
                                  //           color: Color(0xff0e8738),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     const SizedBox(
                                  //       width: 100,
                                  //     ),
                                  //     const Icon(
                                  //       Icons.favorite,
                                  //       color: Colors.red,
                                  //       size: 18,
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
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
      ),
    );
  }
}
