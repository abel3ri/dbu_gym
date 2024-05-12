import 'package:carousel_slider/carousel_slider.dart';
import 'package:dbu_gym/providers/pricing_provider.dart';
import 'package:dbu_gym/utils/constants.dart';
import 'package:dbu_gym/views/widgets/price_row.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
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
      itemBuilder: (context, index, realIndex) {
        return LayoutBuilder(
          builder: (context, constraints) => Stack(
            alignment: Alignment(0, 0.7),
            children: [
              Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.background.darken(3),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Workout type",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
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
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04),
                      // since the aerobics image is a bit to large in height compared to the other two im decreasing the height of that particular image
                      Image.asset(
                        pricingContent['1-3Days']![index]['imagePath']!,
                        height: pricingContent['1-3Days']![index]['imagePath']!
                                .toString()
                                .contains("aerobics")
                            ? constraints.maxHeight * 0.5
                            : constraints.maxHeight * 0.6,
                      ),
                      Expanded(child: SizedBox()),
                      PriceRow(
                        workoutDays: "1-3Days",
                        workoutType: (pricingContent['1-3Days']![index]
                                ['workoutType'] as String)
                            .split(" ")
                            .first
                            .toLowerCase(),
                        title: "Price for Insiders",
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      PriceRow(
                        workoutDays: "1-3Days",
                        workoutType: (pricingContent['1-3Days']![index]
                                ['workoutType'] as String)
                            .split(" ")
                            .first
                            .toLowerCase(),
                        title: "Price for Outsiders",
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
        );
      },
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
