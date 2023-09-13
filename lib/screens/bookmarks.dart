import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speciality_coffee_review/widgets/review_item.dart';
import '../providers/bookmarks_provider.dart';

class BookMarksScreen extends ConsumerStatefulWidget {
  const BookMarksScreen({super.key});

  @override
  ConsumerState<BookMarksScreen> createState() {
    return _BookMarksScreenState();
  }
}

class _BookMarksScreenState extends ConsumerState<BookMarksScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(bookmarksProvider.notifier).loadBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    final bookmarkedReviews = ref.watch(bookmarksProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: bookmarkedReviews.isNotEmpty
            ? ListView.builder(
                itemCount: bookmarkedReviews.length,
                itemBuilder: (ctx, index) {
                  return ReviewItem(review: bookmarkedReviews[index]);
                },
              )
            : const Center(
                child: Text(
                  'No bookmarks yet',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
      ),
    );
  }
}
