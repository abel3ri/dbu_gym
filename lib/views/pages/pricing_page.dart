import 'package:dbu_gym/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PricingPage extends StatelessWidget {
  const PricingPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                          Switch(value: true, onChanged: (value) {}),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.015),
                          Text("4-6 days",
                              style: Theme.of(context).textTheme.bodySmall),
                          Switch(value: false, onChanged: (value) {}),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  CarouselSlider.builder(
                    itemCount: pricingContent["1-3Days"]!.length,
                    itemBuilder: (context, index, realIndex) => LayoutBuilder(
                      builder: (context, constraints) => Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 12,
                            right: 12,
                            top: 12,
                            // bottom: 8,
                          ),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Workout type",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          )),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.02),
                                  Text(
                                    pricingContent['1-3Days']![index]
                                        ['workoutType']!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.w900,
                                        ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.04),
                              Image.asset(
                                pricingContent['1-3Days']![index]['imagePath']!,
                                height: constraints.maxHeight * 0.6,
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.04),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Price for Insiders",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Text(
                                    pricingContent['1-3Days']![index]
                                        ['insidersPrice']!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.w900,
                                        ),
                                  )
                                ],
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Price for Outsiders",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Text(
                                    pricingContent['1-3Days']![index]
                                        ['outsidersPrice']!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.w900,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    options: CarouselOptions(
                      aspectRatio: 16 / 9,
                      height: MediaQuery.of(context).size.height * 0.7,
                      initialPage: 1,
                      viewportFraction: 1,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      enlargeFactor: 0,
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
