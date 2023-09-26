import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UpgradeScreen extends StatefulWidget {
  const UpgradeScreen({Key? key}) : super(key: key);

  @override
  State<UpgradeScreen> createState() => _UpgradeScreenState();
}

class _UpgradeScreenState extends State<UpgradeScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upgrade'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Choose your plan',
                style: TextStyle(
                  fontSize: 25,
                  letterSpacing: -0.01,
                  color: Color(0xFF222222),
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  'Pricing',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    color: Color(0xFF222222),
                  ),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  'Select a suitable plan',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    color: Color(0xFF666666),
                    height: 1,
                  ),
                ),
              ),
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
                      width: 396,
                      height: 180,
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
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'FREE',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF222222),
                                  fontFamily: 'Poppins',
                                  height: 1,
                                ),
                              ),
                              Text(
                                '15,000 ks / month',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF222222),
                                  fontFamily: 'Poppins',
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
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
                                  fontSize: 16,
                                  color: Color(0xFF333333),
                                  fontFamily: 'Poppins',
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
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
                                  fontSize: 16,
                                  color: Color(0xFF333333),
                                  fontFamily: 'Poppins',
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
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
                                  fontSize: 16,
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
                height: 45,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xff3333ff),
                    ),
                  ),
                  onPressed: () async {
                    final Uri toLaunch =
                        Uri(scheme: 'http', host: 'm.me', path: '/luxureapp');
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


        // body: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Column(
        //     children: [
        //       SizedBox(
        //         width: double.infinity,
        //         height: 45,
        //         child: ElevatedButton(
        //           style: ButtonStyle(
        //             backgroundColor: MaterialStateProperty.all<Color>(
        //               const Color(0xff3333ff),
        //             ),
        //           ),
        //           onPressed: () async {
        //             final Uri toLaunch =
        //                 Uri(scheme: 'http', host: 'm.me', path: '/luxureapp');
        //             print(toLaunch);
        //             if (!await launchUrl(
        //               toLaunch,
        //               mode: LaunchMode.externalApplication,
        //             )) {
        //               throw Exception('Could not launch');
        //             }
        //           },
        //           child: const Text(
        //             'Upgrade your plan',
        //             style: TextStyle(
        //                 color: Color(0xffffffff),
        //                 fontSize: 16,
        //                 fontWeight: FontWeight.bold,
        //                 fontFamily: 'Poppins'),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
