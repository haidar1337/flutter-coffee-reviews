import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    final isStarred = reviews.any((element) => element.toString() == review.id);

    if (isStarred) {
      review.decrementStars();
      FirebaseFirestore.instance.collection('reviews').doc(review.id).update({
        'stars': review.stars,
      });
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'starred': FieldValue.arrayRemove([review.id]),
      });
      reviews.remove(review.id);
      state = [...reviews];
    } else {
      review.incrementStars();
      FirebaseFirestore.instance.collection('reviews').doc(review.id).update({
        'stars': review.stars,
      });
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'starred': FieldValue.arrayUnion([review.id]),
      });
      reviews.add(review.id);
      state = [...reviews];
    }
  }
}
