import 'package:dbu_gym/providers/bmi_provider.dart';
import 'package:dbu_gym/views/widgets/bmi_input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalcBMIPage extends StatelessWidget {
  const CalcBMIPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bmiProvider = Provider.of<BMIProvider>(context);
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
              child: Form(
                key: bmiProvider.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Calculate your BMI"),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    BMIInputField(
                      controller: bmiProvider.weightController,
                      inputName: "weightInput",
                      bmiProvider: bmiProvider,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    BMIInputField(
                      controller: bmiProvider.heightController,
                      inputName: "heightInput",
                      bmiProvider: bmiProvider,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    FilledButton(
                      onPressed: () {
                        if (bmiProvider.formKey.currentState!.validate()) {
                          bmiProvider.calcBMI();
                        }
                      },
                      child: Text("Calculate"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
