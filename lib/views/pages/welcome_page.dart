import 'package:dbu_gym/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final CarouselController carouselController = CarouselController();

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome!",
              style: textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "DBU Gym.",
              style: textTheme.headlineMedium!.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
