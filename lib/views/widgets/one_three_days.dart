import 'package:carousel_slider/carousel_slider.dart';
import 'package:dbu_gym/providers/pricing_provider.dart';
import 'package:dbu_gym/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OneThreeCarouselSlider extends StatelessWidget {
  const OneThreeCarouselSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: pricingContent["1-3Days"]!.length,
      itemBuilder: (context, index, realIndex) => LayoutBuilder(
        builder: (context, constraints) => Stack(
          alignment: Alignment(0, 0.7),
          children: [
            Card(
              elevation: 0.5,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Workout type",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    )),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02),
                        Text(
                          pricingContent['1-3Days']![index]['workoutType']!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Image.asset(
                      pricingContent['1-3Days']![index]['imagePath']!,
                      height: constraints.maxHeight * 0.6,
                    ),
                    Expanded(child: SizedBox()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Price for Insiders",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          pricingContent['1-3Days']![index]['insidersPrice']!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w900,
                              ),
                        )
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Price for Outsiders",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          pricingContent['1-3Days']![index]['outsidersPrice']!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Text(
              pricingContent["1-3Days"]![index]["noWorkingDays"],
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontFamily: "SwankyandMooMoo",
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
          ],
        ),
      ),
      options: CarouselOptions(
        onPageChanged: (index, reason) {
          Provider.of<PricingProvider>(context, listen: false)
              .changeActiveIndex(index);
        },
        aspectRatio: 16 / 9,
        height: MediaQuery.of(context).size.height * 0.6,
        initialPage: 0,
        viewportFraction: 1,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        enlargeFactor: 0.3,
      ),
    );
  }
}
