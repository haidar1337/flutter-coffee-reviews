import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/review.dart';
import '../providers/bookmarks_provider.dart';

class BookmarkButton extends ConsumerWidget {
  const BookmarkButton({
    super.key,
    required this.review,
  });

  final Review review;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarks = ref.watch(bookmarksProvider);
    bool isBookmarked = false;
    if (bookmarks.isNotEmpty) {
      isBookmarked =
          bookmarks.any((element) => element.getId() == review.getId());
    }
    return IconButton(
      onPressed: () {
        ref.read(bookmarksProvider.notifier).toggleBookmark(review);
      },
      icon: Icon(
        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
        size: 35,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
