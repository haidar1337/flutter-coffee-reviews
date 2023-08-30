import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speciality_coffee_review/providers/brewing_method_provider.dart';
import 'package:speciality_coffee_review/models/review.dart';

class TypeSelector extends ConsumerWidget {
  const TypeSelector({super.key, required this.onSelectType});

  final Function(BrewingMethod selectedType) onSelectType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watcher = ref.watch(brewingMethodProvider);
    if (watcher.isEmpty) {
      onSelectType(BrewingMethod.any);
    } else {
      onSelectType(watcher.first);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        MaterialButton(
          onPressed: () {
            ref
                .read(brewingMethodProvider.notifier)
                .toggleBrewingMethod(BrewingMethod.filter);
          },
          child: CircleAvatar(
            radius: 25,
            backgroundColor: const Color.fromARGB(99, 108, 106, 106),
            child: Image.asset(
              'assets/coffee-filter.png',
              width: 25,
              height: 25,
              color: watcher.contains(BrewingMethod.filter)
                  ? Colors.yellow
                  : Colors.white,
            ),
          ),
        ),
        MaterialButton(
          onPressed: () {
            ref
                .read(brewingMethodProvider.notifier)
                .toggleBrewingMethod(BrewingMethod.espresso);
          },
          child: CircleAvatar(
            radius: 25,
            backgroundColor: const Color.fromARGB(99, 108, 106, 106),
            child: Image.asset(
              'assets/portafilter.png',
              width: 30,
              height: 30,
              color: watcher.contains(BrewingMethod.espresso)
                  ? Colors.yellow
                  : Colors.white,
            ),
          ),
        ),
        MaterialButton(
          onPressed: () {
            ref
                .read(brewingMethodProvider.notifier)
                .toggleBrewingMethod(BrewingMethod.any);
          },
          child: CircleAvatar(
            radius: 25,
            backgroundColor: const Color.fromARGB(99, 108, 106, 106),
            child: Text(
              'Any',
              style: TextStyle(
                  color: watcher.contains(BrewingMethod.any)
                      ? Colors.yellow
                      : Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
