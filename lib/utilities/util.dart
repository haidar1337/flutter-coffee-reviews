import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../models/review.dart';
import '../screens/post_details.dart';

const uuid = Uuid();

String capitalizeFirstLetter(String word) {
  final firstLetter = word[0].toUpperCase();
  final capitalizedWord = firstLetter + word.substring(1, word.length);

  return capitalizedWord;
}

Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('assets/$path');

  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}

void switchToFullDetails(BuildContext context, Review review) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) {
        return PostDetailsScreen(
          review: review,
        );
      },
    ),
  );
}

Map<BrewingMethod, String> correspondingIcon = {
  BrewingMethod.espresso: 'assets/portafilter.png',
  BrewingMethod.filter: 'assets/coffee-filter.png',
};

Map<Region, String> correspondingFlag = {
  Region.colombia: 'assets/colombia.png',
  Region.ethiopia: 'assets/ethiopia.png',
  Region.indonesia: 'assets/indonesia.png',
  Region.yemen: 'assets/yemen.png',
  Region.other: 'assets/flag.png'
};
