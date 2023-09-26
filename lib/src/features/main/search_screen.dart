import 'package:aptm/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  static const path = 'search';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0000ff),
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Search',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              // color: Color(0xff222222),
            ),
          ),
        ),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 40, left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.notifications,
                size: 86,
              ),
              SizedBox(
                height: 80,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'we\'ll alert you once something cool happens.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  color: Color(0xff666666),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
