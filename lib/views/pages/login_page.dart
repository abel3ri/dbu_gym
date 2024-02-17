import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // GlobalKey _formKey = GlobalKey<FormState>();
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
              top: MediaQuery.of(context).size.height * 0.04,
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
                            onPressed: () {},
                            icon: Icon(Icons.remove_red_eye),
                          ),
                        ),
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      FilledButton(
                        onPressed: () {},
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
