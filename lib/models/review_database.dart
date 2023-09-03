import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:speciality_coffee_review/models/review.dart';

import '../utilities/util.dart';

class ReviewDatabase {
  static void createReview(Review review) async {
    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('reviews').doc(review.id).set({
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
    final imageRef = FirebaseStorage.instance
        .ref()
        .child('review_images')
        .child('${uuid.v4()}.jpg');

    await imageRef.putFile(image);
    final imageUrl = await imageRef.getDownloadURL();
    return imageUrl;
  }
}
