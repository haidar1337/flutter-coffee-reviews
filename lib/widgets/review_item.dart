import 'package:flutter/material.dart';
import 'package:speciality_coffee_review/models/review.dart';
import 'package:speciality_coffee_review/utilities/util.dart';
import 'package:speciality_coffee_review/widgets/star_button.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({
    super.key,
    required this.review,
  });

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
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        elevation: 8,
        semanticContainer: true,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Image.network(
            review.getImageUrl(),
            fit: BoxFit.cover,
            width: double.infinity,
            height: 100,
            alignment: Alignment.topCenter,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            review.getCoffeeName(),
            maxLines: 1,
            overflow: TextOverflow.clip,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 5),
            child: Row(
              children: [
                Image.asset(
                  correspondingFlag[review.getRegion()]!,
                  width: 25,
                  height: 25,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  capitalizeFirstLetter(
                      review.getRegion().toString().substring(7)),
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
            padding: const EdgeInsets.only(left: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                review.getRoasteryName(),
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 15,
                    ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: review.getBrewingMethod() != BrewingMethod.any
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "${review.getCoffeePrice().toStringAsFixed(2)} SR",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const Spacer(),
              StarButton(review: review)
            ],
          ),
        ]),
      ),
    );
  }
}
