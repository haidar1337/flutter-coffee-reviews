import 'package:flutter/material.dart';

import '../screens/create_review.dart';

class PostsContent extends StatelessWidget {
  const PostsContent({
    super.key,
    required this.horizontalReviews,
    required this.verticalReviews,
  });

  final Widget horizontalReviews;
  final Widget verticalReviews;

  @override
  Widget build(BuildContext context) {
    void showReviewCreationScreen() {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const CreateReviewScreen(),
      ));
    }

    return SafeArea(
      child: ListView(children: [
        Padding(
          padding:
              const EdgeInsets.only(bottom: 5, left: 10, top: 5, right: 10),
          child: Text(
            'Coffee Reviews',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Row(
            children: [
              Text(
                'Popular Reviews',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
              const Spacer(),
              FilledButton.icon(
                onPressed: showReviewCreationScreen,
                icon: Icon(
                  Icons.add,
                  size: 20,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                label: Text(
                  'Create Review',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Theme.of(context).colorScheme.onPrimary,
          indent: 10,
          endIndent: 10,
        ),
        horizontalReviews,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'All Reviews',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
        ),
        Divider(
          color: Theme.of(context).colorScheme.onPrimary,
          indent: 10,
          endIndent: 10,
        ),
        verticalReviews,
      ]),
    );
  }
}
