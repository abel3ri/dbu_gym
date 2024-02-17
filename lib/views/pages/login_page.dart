import 'package:dbu_gym/controllers/providers/form_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import "package:email_validator/email_validator.dart";

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(
            horizontal: 28,
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.1,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome back!",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Text(
                  "Login",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Form(
                  key: Provider.of<FormProvider>(context).formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
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
                              : "Please provider a valid E-mail address.";
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      TextFormField(
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
                            icon: Icon(
                                Provider.of<FormProvider>(context).showPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                          ),
                        ),
                        obscureText:
                            Provider.of<FormProvider>(context).showPassword
                                ? false
                                : true,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value!.isEmpty)
                            return "Please provider a password.";
                          if (value.length < 8) {
                            return "Password must be at least 8 characters.";
                          }
                          return null;
                        },
                      ),
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
                        child: Text("Login"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          TextButton(
                            onPressed: () {},
                            child: Text("Sign up"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
