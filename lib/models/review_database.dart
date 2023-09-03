import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:speciality_coffee_review/models/review.dart';

import '../utilities/util.dart';

class ReviewDatabase {
  static final firebaseFirestore = FirebaseFirestore.instance;
  static final firebaseAuth = FirebaseAuth.instance;
  static final firebaseStorage = FirebaseStorage.instance;

  static void createReview(Review review) async {
    final user = firebaseAuth.currentUser;
    await firebaseFirestore.collection('reviews').doc(review.id).set({
      'description': review.description,
      'name': review.coffeeName,
      'price': review.coffeePrice,
      'region': review.region.name,
      'brewingMethod': review.brewingMethod.name,
      'roastery': review.roasteryName,
      'id': review.id,
      'image_url': review.imageUrl,
      'createdBy': user!.uid,
      'createdAt': Timestamp.now(),
      'stars': 0,
    });
  }

  static Future<String> getImageUrl(File image) async {
    final imageRef =
        firebaseStorage.ref().child('review_images').child('${uuid.v4()}.jpg');

    await imageRef.putFile(image);
    final imageUrl = await imageRef.getDownloadURL();
    return imageUrl;
  }

  static Future<List<dynamic>> getStarredReviews() async {
    final user = firebaseAuth.currentUser;
    final doc =
        await firebaseFirestore.collection('users').doc(user!.uid).get();
    List<dynamic> starredReviews = doc.data()!['starred'];
    return starredReviews;
  }
}
