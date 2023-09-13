import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speciality_coffee_review/models/review.dart';
import 'package:speciality_coffee_review/models/review_database.dart';
import 'package:speciality_coffee_review/providers/reviews_provider.dart';

class BookmarksNotifier extends StateNotifier<List<Review>> {
  final Future<List<dynamic>> bookmarks = ReviewDatabase.getBookmarkedReviews();
  final List<Review> reviews;
  BookmarksNotifier(this.reviews) : super([]);

  Future<void> loadBookmarks() async {
    final bookmarkedReviews = await bookmarks;
    final bookmark = [];
    for (var review in reviews) {
      if (bookmarkedReviews.contains(review.getId())) {
        bookmark.add(review);
      }
    }
    state = [...bookmark];
  }

  void toggleBookmark(Review review) async {
    final bookmarkedReviews = await bookmarks;
    final isBookmarked = bookmarkedReviews
        .any((element) => element.toString() == review.getId());

    if (isBookmarked) {
      ReviewDatabase.removeBookmark(review);
      bookmarkedReviews.remove(review.getId());
    } else {
      ReviewDatabase.bookmarkReview(review);
      bookmarkedReviews.add(review.getId());
    }

    for (var review in reviews) {
      if (bookmarkedReviews.contains(review.getId())) {
        state = [...state, review];
      } else {
        state = [
          ...state.where((element) => element.getId() != review.getId())
        ];
      }
    }
  }
}

final bookmarksProvider =
    StateNotifierProvider<BookmarksNotifier, List<Review>>((ref) {
  final list = ref.read(reviewsProvider);
  late List<Review> reviews;
  list.whenData((value) => reviews = value);
  return BookmarksNotifier(reviews);
});
