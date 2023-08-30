import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:speciality_coffee_review/utilities/util.dart';

enum BrewingMethod {
  filter,
  espresso,
  any,
}

enum Region {
  colombia,
  ethiopia,
  yemen,
  indonesia,
  other,
}

class Review {
  final String coffeeName;
  final double coffeePrice;
  final String roasteryName;
  final Region region;
  final BrewingMethod brewingMethod;
  final String description;
  final String id;
  final String imageUrl;
  final String createdBy;
  final Timestamp createdAt;
  final int stars;

  Review(
    String? description,
    BrewingMethod? brewingMethod, {
    id,
    stars,
    createdAt,
    createdBy,
    required this.coffeeName,
    required this.coffeePrice,
    required this.roasteryName,
    required this.region,
    required this.imageUrl,
  })  : description = description ?? '',
        brewingMethod = brewingMethod ?? BrewingMethod.any,
        stars = 0,
        createdAt = createdAt ?? Timestamp.now(),
        createdBy = createdBy ?? FirebaseAuth.instance.currentUser!.uid,
        id = id ?? uuid.v4();
}
