import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReviewImagePicker extends StatefulWidget {
  const ReviewImagePicker({super.key, required this.onPickImage});

  final Function(File? pickedImage) onPickImage;

  @override
  State<ReviewImagePicker> createState() {
    return _ReviewImagePickerState();
  }
}

class _ReviewImagePickerState extends State<ReviewImagePicker> {
  File? _pickedImage;

  void pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }

    setState(() {
      _pickedImage = File(image.path);
    });

    widget.onPickImage(_pickedImage);
  }

  void deleteImage() {
    setState(() {
      _pickedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
        TextButton(
          onPressed: pickImage,
          child: const Text(
            'Add Image (optional)',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        TextButton(
          onPressed: deleteImage,
          child: Text(
            'Delete Image',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onErrorContainer,
            ),
          ),
        ),
      ],
    );
  }
}
