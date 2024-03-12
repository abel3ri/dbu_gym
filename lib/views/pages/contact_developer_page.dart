import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContactDeveloperPage extends StatelessWidget {
  const ContactDeveloperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get in touch."),
        titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            ContactPageListTile(
              title: "abelmerete@yahoo.com",
              icon: Icons.email,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            ContactPageListTile(
              title: "+251963647311",
              icon: Icons.phone,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            ContactPageListTile(
              title: "@a_be_l",
              icon: Icons.telegram,
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ContactPageListTile extends StatelessWidget {
  String title;
  IconData icon;
  ContactPageListTile({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            // color: Colors.white,
            ),
      ),
      tileColor: Theme.of(context).colorScheme.background.darken(10),
    );
  }
}
