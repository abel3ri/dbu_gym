import 'package:dbu_gym/providers/carousel_provider.dart';
import 'package:dbu_gym/providers/locale_provider.dart';
import 'package:dbu_gym/utils/constants.dart';
import 'package:dbu_gym/utils/context_extension.dart';
import 'package:dbu_gym/views/widgets/app_drawer.dart';
import 'package:dbu_gym/views/widgets/btns/signup_login_button.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppZoomDrawer(
      mainScreen: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.localizations.welcome,
                  style: textTheme.headlineLarge!.copyWith(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize:
                        Provider.of<LocaleProvider>(context).locale == 'en'
                            ? 48
                            : 38,
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
                  // carouselController: carouselController,
                  itemCount: 3,
                  itemBuilder: (context, index, realIndex) => Container(
                    width: MediaQuery.of(context).size.width,
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
                    child: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: 16,
                            ),
                            width: MediaQuery.of(context).size.width * 0.65,
                            child: Text(
                              AppData.carouselContent[index]['headline'],
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              softWrap: true,
                            ),
                          ),
                          Image.asset(
                            "${AppData.carouselContent[index]['image_path']}",
                          ),
                        ],
                      ),
                    ),
                  ),
                  options: CarouselOptions(
                    aspectRatio: 16 / 9,
                    height: 260,
                    initialPage: 1,
                    viewportFraction: 0.9,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    enlargeFactor: 0.6,
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
              ],
            ),
            Column(
              children: [
                TextButton(
                  style: ButtonStyle(
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ))),
                  onPressed: () {
                    GoRouter.of(context).pushNamed("pricing");
                  },
                  child: Text(context.localizations.checkoutSessionsPricing),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.012),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SignUpLoginButton(
                      buttonName: "Sign up",
                      btnText: context.localizations.signup,
                      onPressed: () {
                        GoRouter.of(context).pushNamed("signup");
                      },
                    ),
                    SizedBox(width: 8),
                    SignUpLoginButton(
                      buttonName: "Login",
                      btnText: context.localizations.login,
                      onPressed: () {
                        GoRouter.of(context).pushNamed("login");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
