import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speciality_coffee_review/models/review_database.dart';

import '../models/review.dart';

final starsProvider = StateNotifierProvider<StarsNotifier, List<String>>((ref) {
  return StarsNotifier();
});

class StarsNotifier extends StateNotifier<List<String>> {
  final Future<List<dynamic>> starredReviews =
      ReviewDatabase.getStarredReviews();

  StarsNotifier() : super([]);

  void toggleStar(Review review) async {
    final reviews = await starredReviews;
    final isStarred =
        reviews.any((element) => element.toString() == review.getId());

    if (isStarred) {
      review.decrementStars();
      reviews.remove(review.getId());
    } else {
      review.incrementStars();
      reviews.add(review.getId());
    }
    state = [...reviews];
  }
}
