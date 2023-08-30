import 'package:flutter/material.dart';
import 'package:speciality_coffee_review/utilities/util.dart';

import '../models/review.dart';
import '../widgets/bookmark_button.dart';

class PostDetailsScreen extends StatelessWidget {
  const PostDetailsScreen({super.key, required this.review});

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(review.coffeeName),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
        child: ListView(
          children: [
            Image.network(
              review.imageUrl,
              width: double.infinity,
              height: 300,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  review.coffeeName.length > 25
                      ? '${review.coffeeName.substring(0, 25)}...'
                      : review.coffeeName,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.star_border,
                    size: 30,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Text(review.stars.toString(),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Image.asset(
                  correspondingFlag[review.region]!,
                  width: 50,
                  height: 50,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  capitalizeFirstLetter(
                    review.region.toString().substring(7),
                  ),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                const Spacer(),
                review.brewingMethod == BrewingMethod.any
                    ? Row(
                        children: [
                          Image.asset(
                            correspondingIcon[BrewingMethod.filter]!,
                            height: 50,
                            width: 50,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          Image.asset(
                            correspondingIcon[BrewingMethod.espresso]!,
                            height: 50,
                            width: 50,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ],
                      )
                    : Image.asset(
                        correspondingIcon[review.brewingMethod]!,
                        height: 50,
                        width: 50,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              review.roasteryName,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            Row(
              children: [
                Text(
                  '${review.coffeePrice.toStringAsFixed(2)} SR',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                BookmarkButton(
                  review: review,
                ),
              ],
            ),
            Text(
              'Description:',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              review.description == '' ? 'No description' : review.description,
              maxLines: 20,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Created at ${review.createdAt.toDate().toString().substring(0, 10)} on ${review.createdAt.toDate().toString().substring(11, 16)} ${review.createdAt.toDate().hour >= 12 ? 'PM' : 'AM'}',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
