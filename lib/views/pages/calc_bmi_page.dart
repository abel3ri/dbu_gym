import 'package:dbu_gym/providers/bmi_provider.dart';
import 'package:dbu_gym/views/widgets/input_fields/bmi_input_field.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:awesome_dialog/awesome_dialog.dart";

class CalcBMIPage extends StatelessWidget {
  const CalcBMIPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bmiProvider = Provider.of<BMIProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Form(
                  key: bmiProvider.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Calculate your BMI"),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      BMIInputField(
                        controller: bmiProvider.weightController,
                        inputName: "weightInput",
                        bmiProvider: bmiProvider,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      BMIInputField(
                        controller: bmiProvider.heightController,
                        inputName: "heightInput",
                        bmiProvider: bmiProvider,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      FilledButton(
                        onPressed: () {
                          if (bmiProvider.formKey.currentState!.validate()) {
                            bmiProvider.calcBMI();
                          }
                          FocusScope.of(context).unfocus();
                        },
                        child: Text("Calculate"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // show container if the bmi is not empty (equals 0)
            if (bmiProvider.bmi != '0.00') ...[
              // SizedBox(
              //     height: MediaQuery.of(context).size.height * 0.02),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.only(bottom: 24, top: 8, left: 8, right: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background.darken(5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06),
                        Text(
                          "Your BMI is ${bmiProvider.bmi}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        IconButton(
                          alignment: Alignment.topRight.add(
                            Alignment(-4.5, -0.7),
                          ),
                          onPressed: () {
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.scale,
                              dialogType: DialogType.info,
                              title: "Optimum BMI Range",
                              body: Text(
                                "Body Mass Index is used to estimate your total amount of fat. It is only an approximate measure of the best weight for your health. A healthy BMI for an adult is between 20 and 25. ",
                                style: TextStyle(height: 1.5),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 12,
                              ),
                              showCloseIcon: true,
                              autoDismiss: true,
                              autoHide: Duration(seconds: 10),
                              headerAnimationLoop: false,
                            )..show();
                          },
                          icon: Icon(Icons.help_outline_outlined),
                          iconSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Text(
                      bmiProvider.bmiMessageMap(double.parse(bmiProvider.bmi)),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.grey.shade600,
                            height: 1.5,
                          ),
                    ),
                  ],
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
