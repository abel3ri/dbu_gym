import "package:flex_color_scheme/flex_color_scheme.dart";
import "package:flutter/material.dart";
import "package:flutter_zoom_drawer/flutter_zoom_drawer.dart";

final menuScreen = Container(
  child: Center(
    child: Text("Hello"),
  ),
);

// ignore: must_be_immutable
class AppZoomDrawer extends StatelessWidget {
  Widget mainScreen;
  AppZoomDrawer({
    super.key,
    required this.mainScreen,
  });

  @override
  Widget build(BuildContext context) {
    ZoomDrawerController zoomDrawerController = ZoomDrawerController();
    return ZoomDrawer(
      controller: zoomDrawerController,
      mainScreenTapClose: true,
      slideWidth: MediaQuery.of(context).size.width * 0.5,
      menuBackgroundColor: Theme.of(context).colorScheme.primary.brighten(10),
      angle: 0,
      menuScreen: menuScreen,
      mainScreen: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                ZoomDrawer.of(context)!.toggle();
              },
              icon: Icon(
                Icons.sort,
                size: 28,
              ),
            ),
          ),
          body: mainScreen,
        );
      }),
    );
  }
}
