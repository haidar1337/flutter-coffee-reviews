import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speciality_coffee_review/models/review.dart';
import 'package:speciality_coffee_review/providers/stars_provider.dart';

class StarButton extends ConsumerWidget {
  const StarButton({super.key, required this.review});

  final Review review;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stsProvider = ref.watch(starsProvider);
    final isStarred = stsProvider.any((element) => element == review.id);
    return Row(
      children: [
        IconButton(
          onPressed: () {
            ref.read(starsProvider.notifier).toggleStar(review);
          },
          icon: Icon(
            isStarred ? Icons.star : Icons.star_border,
            size: 30,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            review.stars.toString(),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }
}
