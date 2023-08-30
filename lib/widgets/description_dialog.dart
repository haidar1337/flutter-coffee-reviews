import 'package:flutter/material.dart';

class DescriptionDialog extends StatelessWidget {
  const DescriptionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var description = '';

    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                maxLength: 1200,
                maxLines: 20,
                onChanged: (value) {
                  description = value;
                },
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white),
                decoration: InputDecoration(
                  fillColor: const Color.fromARGB(99, 108, 106, 106),
                  filled: true,
                  labelText: 'Description (optional)',
                  alignLabelWithHint: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 41, 40, 46),
                    ),
                  ),
                  labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Close',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color:
                                Theme.of(context).colorScheme.onErrorContainer,
                          ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  FilledButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop(description);
                    },
                    icon: const Icon(Icons.save),
                    label: Text(
                      'Save',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
