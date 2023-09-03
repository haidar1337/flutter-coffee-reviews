import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speciality_coffee_review/models/review.dart';

import '../providers/stars_provider.dart';

class StarButton extends ConsumerWidget {
  const StarButton({super.key, required this.review});

  final Review review;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.star_border,
            size: 30,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        Text(
          review.stars.toString(),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
        ),
      ],
    );
  }
}
