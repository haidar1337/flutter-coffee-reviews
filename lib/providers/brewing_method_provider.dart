import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speciality_coffee_review/models/review.dart';

final brewingMethodProvider =
    StateNotifierProvider<BrewingMethodNotifier, List<BrewingMethod>>(
        (ref) => BrewingMethodNotifier());

class BrewingMethodNotifier extends StateNotifier<List<BrewingMethod>> {
  BrewingMethodNotifier() : super([]);

  void toggleBrewingMethod(BrewingMethod providerBrewingMethod) {
    state = [
      for (final brewingMethod in BrewingMethod.values)
        if (providerBrewingMethod == brewingMethod) providerBrewingMethod
    ];
  }
}
