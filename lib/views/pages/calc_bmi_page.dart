import 'package:dbu_gym/views/widgets/bmi_input_field.dart';
import 'package:flutter/material.dart';

class CalcBMIPage extends StatelessWidget {
  const CalcBMIPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 36),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Calculate your BMI"),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  BMIInputField(
                    controller: TextEditingController(),
                    inputName: "weightInput",
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  BMIInputField(
                    controller: TextEditingController(),
                    inputName: "heightInput",
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
