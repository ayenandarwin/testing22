import 'dart:convert';

import 'package:aptm/src/features/profile/data/providers/pricing_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UpgradeScreen extends StatefulWidget {
  const UpgradeScreen({super.key});
  static const path = 'upgrade-screen';

  @override
  State<UpgradeScreen> createState() => _UpgradeScreenState();
}

class _UpgradeScreenState extends State<UpgradeScreen> {
  Future<PricingModel>? _pricingModelFuture;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final url = Uri.parse('https://aptm-b.ethical-digit.com/packages');
    // Replace this line with your own secure storage implementation
    const storage = FlutterSecureStorage();
    final token = await storage.read(
        key: 'token'); // Replace with your own token retrieval logic
    final response = await http.get(url, headers: {'Authorization': token!});
    final json = jsonDecode(response.body);
    print(json);
    setState(() {
      _pricingModelFuture = Future.value(PricingModel.fromJson(json));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0000ff),
        title: const Text('Upgrade'),
      ),
      body: FutureBuilder<PricingModel>(
          future: _pricingModelFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Choose your plan',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.01,
                          color: Color(0xFF222222),
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Text(
                          'Pricing',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF222222),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Text(
                          'Select a suitable plan',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: Color(0xFF666666),
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(), // Disable scrolling of ListView
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        // Add your item builder logic here
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              // width: 396,
                              // height: 180,
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.2,
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
                                border: Border.all(
                                  color: selectedIndex == index
                                      ? Color.fromARGB(255, 35, 87, 125)
                                      : const Color(
                                          0xfff5faff), // Set the border color based on selection
                                  width: 2, // Set the border width
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Column(children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'FREE',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF222222),
                                          fontFamily: 'Poppins',
                                          height: 1,
                                        ),
                                      ),
                                      Text(
                                        '15,000 ks / month',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF222222),
                                          fontFamily: 'Poppins',
                                          height: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        ),
                                      ),
                                      Text(
                                        '10 Video book free',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF333333),
                                          fontFamily: 'Poppins',
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        ),
                                      ),
                                      Text(
                                        '10 Video book free',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF333333),
                                          fontFamily: 'Poppins',
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        ),
                                      ),
                                      Text(
                                        '10 Video book free',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF333333),
                                          fontFamily: 'Poppins',
                                        ),
                                      )
                                    ],
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xff3333ff),
                            ),
                          ),
                          onPressed: () async {
                            final Uri toLaunch = Uri(
                                scheme: 'http',
                                host: 'm.me',
                                path: '/luxureapp');
                            print(toLaunch);
                            if (!await launchUrl(
                              toLaunch,
                              mode: LaunchMode.externalApplication,
                            )) {
                              throw Exception('Could not launch');
                            }
                          },
                          child: const Text(
                            'Upgrade your plan',
                            style: TextStyle(
                                color: Color(0xffffffff),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins'),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              );
            } else {
              return Text('No data available');
            }
          }),
    );
  }
}

// import 'package:aptm/src/features/books/presentation/book_detail_screen.dart';
// import 'package:aptm/src/features/main/home_screen.dart';
// import 'package:aptm/src/features/profile/data/providers/pricing_model.dart';
// import 'package:aptm/src/features/profile/data/providers/profile_detail_provider.dart';
// import 'package:aptm/src/features/profile/screens/pricing_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:url_launcher/url_launcher.dart';

// class UpgradeScreen extends ConsumerWidget {
//   const UpgradeScreen({super.key});
//   static const path = 'upgrade-screen';

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final pricingdata = ref.watch(pricing);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Upgrade'),
//       ),
//       body: SingleChildScrollView(
//         // Container(
//         //   padding: const EdgeInsets.only(left: 16),
//         //   height: 50,
//         //   child: ListView.builder(
//         //       scrollDirection: Axis.horizontal,
//         //       itemCount: 1,
//         //       itemBuilder: (context, index) {
//         //         return TextButton(
//         //           style: ButtonStyle(
//         //             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//         //               RoundedRectangleBorder(
//         //                 borderRadius: BorderRadius.circular(50.0),
//         //                 side: const BorderSide(
//         //                   color: Color(0xffaaaaaa),
//         //                 ),
//         //               ),
//         //             ),
//         //           ),
//         //           onPressed: () {},
//         //           child: const Text(
//         //             ' Marketing ',
//         //             style: TextStyle(
//         //                 fontSize: 13,
//         //                 fontWeight: FontWeight.normal,
//         //                 fontFamily: 'Poppins',
//         //                 color: Color(0xff666666),
//         //                 letterSpacing: 1),
//         //           ),
//         //         );
//         //       }),
//         // ),
//         child: pricingdata.when(
//           data: (data) => Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Align(
//                 alignment: Alignment.center,
//                 child: Text(
//                   'Choose your plan',
//                   style: TextStyle(
//                     fontSize: 25,
//                     letterSpacing: -0.01,
//                     color: Color(0xFF222222),
//                     fontFamily: 'Poppins',
//                   ),
//                 ),
//               ),
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 16.0),
//                   child: Text(
//                     'Pricing',
//                     style: TextStyle(
//                       fontFamily: 'Poppins',
//                       fontSize: 20,
//                       color: Color(0xFF222222),
//                     ),
//                   ),
//                 ),
//               ),
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 16.0),
//                   child: Text(
//                     'Select a suitable plan',
//                     style: TextStyle(
//                       fontFamily: 'Poppins',
//                       fontSize: 13,
//                       color: Color(0xFF666666),
//                       height: 1,
//                     ),
//                   ),
//                 ),
//               ),
//               ListView.builder(
//                   shrinkWrap: true,
//                   physics:
//                       const NeverScrollableScrollPhysics(), // Disable scrolling of ListView
//                   itemCount: data.packages.length,
//                   itemBuilder: (context, index) {
//                     return Text('data');
//                   }),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: SizedBox(
//                   width: double.infinity,
//                   height: 45,
//                   child: ElevatedButton(
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all<Color>(
//                         const Color(0xff3333ff),
//                       ),
//                     ),
//                     onPressed: () async {
//                       final Uri toLaunch =
//                           Uri(scheme: 'http', host: 'm.me', path: '/luxureapp');
//                       print(toLaunch);
//                       if (!await launchUrl(
//                         toLaunch,
//                         mode: LaunchMode.externalApplication,
//                       )) {
//                         throw Exception('Could not launch');
//                       }
//                     },
//                     child: const Text(
//                       'Upgrade your plan',
//                       style: TextStyle(
//                           color: Color(0xffffffff),
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'Poppins'),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           loading: () => const Center(child: CircularProgressIndicator()),
//           error: (error, stackTrace) => Text('Error: $error'),
//         ),
//       ),
//     );
//   }
// }





// // import 'package:flutter/material.dart';
// // import 'package:url_launcher/url_launcher.dart';

// // class UpgradeScreen extends StatefulWidget {
// //   const UpgradeScreen({Key? key}) : super(key: key);
// //   static const path = 'upgrade-screen';

// //   @override
// //   State<UpgradeScreen> createState() => _UpgradeScreenState();
// // }

// // class _UpgradeScreenState extends State<UpgradeScreen> {
// //   int selectedIndex = 0;
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Upgrade'),
// //       ),
// //       body: SingleChildScrollView(
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             const Align(
// //               alignment: Alignment.center,
// //               child: Text(
// //                 'Choose your plan',
// //                 style: TextStyle(
// //                   fontSize: 25,
// //                   letterSpacing: -0.01,
// //                   color: Color(0xFF222222),
// //                   fontFamily: 'Poppins',
// //                 ),
// //               ),
// //             ),
// //             const Align(
// //               alignment: Alignment.centerLeft,
// //               child: Padding(
// //                 padding: EdgeInsets.only(left: 16.0),
// //                 child: Text(
// //                   'Pricing',
// //                   style: TextStyle(
// //                     fontFamily: 'Poppins',
// //                     fontSize: 20,
// //                     color: Color(0xFF222222),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             const Align(
// //               alignment: Alignment.centerLeft,
// //               child: Padding(
// //                 padding: EdgeInsets.only(left: 16.0),
// //                 child: Text(
// //                   'Select a suitable plan',
// //                   style: TextStyle(
// //                     fontFamily: 'Poppins',
// //                     fontSize: 13,
// //                     color: Color(0xFF666666),
// //                     height: 1,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             ListView.builder(
// //               shrinkWrap: true,
// //               physics:
// //                   const NeverScrollableScrollPhysics(), // Disable scrolling of ListView
// //               itemCount: 3,
// //               itemBuilder: (context, index) {
// //                 // Add your item builder logic here
// //                 return GestureDetector(
// //                   onTap: () {
// //                     setState(() {
// //                       selectedIndex = index;
// //                     });
// //                   },
// //                   child: Padding(
// //                     padding: const EdgeInsets.all(10),
// //                     child: Container(
// //                       width: 396,
// //                       height: 180,
// //                       decoration: BoxDecoration(
// //                         boxShadow: [
// //                           BoxShadow(
// //                             color: Colors.grey.withOpacity(0.2),
// //                             spreadRadius: 5,
// //                             blurRadius: 5,
// //                             offset: const Offset(
// //                                 0, 2), // changes position of shadow
// //                           ),
// //                         ],
// //                         color: const Color(0xfff5faff),
// //                         borderRadius: const BorderRadius.all(
// //                           Radius.circular(10),
// //                         ),
// //                         border: Border.all(
// //                           color: selectedIndex == index
// //                               ? Color.fromARGB(255, 35, 87, 125)
// //                               : const Color(
// //                                   0xfff5faff), // Set the border color based on selection
// //                           width: 2, // Set the border width
// //                         ),
// //                       ),
// //                       child: const Padding(
// //                         padding: EdgeInsets.all(8),
// //                         child: Column(children: [
// //                           SizedBox(
// //                             height: 15,
// //                           ),
// //                           Row(
// //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                             children: [
// //                               Text(
// //                                 'FREE',
// //                                 style: TextStyle(
// //                                   fontSize: 20,
// //                                   color: Color(0xFF222222),
// //                                   fontFamily: 'Poppins',
// //                                   height: 1,
// //                                 ),
// //                               ),
// //                               Text(
// //                                 '15,000 ks / month',
// //                                 style: TextStyle(
// //                                   fontSize: 20,
// //                                   color: Color(0xFF222222),
// //                                   fontFamily: 'Poppins',
// //                                   height: 1,
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                           SizedBox(
// //                             height: 16,
// //                           ),
// //                           Row(
// //                             children: [
// //                               Padding(
// //                                 padding: EdgeInsets.only(right: 5),
// //                                 child: Icon(
// //                                   Icons.check,
// //                                   color: Colors.green,
// //                                 ),
// //                               ),
// //                               Text(
// //                                 '10 Video book free',
// //                                 style: TextStyle(
// //                                   fontSize: 16,
// //                                   color: Color(0xFF333333),
// //                                   fontFamily: 'Poppins',
// //                                 ),
// //                               )
// //                             ],
// //                           ),
// //                           SizedBox(
// //                             height: 15,
// //                           ),
// //                           Row(
// //                             children: [
// //                               Padding(
// //                                 padding: EdgeInsets.only(right: 5),
// //                                 child: Icon(
// //                                   Icons.check,
// //                                   color: Colors.green,
// //                                 ),
// //                               ),
// //                               Text(
// //                                 '10 Video book free',
// //                                 style: TextStyle(
// //                                   fontSize: 16,
// //                                   color: Color(0xFF333333),
// //                                   fontFamily: 'Poppins',
// //                                 ),
// //                               )
// //                             ],
// //                           ),
// //                           SizedBox(
// //                             height: 15,
// //                           ),
// //                           Row(
// //                             children: [
// //                               Padding(
// //                                 padding: EdgeInsets.only(right: 5),
// //                                 child: Icon(
// //                                   Icons.check,
// //                                   color: Colors.green,
// //                                 ),
// //                               ),
// //                               Text(
// //                                 '10 Video book free',
// //                                 style: TextStyle(
// //                                   fontSize: 16,
// //                                   color: Color(0xFF333333),
// //                                   fontFamily: 'Poppins',
// //                                 ),
// //                               )
// //                             ],
// //                           ),
// //                         ]),
// //                       ),
// //                     ),
// //                   ),
// //                 );
// //               },
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.all(8.0),
// //               child: SizedBox(
// //                 width: double.infinity,
// //                 height: 45,
// //                 child: ElevatedButton(
// //                   style: ButtonStyle(
// //                     backgroundColor: MaterialStateProperty.all<Color>(
// //                       const Color(0xff3333ff),
// //                     ),
// //                   ),
// //                   onPressed: () async {
// //                     final Uri toLaunch =
// //                         Uri(scheme: 'http', host: 'm.me', path: '/luxureapp');
// //                     print(toLaunch);
// //                     if (!await launchUrl(
// //                       toLaunch,
// //                       mode: LaunchMode.externalApplication,
// //                     )) {
// //                       throw Exception('Could not launch');
// //                     }
// //                   },
// //                   child: const Text(
// //                     'Upgrade your plan',
// //                     style: TextStyle(
// //                         color: Color(0xffffffff),
// //                         fontSize: 16,
// //                         fontWeight: FontWeight.bold,
// //                         fontFamily: 'Poppins'),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }


// //         // body: Padding(
// //         //   padding: const EdgeInsets.all(8.0),
// //         //   child: Column(
// //         //     children: [
// //         //       SizedBox(
// //         //         width: double.infinity,
// //         //         height: 45,
// //         //         child: ElevatedButton(
// //         //           style: ButtonStyle(
// //         //             backgroundColor: MaterialStateProperty.all<Color>(
// //         //               const Color(0xff3333ff),
// //         //             ),
// //         //           ),
// //         //           onPressed: () async {
// //         //             final Uri toLaunch =
// //         //                 Uri(scheme: 'http', host: 'm.me', path: '/luxureapp');
// //         //             print(toLaunch);
// //         //             if (!await launchUrl(
// //         //               toLaunch,
// //         //               mode: LaunchMode.externalApplication,
// //         //             )) {
// //         //               throw Exception('Could not launch');
// //         //             }
// //         //           },
// //         //           child: const Text(
// //         //             'Upgrade your plan',
// //         //             style: TextStyle(
// //         //                 color: Color(0xffffffff),
// //         //                 fontSize: 16,
// //         //                 fontWeight: FontWeight.bold,
// //         //                 fontFamily: 'Poppins'),
// //         //           ),
// //         //         ),
// //         //       ),
// //         //     ],
// //         //   ),
// //         // ),
