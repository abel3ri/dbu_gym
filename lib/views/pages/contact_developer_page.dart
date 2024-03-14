import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDeveloperPage extends StatelessWidget {
  const ContactDeveloperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get in touch"),
        titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.primary.darken(20),
              ),
              // padding: EdgeInsets.symmetric(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ContactIcon(icon: Icons.phone),
                  ContactIcon(icon: Icons.telegram),
                  ContactIcon(icon: Icons.email),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ContactIcon extends StatelessWidget {
  IconData icon;
  ContactIcon({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40,
      foregroundColor: Colors.transparent,
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: IconButton(
        onPressed: () async {
          await launchUrl(
            Uri.parse(
              icon == Icons.email
                  ? "mailto:abelmerete@yahoo.com?subject=Forwarded from gym app"
                  : icon == Icons.telegram
                      ? "https://t.me/@a_be_l"
                      : "tel:+251963647311",
            ),
          );
        },
        icon: Icon(icon),
        iconSize: 56,
        color: Colors.white,
      ),
    );
  }
}
