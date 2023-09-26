import 'package:flutter_riverpod/flutter_riverpod.dart';

final indexProvider = StateNotifierProvider((ref) => IndexNotifier());

class IndexNotifier extends StateNotifier<int> {
  IndexNotifier() : super(0);

  void updateIndex(int newIndex) {
    state = newIndex;
  }

  int get index => state;
}
