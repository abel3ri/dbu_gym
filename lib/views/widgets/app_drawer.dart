import "package:flex_color_scheme/flex_color_scheme.dart";
import "package:flutter/material.dart";
import "package:flutter_zoom_drawer/flutter_zoom_drawer.dart";

// ignore: must_be_immutable
class AppZoomDrawer extends StatelessWidget {
  Widget mainScreen;
  Widget? title;
  List<Widget>? appBarActions;

  AppZoomDrawer({
    super.key,
    this.appBarActions,
    this.title,
    required this.mainScreen,
  });

  @override
  Widget build(BuildContext context) {
    ZoomDrawerController zoomDrawerController = ZoomDrawerController();
    return ZoomDrawer(
      controller: zoomDrawerController,
      mainScreenTapClose: true,
      slideWidth: MediaQuery.of(context).size.width * 0.7,
      menuBackgroundColor: Theme.of(context).colorScheme.primary.darken(20),
      angle: 0,
      menuScreen: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary.darken(20),
        body: Container(
          child: Center(
            child: Text(
              "Hello",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      mainScreen: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                ZoomDrawer.of(context)!.toggle();
              },
              icon: Icon(Icons.sort),
            ),
            actions: appBarActions,
            title: title,
            titleTextStyle: Theme.of(context).textTheme.bodyLarge,
            // centerTitle: true,
          ),
          body: mainScreen,
        );
      }),
    );
  }
}
