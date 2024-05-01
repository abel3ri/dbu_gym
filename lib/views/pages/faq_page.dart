import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text("FAQs"),
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FAQExpansionTile(
                  title: "How do I join the gym?",
                  body: Text(
                    "Sign up on our app, upload your payment reciept, and Wait for approval. SIMPLE.",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          height: 1.5,
                        ),
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              FAQExpansionTile(
                title: "What are the gym's working hours?",
                body: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    text: "Head over to",
                    children: [
                      TextSpan(
                        text: " gym working sessions ",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            GoRouter.of(context).pushNamed("pricing");
                          },
                        children: [
                          TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            text: "to see the session that fits your need.",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              FAQExpansionTile(
                title: "Is there after gym shower?",
                body: FAQBody(
                  bodyText:
                      "Yes, but it is occupied most of the time. If you're an insider, we recommend you to take shower from your dormitory's block.",
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              FAQExpansionTile(
                title: "Is there nutrition advice available at the gym?",
                body: FAQBody(
                  bodyText: "Not yet but we are working on it.",
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              FAQExpansionTile(
                title: "How do I stay motivated and engaged with my workouts?",
                body: FAQBody(
                  bodyText:
                      "Don't you worry! There will be a lot of young and motivating professionals working along with you.",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class FAQBody extends StatelessWidget {
  String bodyText;
  FAQBody({
    super.key,
    required this.bodyText,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      bodyText,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            height: 1.5,
          ),
    );
  }
}

// ignore: must_be_immutable
class FAQExpansionTile extends StatelessWidget {
  String title;
  Widget body;
  FAQExpansionTile({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
        ),
        children: [body],
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        childrenPadding:
            EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 16),
        tilePadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        backgroundColor: Theme.of(context).colorScheme.background.darken(3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        expandedAlignment: Alignment.centerLeft,
      ),
    );
  }
}
