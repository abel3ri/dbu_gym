import "package:dbu_gym/providers/theme_provider.dart";
import "package:dbu_gym/utils/constants.dart";
import "package:flex_color_scheme/flex_color_scheme.dart";
import "package:flutter/material.dart";
import "package:flutter_zoom_drawer/flutter_zoom_drawer.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";

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
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.08,
                left: MediaQuery.of(context).size.width * 0.02,
                right: MediaQuery.of(context).size.width * 0.02,
                bottom: MediaQuery.of(context).size.height * 0.01,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        child: Icon(Icons.person),
                        radius: 30,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text(
                          "Profile",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      ListTile(
                        leading: Icon(Provider.of<ThemeProvider>(context)
                                    .getCurrentThemeMode() ==
                                'dark'
                            ? Icons.dark_mode
                            : Icons.light_mode),
                        title: Text(
                          "Theme",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        trailing: DropdownButton(
                          elevation: 0,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          value: Provider.of<ThemeProvider>(context)
                              .getCurrentThemeMode(),
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
                          onChanged: (value) {
                            Provider.of<ThemeProvider>(context, listen: false)
                                .changeSelectedTheme(value!);
                          },
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.money),
                        title: Text(
                          "Manage Subscription",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      ListTile(
                        onTap: () async {
                          await auth.signOut();
                          GoRouter.of(context).pushReplacementNamed("splash");
                        },
                        leading: Icon(Icons.logout_outlined),
                        title: Text(
                          "Logout",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "V 1.0.0",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            "DBU Gym",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 0.5,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Contact Developer",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
