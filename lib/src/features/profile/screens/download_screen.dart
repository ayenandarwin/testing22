import 'package:aptm/src/features/profile/screens/audio_download.dart';
import 'package:aptm/src/features/profile/screens/audio_fav.dart';
import 'package:aptm/src/features/profile/screens/book_download.dart';
import 'package:aptm/src/features/profile/screens/book_fav.dart';
import 'package:aptm/src/features/profile/screens/video_fav.dart';
import 'package:flutter/material.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({Key? key}) : super(key: key);
  static const path = 'download';

  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
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
        title: const Text('Download'),
        backgroundColor: const Color(0xff0000ff),
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
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: const [
                      BookDownload(),
                      AudioDownload(),
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

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// class DownloadScreen extends StatefulWidget {
//   const DownloadScreen({Key? key}) : super(key: key);

//   static const path = 'download';

//   @override
//   _DownloadScreenState createState() => _DownloadScreenState();
// }

// Future<List<String>> _getFilePaths() async {
//   final dir = await getApplicationDocumentsDirectory();
//   List<String> fileNames = [];

//   try {
//     List<FileSystemEntity> files = Directory(dir.path).listSync();
//     for (FileSystemEntity file in files) {
//       if (file is File) {
//         fileNames.add(file.path);
//       }
//     }
//   } catch (e) {
//     print('Error getting file paths: $e');
//   }

//   return fileNames;
// }

// class _DownloadScreenState extends State<DownloadScreen> {
//   List<String> filePaths = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadFilePaths();
//   }

//   void _loadFilePaths() async {
//     List<String> paths = await _getFilePaths();
//     setState(() {
//       filePaths = paths;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text('Download'),
//       ),
//       body: ListView.builder(
//         itemCount: filePaths.length,
//         itemBuilder: (context, index) {
//           String filePath = filePaths[index];
//           return ListTile(
//             title: Text(filePath),
//             onTap: () {
//               print(filePath);
//               // Handle file tap event (e.g., open the file)
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => PdfViewerScreen(filePath: filePath),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class PdfViewerScreen extends StatelessWidget {
//   final String filePath;

//   const PdfViewerScreen({required this.filePath});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('PDF Viewer'),
//       ),
//       body: SfPdfViewer.file(File(filePath)),
//     );
//   }
// }
