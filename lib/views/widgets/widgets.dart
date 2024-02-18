// ignore_for_file: must_be_immutable

import 'package:dbu_gym/controllers/providers/form_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
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
                TextFormField(
                  controller: formProvider.emailController,
                  decoration: InputDecoration(
                    label: Text("E-mail"),
                    labelStyle: TextStyle(color: Colors.grey),
                    hintText: "abebe@example.com",
                    prefixIcon: Icon(Icons.email),
                    prefixIconColor: Colors.grey,
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty)
                      return "Please provide an email address.";
                    return EmailValidator.validate(value)
                        ? null
                        : "Please provide a valid E-mail address.";
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                TextFormField(
                  controller: formProvider.passwordController,
                  decoration: InputDecoration(
                    label: Text("Password"),
                    labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.password),
                    prefixIconColor: Colors.grey,
                    suffixIcon: IconButton(
                      onPressed: () {
                        Provider.of<FormProvider>(context, listen: false)
                            .toggleShowPassword();
                      },
                      icon: Icon(formProvider.showPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                  obscureText: formProvider.showPassword ? false : true,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value!.isEmpty) return "Please provide a password.";
                    if (value.length < 8) {
                      return "Password must be at least 8 characters.";
                    }
                    if (formType == "Sign up" &&
                        formProvider.rePasswordController.text != value) {
                      return "Password do not match";
                    }
                    return null;
                  },
                ),
                if (formType == "Sign up")
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.015,
                  ),
                if (formType == "Sign up")
                  TextFormField(
                    controller: formProvider.rePasswordController,
                    decoration: InputDecoration(
                      label: Text("Re-enter password"),
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.password),
                      prefixIconColor: Colors.grey,
                    ),
                    obscureText: formProvider.showPassword ? false : true,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value!.isEmpty) return "Please provide a password.";

                      if (value.length < 8) {
                        return "Password must be at least 8 characters.";
                      }
                      if (formProvider.passwordController.text != value) {
                        return "Password do not match";
                      }
                      return null;
                    },
                  ),
                if (formType == "Sign up")
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                if (formType == "Sign up")
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // alignment:
                          //     Alignment(0.25, -2).add(Alignment.topRight),
                          children: [
                            Text(
                              "Sign up as a new user",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                            IconButton(
                              onPressed: () {
                                // showDialog(
                                //   context: context,
                                //   builder: (context) => Container(
                                //     child: Text("Hello"),
                                //   ),
                                // );
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("Is it your first time?"),
                                    titleTextStyle: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                    content: Text(
                                      "If you have been working out before this app is introduced, keep the switch toggled off. \n\nBut if its your first time in the gym, toggle the switch on located on your right.",
                                    ),
                                    actionsPadding: EdgeInsets.all(12),
                                    contentPadding: EdgeInsets.only(
                                      top: 10,
                                      left: 20,
                                      right: 20,
                                      bottom: 0,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          GoRouter.of(context).pop();
                                        },
                                        child: Text("Ok"),
                                      )
                                    ],
                                  ),
                                );
                              },
                              splashColor: Colors.transparent,
                              iconSize: 14,
                              alignment: Alignment(-2.5, -2),
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                  Colors.transparent,
                                ),
                              ),
                              icon: Icon(Icons.help),
                            ),
                          ],
                        ),
                        Switch(value: false, onChanged: (value) {})
                      ],
                    ),
                  ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                FilledButton(
                  onPressed: () {
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
