import 'package:dbu_gym/providers/pricing_provider.dart';
import 'package:dbu_gym/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PricingPage extends StatelessWidget {
  const PricingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pricingProvider = Provider.of<PricingProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pricing & Workout Sessions",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Workout days",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text("1-3 days",
                              style: Theme.of(context).textTheme.bodySmall),
                          Switch(
                              value: pricingProvider.oneThreeDays,
                              onChanged: (value) {
                                Provider.of<PricingProvider>(context,
                                        listen: false)
                                    .toggleOneThreeDays(value);
                              }),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.015),
                          Text("4-6 days",
                              style: Theme.of(context).textTheme.bodySmall),
                          Switch(
                              value: pricingProvider.fourSixDays,
                              onChanged: (value) {
                                Provider.of<PricingProvider>(context,
                                        listen: false)
                                    .toggleFourSixDays(value);
                              }),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  if (pricingProvider.oneThreeDays)
                    OneThreeCarouselSlider()
                  else
                    FourSixCarouselSlider(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Center(
                    child: AnimatedSmoothIndicator(
                      activeIndex: pricingProvider.activeIndex,
                      count: pricingContent['1-3Days']!.length,
                      effect: ExpandingDotsEffect(
                        activeDotColor: Theme.of(context).colorScheme.primary,
                        dotHeight: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
              elevation: 2,
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
                    if (pricingContent['4-6Days']![index]['imagePath'].length >
                        1)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // since pricing image 3 a bit larger in width, im decreasing the width by 5%
                          Image.asset(
                            pricingContent['4-6Days']![index]['imagePath'][0]!,
                            height: pricingContent['4-6Days']![index]
                                        ['imagePath'][0]!
                                    .toString()
                                    .contains("_3")
                                ? constraints.maxHeight * 0.35
                                : constraints.maxHeight * 0.4,
                          ),
                          Image.asset(
                            pricingContent['4-6Days']![index]['imagePath'][1]!,
                            height: constraints.maxHeight * 0.4,
                          ),
                        ],
                      )
                    else
                      Image.asset(
                        pricingContent['4-6Days']![index]['imagePath'][0],
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
                          pricingContent['4-6Days']![index]['insidersPrice']!,
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
                          pricingContent['4-6Days']![index]['outsidersPrice']!,
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
              pricingContent["4-6Days"]![index]["noWorkingDays"],
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontFamily: GoogleFonts.swankyAndMooMoo().fontFamily,
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
        enlargeFactor: 0,
      ),
    );
  }
}

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
              elevation: 2,
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
                    fontFamily: GoogleFonts.swankyAndMooMoo().fontFamily,
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
        enlargeFactor: 0,
      ),
    );
  }
}
