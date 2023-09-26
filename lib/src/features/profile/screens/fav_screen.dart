import 'package:aptm/src/features/profile/screens/audio_fav.dart';
import 'package:aptm/src/features/profile/screens/book_fav.dart';
import 'package:aptm/src/features/profile/screens/video_fav.dart';
import 'package:flutter/material.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({Key? key}) : super(key: key);
  static const path = 'favscreen';

  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff0000ff),
        title: const Text('Favoriate'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                const SizedBox(height: 5),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(1),
                      child: TabBar(
                        unselectedLabelColor: Colors.black,
                        labelColor: Colors.black,
                        indicatorColor: const Color(0xFFFFFAF5),
                        indicatorWeight: 3,
                        indicator: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFFFF8000),
                              width: 2.0,
                            ),
                          ),
                          color: Color(0xFFFFFAF5),
                        ),
                        controller: tabController,
                        tabs: const [
                          Tab(
                            text: 'Book',
                          ),
                          Tab(
                            text: 'Audio',
                          ),
                          Tab(
                            text: 'Video',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: const [
                      BookFav(),
                      AudioFav(),
                      VideoFav(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
