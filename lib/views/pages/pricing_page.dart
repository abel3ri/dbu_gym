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
                    itemCount: 3,
                    itemBuilder: (context, index, realIndex) => Card(
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
                                    width: MediaQuery.of(context).size.width *
                                        0.02),
                                Text(
                                  "Strength Training",
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
                                height:
                                    MediaQuery.of(context).size.height * 0.04),
                            Image.asset(
                              "assets/images/pricing_page_image_1.png",
                              width: MediaQuery.of(context).size.width * 0.5,
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  "250 ETB/month",
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
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  "350 ETB/month",
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
                    options: CarouselOptions(
                      aspectRatio: 16 / 9,
                      height: MediaQuery.of(context).size.height * 0.55,
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
