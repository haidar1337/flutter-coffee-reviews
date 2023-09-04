import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speciality_coffee_review/models/review_database.dart';
import 'package:speciality_coffee_review/widgets/creation_button.dart';
import 'package:speciality_coffee_review/widgets/description_dialog.dart';
import 'package:speciality_coffee_review/widgets/review_image_picker.dart';
import 'package:speciality_coffee_review/widgets/review_text_field.dart';
import 'package:speciality_coffee_review/widgets/type_selector.dart';

import '../models/review.dart';
import '../utilities/util.dart';

class CreateReviewScreen extends ConsumerStatefulWidget {
  const CreateReviewScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ReviewBottomSheetState();
  }
}

class _ReviewBottomSheetState extends ConsumerState<CreateReviewScreen> {
  final regions = Region.values.toList();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var name = '';
  var roastery = '';
  double price = 0.0;
  var region = Region.other;
  BrewingMethod? brewingMethod;
  File? image;
  var description = '';

  Future<bool> createPost() async {
    if (!_formKey.currentState!.validate()) {
      return false;
    }

    _formKey.currentState!.save();

    image ??= await getImageFileFromAssets('coffee.jpg');
    final imageUrl = await ReviewDatabase.getImageUrl(image!);

    final review = Review(
      description,
      brewingMethod,
      imageUrl: imageUrl,
      coffeeName: name,
      coffeePrice: price,
      roasteryName: roastery,
      region: region,
    );

    ReviewDatabase.createReview(review);

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Review'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  ReviewImagePicker(
                    onPickImage: (pickedImage) {
                      if (pickedImage != null) {
                        image = pickedImage;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ReviewTextField(
                    labelText: 'Coffee',
                    maxLength: 50,
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          value.trim().length < 4) {
                        return 'Coffee name must be 4 characters long at least';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      name = value!;
                    },
                  ),
                  ReviewTextField(
                    maxLength: 50,
                    labelText: 'Roastery',
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          value.trim().length < 4) {
                        return 'Roastery name must be 4 characters long at least';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      roastery = value!;
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ReviewTextField(
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                int.tryParse(value) == null ||
                                double.tryParse(value) == null ||
                                int.parse(value) <= 0) {
                              return 'Price must be a number value';
                            }
                            return null;
                          },
                          onSaved: ((newValue) {
                            price = double.parse(newValue!);
                          }),
                          labelText: 'Price',
                          maxLength: 5,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            fillColor: const Color.fromARGB(99, 108, 106, 106),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 41, 40, 46),
                              ),
                            ),
                            labelText: 'Region',
                            labelStyle: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                ),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Select the coffee region';
                            }
                            return null;
                          },
                          items: regions
                              .map(
                                (region) => DropdownMenuItem<Region>(
                                  value: region,
                                  child: Text(
                                    capitalizeFirstLetter(region.name),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                          },
                          onSaved: (newValue) {
                            region = newValue!;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Filter or Espresso? (optional):',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TypeSelector(
                    onSelectType: (selectedType) {
                      brewingMethod = selectedType;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilledButton.icon(
                        onPressed: () async {
                          description = await showDialog(
                            context: context,
                            useSafeArea: true,
                            builder: (ctx) {
                              return const DescriptionDialog();
                            },
                          );
                        },
                        icon: const Icon(Icons.add),
                        label: Text(
                          'Add Descirption',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '(optional)',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CreationButton(onCreatePost: createPost),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
