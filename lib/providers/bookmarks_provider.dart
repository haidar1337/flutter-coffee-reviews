import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speciality_coffee_review/models/review.dart';

class BookmarksNotifier extends StateNotifier<List<Review>> {
  BookmarksNotifier() : super([]);

  void toggleBookmark(Review review) {
    final isBookmarked = state.any((element) => element.id == review.id);

    if (isBookmarked) {
      state = state.where((r) => r.id != review.id).toList();
    } else {
      state = [...state, review];
    }
  }
}

final bookmarksProvider =
    StateNotifierProvider<BookmarksNotifier, List<Review>>(
        (ref) => BookmarksNotifier());
