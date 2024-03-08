// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:dbu_gym/controllers/form_input_validator.dart';
import 'package:dbu_gym/controllers/user_controller.dart';
import 'package:dbu_gym/providers/form_provider.dart';
import 'package:dbu_gym/providers/image_provider.dart';
import 'package:dbu_gym/utils/clear_form_inputs.dart';
import 'package:dbu_gym/views/pages/image_pick_selector.dart';
import 'package:dbu_gym/views/widgets/date_picker_input.dart';
import 'package:dbu_gym/views/widgets/signup_form_drop_down_btn.dart';
import 'package:dbu_gym/views/widgets/signup_login_form_input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';

class FormWidget extends StatelessWidget {
  String formType;

  FormWidget({
    required this.formType,
  });

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);
    final imageProvider = Provider.of<ProfileImageProvider>(context);

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        top: formType == "Login"
            ? MediaQuery.of(context).size.height * 0.1
            : MediaQuery.of(context).size.height * 0.05,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            formType == "Login" ? "Welcome back!" : "It won't take long!",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Text(
            formType == "Login" ? "Login" : "Sign up",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          if (formType == "Sign up")
            Stack(
              alignment: Alignment(1.2, 1.2),
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundImage: imageProvider.imagePath != null
                      ? FileImage(File(imageProvider.imagePath!))
                      : null,
                  child: imageProvider.imagePath == null
                      ? Icon(Icons.person, size: 48)
                      : null,
                ),
                GestureDetector(
                  onTap: () async {
                    showModalBottomSheet(
                        showDragHandle: true,
                        constraints: BoxConstraints.tight(Size(
                            MediaQuery.of(context).size.width,
                            MediaQuery.of(context).size.height * 0.3)),
                        context: context,
                        builder: (context) => ImagePickSelector());
                  },
                  child: Icon(
                    Icons.add,
                    size: 30,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              ],
            ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Form(
            key: formType == "Login"
                ? formProvider.loginFormKey
                : formProvider.signUpFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (formType == "Sign up") ...[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Row(
                    children: [
                      Flexible(
                        child: FormInputField(
                          labelText: "First name",
                          prefixIcon: Icon(Icons.person),
                          controller: formProvider.firstNameController,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Flexible(
                        child: FormInputField(
                          labelText: "Last name",
                          prefixIcon: Icon(Icons.person),
                          controller: formProvider.lastNameController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ],
                FormInputField(
                  controller: formProvider.emailController,
                  labelText: "E-mail",
                  prefixIcon: Icon(Icons.email),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                FormInputField(
                  controller: formProvider.passwordController,
                  labelText: "Password",
                  prefixIcon: Icon(Icons.password),
                  showPassword: formProvider.showPassword,
                  formType: formType,
                ),
                if (formType == "Sign up") ...[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  FormInputField(
                    controller: formProvider.rePasswordController,
                    labelText: "Re-enter password",
                    prefixIcon: Icon(Icons.password),
                    showPassword: formProvider.showPassword,
                    formType: formType,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Stack(
                    alignment: Alignment(-0.8, 1),
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: DatePickerInputField(
                              controller: formProvider.startDateController,
                              labelText: "Gym Start Date",
                              helpText: "Start date of your gym plan",
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                          ),
                          Flexible(
                            child: DatePickerInputField(
                              controller: formProvider.endDateController,
                              labelText: "Gym End Date",
                              helpText: "End date of your gym plan",
                            ),
                          ),
                        ],
                      ),
                      if (formProvider.hasDateInputError) ...[
                        Text(
                          "Start Date should not exceed End Date.",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                        ),
                      ]
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  DropdownButtonFormField(
                    value: "default",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.grey,
                        ),
                    items: [
                      DropdownMenuItem(
                        value: "default",
                        child: Text(
                          "Select number of workout days",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: "oneThree",
                        child: Text("1-3 Days"),
                      ),
                      DropdownMenuItem(
                        value: "fourSix",
                        child: Text("4-6 Days"),
                      ),
                    ],
                    onChanged: (value) {
                      formProvider.setSelectedWorkoutDays(value!);
                    },
                    validator: dropDownFormFieldValidator,
                  )
                ],
                if (formProvider.selectedWorkoutDays != "default") ...[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  SignUpFormDropDownMenuBtn(
                    workoutDays: formProvider.selectedWorkoutDays,
                  ),
                ],
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                FilledButton(
                  onPressed: () async {
                    FocusManager.instance.primaryFocus!.hasFocus
                        ? FocusManager.instance.primaryFocus!.unfocus()
                        : null;
                    if (formType == "Login") {
                      // valid login inputs
                      if (formProvider.loginFormKey.currentState!.validate()) {
                        await signUpLoginController(
                          formProvider: formProvider,
                          context: context,
                          formType: formType,
                        );
                        // clear all form inputs after submitting the form
                        clearFormInputs(context);
                      }
                    } else {
                      // valid sign up inputs
                      if (formProvider.signUpFormKey.currentState!.validate()) {
                        await signUpLoginController(
                          formProvider: formProvider,
                          context: context,
                          formType: formType,
                        );
                        // clear all form inputs after submitting the form
                        clearFormInputs(context);
                      }
                    }
                  },
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(120, 44)),
                  ),
                  child: formProvider.isAuthenticating
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.background,
                            strokeWidth: 3,
                          ),
                        )
                      : Text(formType == "Login" ? "Login" : "Sign up"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(formType == "Login"
                        ? "Don't have an account?"
                        : "Already have an account?"),
                    TextButton(
                      onPressed: () {
                        formType == "Login"
                            ? GoRouter.of(context)
                                .pushReplacementNamed("signup")
                            : GoRouter.of(context)
                                .pushReplacementNamed("login");
                      },
                      child: Text(formType == "Login" ? "Sign up" : "Login"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
