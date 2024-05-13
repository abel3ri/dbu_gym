import 'package:dbu_gym/utils/clear_form_inputs.dart';
import 'package:dbu_gym/views/widgets/signup_login_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            // clear form inputs when user taps the back btn
            clearFormInputs(context);
            FocusManager.instance.primaryFocus!.unfocus();
            GoRouter.of(context).pushReplacementNamed("welcome");
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
            formType: "Sign up",
          ),
        ),
      ),
    );
  }
}
