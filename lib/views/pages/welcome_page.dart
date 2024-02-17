import 'package:dbu_gym/controllers/providers/carousel_provider.dart';
import 'package:dbu_gym/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final CarouselController carouselController = CarouselController();

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome!",
                  style: textTheme.headlineLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 48,
                  ),
                ),
                Text(
                  "DBU Gym.",
                  style: textTheme.headlineMedium!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                CarouselSlider(
                  carouselController: carouselController,
                  items: carouselItems,
                  options: CarouselOptions(
                    aspectRatio: 16 / 9,
                    autoPlay: true,
                    height: 200,
                    viewportFraction: 0.9,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    onPageChanged: (index, reason) =>
                        Provider.of<CarouselProvider>(context, listen: false)
                            .changeItemIndex(index),
                  ),
                ),
                SizedBox(height: 10),
                AnimatedSmoothIndicator(
                  activeIndex: Provider.of<CarouselProvider>(context)
                      .currentCarouselItemIndex,
                  count: carouselItems.length,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
