import 'package:aptm/src/features/audio_books/presentation/screens/audio_player.dart';
import 'package:aptm/src/features/audio_books/presentation/screens/summary_screen.dart';
import 'package:aptm/src/features/books/data/providers/books_provider.dart';
import 'package:aptm/src/features/books/presentation/downloading_dialog.dart';
import 'package:aptm/src/features/profile/data/providers/profile_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../main/home_screen.dart';
import '../../data/providers/audio_provider.dart';

class AudioDetailScreen extends ConsumerWidget {
  final String audioBookId;
  const AudioDetailScreen({super.key, required this.audioBookId});
  static const path = 'audio-detail';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final bookDetailsAsync = ref.watch(audioBookDetailsProvider(audioBookId));
    return bookDetailsAsync.when(
      data: (data) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Wrap(
                          children: [
                            InkWell(
                              onTap: () async {
                                final favBook = await ref
                                    .read(bookFavProvider(audioBookId).future);
                                final snackbar =
                                    SnackBar(content: Text(favBook.msg));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                                if (favBook.msg ==
                                    'Successfully remove from favorite list !') {
                                  Set() {
                                    --data.audioBook!.favorite!.length;
                                  }
                                } else {
                                  ++data.audioBook!.favorite!.length;
                                }
                              },
                              child: const ListTile(
                                leading: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                                title: Text('Add to favorite list'),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const ListTile(
                                leading: Icon(Icons.turned_in),
                                title: Text('Save'),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const ListTile(
                                leading: Icon(Icons.ios_share),
                                title: Text('Share'),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                final downloadBook = await ref.read(
                                    audioDownloadProvider(audioBookId).future);
                                if (downloadBook.success == true) {
                                  ref.read(profileDownload);
                                }
                                showDialog(
                                  context: context,
                                  builder: (context) => DownloadingDialog(
                                    urllink:
                                        '${data.mp3Location}/${data.audioBook!.mp3!.file}',
                                    file: '${data.audioBook!.id}.mp3',
                                  ),
                                );
                              },
                              child: const ListTile(
                                leading: Icon(Icons.download),
                                title: Text('Download'),
                              ),
                            ),
                          ],
                        );
                      });
                },
                icon: const Icon(Icons.more_vert))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                'https://aptmbeta.s3.ap-southeast-1.amazonaws.com/mp3/images/${data.audioBook!.coverPhoto}',
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  // This function is called when the image fails to load
                  // Return a new widget to display a dummy image from the internet
                  return Image.network(
                    'https://via.placeholder.com/500x250.png?text=Image+Failed+to+Load',
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                data.audioBook!.title.toString(),
                style: const TextStyle(
                    color: Color(0xff222222),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                data.audioBook!.author.toString(),
                style: const TextStyle(
                    color: Color(0xff666666),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Poppins'),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.visibility_rounded,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Read',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins'),
                          ),
                          Text(
                            data.audioBook!.read!.length.toString(),
                            style: const TextStyle(
                                color: Color(0xff666666),
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins'),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.star_half_rounded,
                        size: 15,
                        color: Color(0xffdd8538),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Rating',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins'),
                          ),
                          Text(
                            '2',
                            // data.audioBook.rate.toString(),
                            style: const TextStyle(
                                color: Color(0xff666666),
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins'),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () async {
                          // ref.read(bookFavProvider(bookId));
                          final favBook = await ref
                              .read(audioFavProvider(audioBookId).future);
                          final snackbar = SnackBar(content: Text(favBook.msg));
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          if (favBook.msg ==
                              'Successfully remove from favorite list !') {
                            Set() {
                              --data.audioBook!.favorite!.length;
                            }
                          } else {
                            ++data.audioBook!.favorite!.length;
                          }
                        },
                        child: const Icon(
                          Icons.favorite,
                          size: 15,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Favorite',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins'),
                          ),
                          Text(
                            data.audioBook!.favorite!.length.toString(),
                            style: const TextStyle(
                                color: Color(0xff666666),
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins'),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () async {
                          final downloadBook = await ref
                              .read(audioDownloadProvider(audioBookId).future);
                          if (downloadBook.success == true) {
                            ref.read(profileDownload);
                          }
                          showDialog(
                            context: context,
                            builder: (context) => DownloadingDialog(
                              urllink:
                                  '${data.mp3Location}/${data.audioBook!.mp3!.file}',
                              file: '${data.audioBook!.id}.mp3',
                            ),
                          );
                        },
                        child: Icon(
                          Icons.download,
                          size: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Download',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins'),
                          ),
                          Text(
                            data.audioBook!.download!.length.toString(),
                            style: const TextStyle(
                                color: Color(0xff666666),
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins'),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: size.width * 0.4,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Color.fromARGB(255, 250, 250, 250),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.transparent,
                          ),
                          elevation: MaterialStateProperty.all<double>(0.0),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: const BorderSide(
                                color: Color(0xff0000ff),
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          return context.go(
                            '${HomeScreen.path}${AudioDetailScreen.path}/$audioBookId/${SummaryScreen.path}/${data.audioBook!.id.toString()}',
                          );
                        },
                        icon: const Icon(
                          Icons.menu_book_outlined,
                          size: 20.0,
                          color: Color(0xff0000ff),
                        ),
                        label: const Text(
                          'Start Reading',
                          style: TextStyle(
                            color: Color(0xff0000ff),
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.4,
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xff0000ff),
                        ),
                      ),
                      onPressed: () {
                        return context.go(
                            '${HomeScreen.path}${AudioDetailScreen.path}/$audioBookId/${AudioPlayerScreen.path}/${data.audioBook!.id.toString()}');
                      },
                      icon: const Icon(
                        Icons.headphones,
                        size: 20.0,
                      ),
                      label: const Text(
                        'Play audio',
                        style: TextStyle(
                            color: Color(0xffffffff),
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppins'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: size.width * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Description',
                      style: TextStyle(
                          color: Color(0xff222222),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins'),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      data.audioBook!.description.toString(),
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                          color: Color(0xff666666),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins'),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 48,
              ),
            ],
          ),
        ),
      ),
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stackTrace) => Text('Error: $error'),
    );
  }
}
