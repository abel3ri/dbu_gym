import 'package:dbu_gym/utils/clear_form_inputs.dart';
import 'package:dbu_gym/views/widgets/signup_login_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            FocusManager.instance.primaryFocus!.unfocus();
            GoRouter.of(context).pushReplacementNamed("welcome");
            // clear form inputs when user taps the back btn
            clearFormInputs(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
          style: ButtonStyle(
            overlayColor: MaterialStatePropertyAll(Colors.transparent),
          ),
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
