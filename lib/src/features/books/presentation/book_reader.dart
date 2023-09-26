import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../data/providers/books_provider.dart';

class BookReader extends ConsumerWidget {
  final String bookId;
  const BookReader({super.key, required this.bookId});
  static const path = 'book';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookDetailsAsync = ref.watch(bookDetailsProvider(bookId));
    return Scaffold(
        appBar: AppBar(
          title: bookDetailsAsync.when(
            data: (data) {
              return Text(data.book.title);
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => const Center(child: Text('Error')),
          ),

          // const Text('Syncfusion Flutter PDF Viewer'),
          backgroundColor: const Color(0xff0000ff),
        ),
        body: bookDetailsAsync.when(
          data: (data) {
            print('${data.pdfLocation}/${data.book.pdf.file}');
            return SfPdfViewer.network(
                '${data.pdfLocation}/${data.book.pdf.file}');
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => const Center(child: Text('Error')),
        ));
  }
}
