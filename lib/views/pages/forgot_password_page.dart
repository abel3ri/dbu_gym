import 'package:dbu_gym/controllers/form_input_validator.dart';
import 'package:dbu_gym/models/success.dart';
import 'package:dbu_gym/utils/constants.dart';
import 'package:dbu_gym/views/widgets/input_fields/signup_login_form_input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          style: ButtonStyle(
            overlayColor: MaterialStatePropertyAll(
              Colors.transparent,
            ),
          ),
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            // color: Colors.grey.shade200,
          ),
        ),
        title: Text("Reset password"),
        titleTextStyle: Theme.of(context).textTheme.titleMedium,
        centerTitle: true,
        actions: [
          Tooltip(
            message:
                "Please check your spam folder if you can't find the password reset link in your inbox list.",
            child: Icon(Icons.help),
            triggerMode: TooltipTriggerMode.tap,
            showDuration: Duration(seconds: 3),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "You will recieve a password reset link for the provided E-mail address.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                FormInputField(
                  hintText: "e.g. abebe@example.com",
                  controller: _emailController,
                  labelText: "E-mail",
                  prefixIcon: Icon(Icons.email),
                  validator: emailValidator,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ElevatedButton.icon(
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    if (_formKey.currentState!.validate()) {
                      await auth.sendPasswordResetEmail(
                        email: _emailController.text,
                      );
                      setState(() {
                        _isLoading = false;
                      });
                      GoRouter.of(context).pop();
                      SuccessMessage(
                        successTitle: "Success",
                        successBody: "Please check your email address.",
                      ).showSuccess(context);
                    }
                  },
                  icon: Icon(Icons.send),
                  label: _isLoading
                      ? Container(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(),
                        )
                      : Text("Reset password"),
                )
              ],
            )),
      ),
    );
  }
}
