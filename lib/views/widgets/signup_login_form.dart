// ignore_for_file: must_be_immutable

import 'package:dbu_gym/controllers/providers/form_provider.dart';
import 'package:dbu_gym/views/widgets/date_picker_input.dart';
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
          Form(
            key: formType == "Login"
                ? formProvider.loginFormKey
                : formProvider.signUpFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FormInputField(
                  controller: formProvider.emailController,
                  labelText: "E-mail",
                  prefixIcon: Icon(Icons.email),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                FormInputField(
                  controller: formProvider.passwordController,
                  labelText: "Password",
                  prefixIcon: Icon(Icons.password),
                  showPassword: formProvider.showPassword,
                  formType: formType,
                ),
                if (formType == "Sign up")
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                if (formType == "Sign up")
                  FormInputField(
                    controller: formProvider.rePasswordController,
                    labelText: "Re-enter password",
                    prefixIcon: Icon(Icons.password),
                    showPassword: formProvider.showPassword,
                  ),
                if (formType == "Sign up")
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                if (formType == "Sign up")
                  Row(
                    children: [
                      Flexible(
                        child: DatePickerInputField(
                          controller: formProvider.startDateController,
                          labelText: "Start Date",
                          helpText: "Start date of your gym plan",
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      Flexible(
                        child: DatePickerInputField(
                          controller: formProvider.endDateController,
                          labelText: "End Date",
                          helpText: "End date of your gym plan",
                        ),
                      ),
                    ],
                  ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                FilledButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus!.hasFocus
                        ? FocusManager.instance.primaryFocus!.unfocus()
                        : null;
                    if (formType == "Login") {
                      // valid login inputs
                      if (formProvider.loginFormKey.currentState!.validate()) {}
                    } else {
                      // valid sign up inputs
                      if (formProvider.signUpFormKey.currentState!
                          .validate()) {}
                    }
                  },
                  child: Text(formType == "Login" ? "Login" : "Sign up"),
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
