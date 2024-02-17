import 'package:dbu_gym/controllers/providers/carousel_provider.dart';
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
                    color: Colors.grey.shade700,
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
                CarouselSlider.builder(
                  carouselController: carouselController,
                  itemCount: 3,
                  itemBuilder: (context, index, realIndex) => Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withAlpha(230),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            left: 10,
                            top: 10,
                          ),
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            "Achieve Your Fitness Goals With Us.",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            softWrap: true,
                          ),
                        ),
                        Image.asset(
                          alignment: Alignment.centerRight,
                          "assets/images/fitness.png",
                        ),
                      ],
                    ),
                  ),
                  options: CarouselOptions(
                    aspectRatio: 16 / 9,
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
                  count: 3,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Theme.of(context).primaryColor,
                    dotHeight: 10,
                  ),
                ),
                // SizedBox()
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                  onPressed: () {},
                  child: Text("Sign up"),
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(120, 44)),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Login"),
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(120, 44)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
