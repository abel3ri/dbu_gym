import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class CalcBMIPage extends StatelessWidget {
  const CalcBMIPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 36),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  Text("Calculate your BMI"),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  TextField(
                    decoration: InputDecoration(
                      fillColor:
                          Theme.of(context).colorScheme.background.darken(5),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  TextField(
                    decoration: InputDecoration(
                      fillColor:
                          Theme.of(context).colorScheme.background.darken(5),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  FilledButton(onPressed: () {}, child: Text("Calculate")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
