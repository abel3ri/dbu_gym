import "package:dbu_gym/providers/locale_provider.dart";
import "package:dbu_gym/providers/theme_provider.dart";
import "package:dbu_gym/providers/user_provider.dart";
import "package:dbu_gym/utils/constants.dart";
import "package:dbu_gym/utils/context_extension.dart";
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

  // @override
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    ZoomDrawerController zoomDrawerController = ZoomDrawerController();
    return ZoomDrawer(
      controller: zoomDrawerController,
      mainScreenTapClose: true,
      slideWidth: MediaQuery.of(context).size.width * 0.8,
      menuBackgroundColor: Theme.of(context).scaffoldBackgroundColor.darken(2),
      angle: 0,
      menuScreen: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor.darken(2),
        body: SafeArea(
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.06,
                left: MediaQuery.of(context).size.width * 0.02,
                right: MediaQuery.of(context).size.width * 0.02,
                bottom: MediaQuery.of(context).size.height * 0.01,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          context.localizations.settings,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        if (auth.currentUser != null) ...[
                          CircleAvatar(
                            radius: 35,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: userProvider.user != null
                                  ? NetworkImage(
                                      userProvider.user!.profileImageUrl,
                                    )
                                  : null,
                              child: userProvider.user == null
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : null,
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
                          ListTile(
                            leading: Icon(Icons.person),
                            onTap: () {
                              GoRouter.of(context).pushNamed("profile");
                            },
                            titleTextStyle:
                                Theme.of(context).textTheme.bodyMedium,
                            title: Text("Profile"),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
                        ],
                        ListTile(
                          leading: Icon(Provider.of<ThemeProvider>(context)
                                      .getCurrentThemeMode() ==
                                  'dark'
                              ? Icons.dark_mode
                              : Icons.light_mode),
                          titleTextStyle:
                              Theme.of(context).textTheme.bodyMedium,
                          title: Text(context.localizations.theme),
                          trailing: DropdownButton(
                            elevation: 0,
                            underline: const SizedBox.shrink(),
                            alignment: Alignment.centerRight,
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
                          leading: Icon(Icons.language),
                          titleTextStyle:
                              Theme.of(context).textTheme.bodyMedium,
                          title: Text(context.localizations.language),
                          trailing: DropdownButton(
                            elevation: 0,
                            underline: const SizedBox.shrink(),
                            alignment: Alignment.centerRight,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            value: Provider.of<LocaleProvider>(context).locale,
                            style: Theme.of(context).textTheme.bodySmall,
                            items: [
                              DropdownMenuItem(
                                child: Text("English"),
                                value: "en",
                              ),
                              DropdownMenuItem(
                                child: Text("አማርኛ"),
                                value: "am",
                              ),
                            ],
                            onChanged: (value) {
                              Provider.of<LocaleProvider>(context,
                                      listen: false)
                                  .updateLocale(value!);
                            },
                          ),
                        ),
                        if (auth.currentUser != null) ...[
                          ListTile(
                            leading: Icon(Icons.bolt),
                            titleTextStyle:
                                Theme.of(context).textTheme.bodyMedium,
                            title: Text("Manage Subscription"),
                            onTap: () {
                              GoRouter.of(context)
                                  .pushNamed("manage-subscription-page");
                            },
                          ),
                        ],
                        ListTile(
                          onTap: () {
                            GoRouter.of(context).pushNamed("faq");
                          },
                          leading: Icon(Icons.question_mark),
                          titleTextStyle:
                              Theme.of(context).textTheme.bodyMedium,
                          title: Text(context.localizations.faqs),
                        ),
                        if (auth.currentUser != null)
                          ListTile(
                            onTap: () async {
                              await auth.signOut();
                              GoRouter.of(context)
                                  .pushReplacementNamed("splash");
                            },
                            textColor: Theme.of(context).colorScheme.error,
                            iconColor: Theme.of(context).colorScheme.error,
                            leading: Icon(Icons.logout_outlined),
                            titleTextStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                            title: Text("Logout"),
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
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            GoRouter.of(context).pushNamed("contact-dev");
                          },
                          child: Text(
                            context.localizations.contactDev,
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
                  ]),
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
