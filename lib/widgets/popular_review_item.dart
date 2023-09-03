import 'package:flutter/material.dart';
import 'package:speciality_coffee_review/models/review.dart';
import 'package:speciality_coffee_review/widgets/star_button.dart';

import '../utilities/util.dart';

class PopularReviewItem extends StatelessWidget {
  const PopularReviewItem({super.key, required this.review});

  final Review review;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        switchToFullDetails(
          context,
          review,
        );
      },
      child: Container(
        height: 50,
        clipBehavior: Clip.hardEdge,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              review.imageUrl,
              width: 250,
              height: 89,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Row(children: [
                Text(
                  review.coffeeName.substring(
                      0,
                      review.coffeeName.length > 12
                          ? 12
                          : review.coffeeName.length),
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: review.brewingMethod != BrewingMethod.any
                      ? Image.asset(
                          correspondingIcon[review.brewingMethod]!,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer
                              .withOpacity(0.7),
                          height: 30,
                          width: 30,
                        )
                      : Row(
                          children: [
                            Image.asset(
                              correspondingIcon[BrewingMethod.espresso]!,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer
                                  .withOpacity(0.7),
                              height: 30,
                              width: 30,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Image.asset(
                              correspondingIcon[BrewingMethod.filter]!,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer
                                  .withOpacity(0.7),
                              height: 30,
                              width: 30,
                            ),
                          ],
                        ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Image.asset(
                    correspondingFlag[review.region]!,
                    width: 25,
                    height: 25,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    capitalizeFirstLetter(
                        review.region.toString().substring(7)),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.8),
                          fontSize: 13,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    review.roasteryName.substring(
                        0,
                        review.roasteryName.length > 8
                            ? 8
                            : review.roasteryName.length),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 15,
                        ),
                  ),
                ),
                const Spacer(),
                Text(
                  "${review.coffeePrice.toStringAsFixed(2)} SR",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                StarButton(review: review),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
