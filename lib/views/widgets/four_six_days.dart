import 'package:carousel_slider/carousel_slider.dart';
import 'package:dbu_gym/providers/pricing_provider.dart';
import 'package:dbu_gym/utils/constants.dart';
import 'package:dbu_gym/views/widgets/price_row.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FourSixCarouselSlider extends StatelessWidget {
  const FourSixCarouselSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: pricingContent["4-6Days"]!.length,
      itemBuilder: (context, index, realIndex) => LayoutBuilder(
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
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    )),
                        // SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                        SizedBox(width: constraints.maxHeight * 0.02),
                        Text(
                          pricingContent['4-6Days']![index]['workoutType']!,
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
                    // if its bundled offer it will have tow images (eg cardio + strength)
                    if (pricingContent['4-6Days']![index]['imagePath'].length >
                        1)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // since pricing image 3 a bit larger in width, im decreasing the width by 5%
                          Expanded(
                            child: Image.asset(
                              pricingContent['4-6Days']![index]['imagePath']
                                  [0]!,
                              height: pricingContent['4-6Days']![index]
                                          ['imagePath'][0]!
                                      .toString()
                                      .contains("aerobics")
                                  ? constraints.maxHeight * 0.31
                                  : constraints.maxHeight * 0.4,
                            ),
                          ),
                          Text("&",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                    fontSize: 32,
                                    fontFamily: "SwankyandMooMoo",
                                    fontWeight: FontWeight.bold,
                                  )),
                          Expanded(
                            child: Image.asset(
                              pricingContent['4-6Days']![index]['imagePath']
                                  [1]!,
                              height: constraints.maxHeight * 0.35,
                            ),
                          ),
                        ],
                      )
                    else
                      Image.asset(
                        pricingContent['4-6Days']![index]['imagePath'][0],
                        height: constraints.maxHeight * 0.6,
                      ),
                    Expanded(child: SizedBox()),
                    PriceRow(
                      workoutDays: '4-6Days',
                      index: index,
                      title: "Price for Insiders",
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    PriceRow(
                      workoutDays: '4-6Days',
                      index: index,
                      title: "Price for Outsiders",
                    )
                  ],
                ),
              ),
            ),
            Text(
              pricingContent["4-6Days"]![index]["noWorkingDays"],
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontFamily: "SwankyandMooMoo",
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.error,
                  ),
            )
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
