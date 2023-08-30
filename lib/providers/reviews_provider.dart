import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/review.dart';

final reviewsProvider = StreamProvider<List<Review>>((ref) async* {
  final firebaseFirestore = FirebaseFirestore.instance;

  var reviews = const <Review>[];
  var reviewsList = <Review>[];
  final snapshots = firebaseFirestore.collection('reviews').snapshots();

  await for (var snapshot in snapshots) {
    for (var doc in snapshot.docChanges) {
      final reviewObj = Review(
        doc.doc['description'],
        BrewingMethod.values.firstWhere((element) =>
            element.toString().toLowerCase().substring(14) ==
            doc.doc['brewingMethod']),
        id: doc.doc['id'],
        createdAt: doc.doc['createdAt'],
        createdBy: doc.doc['createdBy'],
        coffeeName: doc.doc['name'],
        coffeePrice: doc.doc['price'],
        roasteryName: doc.doc['roastery'],
        region: Region.values.firstWhere((element) =>
            element.toString().toLowerCase().substring(7) == doc.doc['region']),
        imageUrl: doc.doc['image_url'],
        stars: doc.doc['stars'],
      );
      reviewsList.add(reviewObj);
      for (var rev in reviewsList) {
        if (!reviews.any((element) => element.id == rev.id)) {
          reviews = [...reviews, reviewObj];
        }
        yield reviews;
      }
    }
  }
});
