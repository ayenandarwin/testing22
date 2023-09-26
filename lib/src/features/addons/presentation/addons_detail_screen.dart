import 'package:aptm/src/features/books/data/providers/books_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddonDetailScreen extends ConsumerWidget {
  final String addonsId;
  const AddonDetailScreen({super.key, required this.addonsId});
  static const path = 'addons-detail-screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addonsinfo = ref.watch(addonsdetial(addonsId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Addons'),
        backgroundColor: const Color(0xff0000ff),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10, left: 16, bottom: 5),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: Image.network(
                      'https://via.placeholder.com/250x250.png?text=Image+Failed+to+Load',
                      height: 70.0,
                      width: 70.0,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
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
                Column(
                  children: [
                    const Text(
                      'Explore',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: Color(0xff666666)),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          padding: const EdgeInsets.only(
                              bottom: 5, top: 5, left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 201, 200, 200),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Popular',
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Poppins',
                                color: Color.fromARGB(255, 9, 9, 9)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          padding: const EdgeInsets.only(
                              bottom: 5, top: 5, left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 201, 200, 200),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Best Seller',
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Poppins',
                                color: Color.fromARGB(255, 9, 9, 9)),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              bottom: 5, top: 5, left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 201, 200, 200),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            '200+ books',
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Poppins',
                                color: Color.fromARGB(255, 9, 9, 9)),
                          ),
                        ),
                      ],
                    )
                  ],
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
          addonsinfo.when(
            data: (addon) => Expanded(
              child: ListView.builder(
                itemCount: addon.addon.books.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {},
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
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  'https://aptmbeta.s3.ap-southeast-1.amazonaws.com/pdf/images/${addon.addon.books[index].coverPhoto}',
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
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  addon.addon.books[index].title,
                                  style: const TextStyle(
                                      color: Color(0xff222222),
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '${addon.addon.books[index].author}',
                                  // addon.addons[index].description,
                                  style: TextStyle(
                                      color: Color(0xff666666),
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  'Price: ${addon.addon.price}Ks',
                                  style: const TextStyle(
                                      color: Color(0xff222222),
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
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
      ),
    );
  }
}
