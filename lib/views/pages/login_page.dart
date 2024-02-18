import 'package:dbu_gym/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            FocusManager.instance.primaryFocus!.unfocus();
            GoRouter.of(context).pushReplacementNamed("welcome");
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(
            horizontal: 28,
          ),
          child: FormWidget(
            formType: "Login",
          ),
        ),
      ),
    );
  }
}
