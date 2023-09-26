import 'package:flutter/material.dart';

class TabBarCus extends StatefulWidget {
  const TabBarCus({Key? key}) : super(key: key);

  @override
  State<TabBarCus> createState() => _TabBarCusState();
}

class _TabBarCusState extends State<TabBarCus> {
  /// List of Tab Bar Item
  List<String> items = [
    "All",
    "Marketing",
    "Management",
    "Tenology",
    "Science",
    "Physic",
    "Biopraphy",
    "Comedy",
  ];

  /// List of body icon
  int current = 0;

  /////////////////////////////////////
  //@CodeWithFlexz on Instagram
  //
  //AmirBayat0 on Github
  //Programming with Flexz on Youtube
  /////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return

        /// CUSTOM TABBAR
        Padding(
      padding: const EdgeInsets.only(left: 10),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        current = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.only(
                          bottom: 10, top: 10, left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: current == index
                            ? const Color.fromARGB(255, 1, 1, 1)
                            : Colors.white54,
                        borderRadius: current == index
                            ? BorderRadius.circular(20)
                            : BorderRadius.circular(20),
                        border: current == index
                            ? Border.all(
                                color: const Color.fromARGB(255, 1, 1, 1),
                                width: 2)
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          items[index],
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: current == index
                                  ? const Color.fromARGB(255, 255, 255, 255)
                                  : const Color.fromARGB(255, 4, 4, 4)),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
