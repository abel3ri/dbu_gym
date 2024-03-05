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
      slideWidth: MediaQuery.of(context).size.width * 0.8,
      menuBackgroundColor: Theme.of(context).colorScheme.background.darken(2),
      angle: 0,
      menuScreen: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background.darken(2),
        body: SafeArea(
          child: Center(
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.08,
                horizontal: MediaQuery.of(context).size.width * 0.02,
              ),
              children: [
                CircleAvatar(
                  child: Icon(Icons.person),
                  radius: 30,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    "Profile",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                ListTile(
                  leading: Icon(Icons.light_mode),
                  title: Text(
                    "Theme",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: DropdownButton(
                    elevation: 0,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    value: "system",
                    style: Theme.of(context).textTheme.bodySmall,
                    items: [
                      DropdownMenuItem(
                        child: Text("System"),
                        value: "system",
                      ),
                      DropdownMenuItem(
                        child: Text("Light"),
                        value: "light",
                      ),
                      DropdownMenuItem(
                        child: Text("Dark"),
                        value: "dark",
                      ),
                    ],
                    onChanged: (value) {},
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.money),
                  title: Text(
                    "Manage Subscription",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              ],
            ),
          ),
        ),
      ),
      mainScreen: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
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
