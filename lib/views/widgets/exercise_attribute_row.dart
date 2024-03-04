import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ExerciseAttributeRow extends StatelessWidget {
  ExerciseAttributeRow({
    super.key,
    required this.attributeName,
    required this.attributeValue,
  });

  String attributeName;
  dynamic attributeValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: attributeValue == 'Secondary Muscles'
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          attributeName,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        attributeName == 'Secondary Muscles'
            ? (attributeValue as List<String>).isEmpty
                ? Text(
                    "None",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  )
                : Flexible(
                    child: Wrap(
                      spacing: 4,
                      children: (attributeValue as List<String>)
                          .map(
                            (e) => Chip(
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                              elevation: 0,
                              labelPadding: EdgeInsets.symmetric(horizontal: 6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(
                                  width: 0.25,
                                ),
                              ),
                              label: Text(
                                e.capitalize,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                          )
                          .toList(),
                    ),
                  )
            : Text(
                attributeValue,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
      ],
    );
  }
}
