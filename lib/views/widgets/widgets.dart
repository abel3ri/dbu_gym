// ignore_for_file: must_be_immutable

import 'package:dbu_gym/controllers/providers/form_provider.dart';
import 'package:email_validator/email_validator.dart';
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
        top: MediaQuery.of(context).size.height * 0.1,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            formType == "Login" ? "Welcome back!" : "It Won't take long!",
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
            key: formProvider.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: formProvider.emailController,
                  decoration: InputDecoration(
                    label: Text("E-mail"),
                    labelStyle: TextStyle(color: Colors.grey),
                    hintText: "abebe@yahoo.com",
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
                formType == "Sign up"
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      )
                    : SizedBox(),
                formType == "Sign up"
                    ? TextFormField(
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
                          if (value!.isEmpty)
                            return "Please provide a password.";

                          if (value.length < 8) {
                            return "Password must be at least 8 characters.";
                          }
                          if (formProvider.passwordController.text != value) {
                            return "Password do not match";
                          }
                          return null;
                        },
                      )
                    : SizedBox(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                FilledButton(
                  onPressed: () {
                    if ((Provider.of<FormProvider>(context, listen: false)
                            .formKey as GlobalKey<FormState>)
                        .currentState!
                        .validate()) {}
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
