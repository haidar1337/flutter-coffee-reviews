import 'package:flutter/material.dart';

class CreationButton extends StatefulWidget {
  const CreationButton({super.key, required this.onCreatePost});

  final Future<bool> Function() onCreatePost;

  @override
  State<StatefulWidget> createState() {
    return _BottomSheetButtons();
  }
}

class _BottomSheetButtons extends State<CreationButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 150,
          child: FilledButton.icon(
            onPressed: _isLoading
                ? () {}
                : () async {
                    setState(() {
                      _isLoading = true;
                    });
                    final res = await widget.onCreatePost();
                    if (res) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            content: Text(
                              'Your review has been successfully posted',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        );
                        Navigator.of(context).pop();
                      }
                    } else {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
            icon: const Icon(
              Icons.create,
              size: 25,
            ),
            label: _isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    'Create',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
          ),
        ),
      ],
    );
  }
}
