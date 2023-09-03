import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speciality_coffee_review/models/review_database.dart';

import '../models/review.dart';

final starsReaderProvider = FutureProvider<List<String>>((ref) async {
  final current = FirebaseAuth.instance.currentUser!.uid;
  final user =
      await FirebaseFirestore.instance.collection('users').doc(current).get();
  List<String> starredReviews = user.data()!['starred'];
  return starredReviews;
});

final starsProvider = StateNotifierProvider<StarsNotifier, List<String>>((ref) {
  List<String> starredReviews = [];
  final data = ref
      .watch(starsReaderProvider)
      .whenData((value) => starredReviews = value);
  return StarsNotifier(starredReviews: starredReviews);
});

class StarsNotifier extends StateNotifier<List<String>> {
  StarsNotifier({required this.starredReviews}) : super(starredReviews);

  final List<String> starredReviews;

  Future<int> toggleStar(Review review) async {
    print(starredReviews);
    final user = FirebaseAuth.instance.currentUser!.uid;
    final isStarred = starredReviews.any((element) => element == review.id);

    if (isStarred) {
      review.decrementStars();
      state = state.where((r) => r != review.id).toList();
      FirebaseFirestore.instance.collection('users').doc(user).update({
        'starred': FieldValue.arrayRemove([review.id])
      });
      FirebaseFirestore.instance.collection('reviews').doc(review.id).update({
        'stars': review.stars,
      });
      print(review.stars);
      return review.stars;
    } else {
      review.incrementStars();
      state = [...state, review.id];
      FirebaseFirestore.instance.collection('users').doc(user).update({
        'starred': FieldValue.arrayUnion([review.id])
      });

      FirebaseFirestore.instance.collection('reviews').doc(review.id).update({
        'stars': review.stars,
      });
      print(review.stars);

      return review.stars;
    }
  }
}
