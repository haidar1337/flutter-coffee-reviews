import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speciality_coffee_review/models/review.dart';

final brewingMethodProvider =
    StateNotifierProvider<BrewingMethodNotifier, List<BrewingMethod>>(
        (ref) => BrewingMethodNotifier());

// Set up a provider that listens to user interaction with the type of coffee.
// Upon choosing a type, the widget will light up. And return the chosen type.

class BrewingMethodNotifier extends StateNotifier<List<BrewingMethod>> {
  BrewingMethodNotifier() : super([]);

  void toggleBrewingMethod(BrewingMethod providerBrewingMethod) {
    state = [
      for (final brewingMethod in BrewingMethod.values)
        if (providerBrewingMethod == brewingMethod) providerBrewingMethod
    ];
  }
}
