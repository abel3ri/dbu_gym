import 'package:dbu_gym/providers/pricing_provider.dart';
import 'package:dbu_gym/utils/constants.dart';
import 'package:dbu_gym/views/pages/workout_sessions_page.dart';
import 'package:dbu_gym/views/widgets/four_six_days.dart';
import 'package:dbu_gym/views/widgets/one_three_days.dart';
import 'package:flutter/material.dart';
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 36),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pricing",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
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
                                  width: MediaQuery.of(context).size.width *
                                      0.015),
                              Text("4-6 days",
                                  style: Theme.of(context).textTheme.bodySmall),
                              Switch(
                                value: pricingProvider.fourSixDays,
                                onChanged: (value) {
                                  Provider.of<PricingProvider>(context,
                                          listen: false)
                                      .toggleFourSixDays(value);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      if (pricingProvider.oneThreeDays)
                        OneThreeCarouselSlider()
                      else
                        FourSixCarouselSlider(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Center(
                        child: AnimatedSmoothIndicator(
                          activeIndex: pricingProvider.activeIndex,
                          count: pricingContent['1-3Days']!.length,
                          effect: ExpandingDotsEffect(
                            activeDotColor:
                                Theme.of(context).colorScheme.primary,
                            dotHeight: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                // workout sessions widget
                WorkoutSessionPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
