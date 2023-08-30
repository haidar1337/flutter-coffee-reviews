import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speciality_coffee_review/providers/reviews_provider.dart';
import 'package:speciality_coffee_review/screens/bookmarks.dart';
import 'package:speciality_coffee_review/widgets/posts_content.dart';
import 'package:speciality_coffee_review/widgets/review_item.dart';

import '../models/review.dart';
import '../widgets/popular_review_item.dart';

class PostsScreen extends ConsumerStatefulWidget {
  const PostsScreen({super.key});

  @override
  ConsumerState<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends ConsumerState<PostsScreen> {
  final scrollController = ScrollController();
  List<Review> reviewsList = [];
  int currentIndex = 0;

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reviewsStream = ref.watch(reviewsProvider);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.reviews),
            label: 'Reviews',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmarks',
          )
        ],
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: currentIndex == 0
          ? reviewsStream.when(
              error: (error, stackTrace) => Center(
                child: Text(
                  error.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              loading: () => const PostsContent(
                horizontalReviews: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
                verticalReviews: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
              data: (reviews) {
                List<Review> popularReviews = List.from(reviews);
                popularReviews.sort((a, b) => b.stars.compareTo(a.stars));
                popularReviews.sublist(
                    0, popularReviews.length > 5 ? 5 : popularReviews.length);
                return reviews.isNotEmpty
                    ? PostsContent(
                        horizontalReviews: SizedBox(
                          height: 200,
                          child: ListView.builder(
                            itemCount: popularReviews.length,
                            scrollDirection: Axis.horizontal,
                            controller: scrollController,
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            itemExtent: 250,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: PopularReviewItem(
                                  review: popularReviews[index],
                                ),
                              );
                            },
                          ),
                        ),
                        verticalReviews: reviewsStream.when(
                          data: (reviews) {
                            return GridView.builder(
                              itemCount: reviews.length,
                              scrollDirection: Axis.vertical,
                              controller: scrollController,
                              padding:
                                  const EdgeInsets.only(left: 25, right: 25),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 300 / 485,
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                              ),
                              itemBuilder: (context, index) {
                                return ReviewItem(
                                  review: reviews[index],
                                );
                              },
                              shrinkWrap: true,
                            );
                          },
                          error: (error, stackTrace) => Center(
                            child: Text(
                              error.toString(),
                            ),
                          ),
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      )
                    : const Center(
                        child: Text('No reviews yet!'),
                      );
              },
            )
          : const BookMarksScreen(),
    );
  }
}
