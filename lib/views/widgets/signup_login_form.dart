// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:dbu_gym/controllers/form_input_validator.dart';
import 'package:dbu_gym/controllers/user_controller.dart';
import 'package:dbu_gym/models/error.dart';
import 'package:dbu_gym/models/gym_user.dart';
import 'package:dbu_gym/providers/form_provider.dart';
import 'package:dbu_gym/providers/image_provider.dart';
import 'package:dbu_gym/utils/clear_form_inputs.dart';
import 'package:dbu_gym/views/pages/image_pick_selector.dart';
import 'package:dbu_gym/views/widgets/date_picker_input.dart';
import 'package:dbu_gym/views/widgets/signup_form_drop_down_btn.dart';
import 'package:dbu_gym/views/widgets/signup_login_form_input.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FormWidget extends StatefulWidget {
  String formType;

  FormWidget({
    required this.formType,
  });

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);
    final imageProvider = Provider.of<AppImageProvider>(context);
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        top: widget.formType == "Login"
            ? MediaQuery.of(context).size.height * 0.1
            : MediaQuery.of(context).size.height * 0.05,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.formType == "Login"
                ? "Welcome back!"
                : "It won't take long!",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Text(
            widget.formType == "Login" ? "Login" : "Sign up",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          if (widget.formType == "Sign up")
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
                  onTap: () {
                    formProvider.setSelectedImagePicker("profilePicture");
                    showModalBottomSheet(
                      showDragHandle: true,
                      constraints: BoxConstraints.tight(Size(
                          MediaQuery.of(context).size.width,
                          MediaQuery.of(context).size.height * 0.3)),
                      context: context,
                      builder: (context) => ImagePickSelector(),
                    );
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
            key: widget.formType == "Login"
                ? formProvider.loginFormKey
                : formProvider.signUpFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.formType == "Sign up") ...[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Row(
                    children: [
                      Flexible(
                        child: FormInputField(
                          hintText: "e.g. Abebe",
                          labelText: "First name",
                          prefixIcon: Icon(Icons.person),
                          controller: _firstNameController,
                          validator: nameValidator,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Flexible(
                        child: FormInputField(
                          hintText: "e.g. Bekele",
                          labelText: "Last name",
                          prefixIcon: Icon(Icons.person),
                          controller: _lastNameController,
                          validator: nameValidator,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ],
                FormInputField(
                  hintText: "e.g. abebe@example.com",
                  controller: _emailController,
                  labelText: "E-mail",
                  prefixIcon: Icon(Icons.email),
                  validator: emailValidator,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                FormInputField(
                  controller: _passwordController,
                  labelText: "Password",
                  prefixIcon: Icon(Icons.password),
                  showPassword: formProvider.showPassword,
                  formType: widget.formType,
                  validator: passwordValidator,
                ),
                if (formProvider.hasPassRepassInputError) ...[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                    child: Align(
                      alignment: Alignment.centerLeft.add(Alignment(0.15, 0)),
                      child: Text(
                        "Password do not match.",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).colorScheme.error,
                            ),
                      ),
                    ),
                  ),
                ],
                if (widget.formType == "Sign up") ...[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  FormInputField(
                    controller: _rePasswordController,
                    labelText: "Re-enter password",
                    prefixIcon: Icon(Icons.password),
                    showPassword: formProvider.showPassword,
                    formType: widget.formType,
                    validator: passwordValidator,
                  ),
                  if (formProvider.hasPassRepassInputError) ...[
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                      child: Align(
                        alignment: Alignment.centerLeft.add(Alignment(0.15, 0)),
                        child: Text(
                          "Password do not match.",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  FormInputField(
                    hintText: "e.g. 0909090909",
                    controller: _phoneNumberController,
                    labelText: "Phone number",
                    prefixIcon: Icon(Icons.phone),
                    showPassword: formProvider.showPassword,
                    formType: widget.formType,
                    validator: phoneNumberValidator,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Stack(
                    alignment: Alignment(-0.8, 1),
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: DatePickerInputField(
                              controller: _startDateController,
                              labelText: "Gym Start Date",
                              helpText: "Start date of your gym plan",
                              validator: (value) {
                                return dateInputValidator(
                                  value,
                                  "Gym Start Date",
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                          ),
                          Flexible(
                            child: DatePickerInputField(
                              controller: _endDateController,
                              labelText: "Gym End Date",
                              helpText: "End date of your gym plan",
                              validator: (value) {
                                return dateInputValidator(
                                  value,
                                  "Gym End Date",
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      if (formProvider.hasDateInputError) ...[
                        Text(
                          formProvider.dateInputErrorStr!,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                        ),
                      ]
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Container(
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.primary.withAlpha(20),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "I'm an",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),
                        RadioMenuButton(
                          value: "insider",
                          groupValue: formProvider.affiliationStatus,
                          onChanged: (value) {
                            formProvider.setAffiliationStatus(value!);
                          },
                          child: Text("Insider"),
                        ),
                        RadioMenuButton(
                          value: "outsider",
                          groupValue: formProvider.affiliationStatus,
                          onChanged: (value) {
                            formProvider.setAffiliationStatus(value!);
                          },
                          child: Text("Outsider"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  if (formProvider.affiliationStatus == 'insider') ...[
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          formProvider.setSelectedImagePicker("idPicture");
                          showModalBottomSheet(
                            showDragHandle: true,
                            constraints: BoxConstraints.tight(Size(
                                MediaQuery.of(context).size.width,
                                MediaQuery.of(context).size.height * 0.3)),
                            context: context,
                            builder: (context) => ImagePickSelector(),
                          );
                        },
                        child: Text("Select ID Picture"),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    if (imageProvider.idImagePath != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(File(imageProvider.idImagePath!)),
                      ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ],
                  DropdownButtonFormField(
                    value: "default",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.grey,
                        ),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1,
                        ),
                      ),
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
                if (formProvider.selectedWorkoutDays != "default" &&
                    widget.formType == 'Sign up') ...[
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

                    if (widget.formType == "Login") {
                      // valid login inputs
                      if (formProvider.loginFormKey.currentState!.validate()) {
                        formProvider.setIsAuthtentcating(true);
                        Either<CustomError, String> authRes =
                            await loginController(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );

                        authRes.fold((err) {
                          err.showError(context);
                          formProvider.setIsAuthtentcating(false);
                        }, (r) {
                          GoRouter.of(context).pushReplacementNamed("splash");
                          // clear all form inputs after submitting the form
                          formProvider.setIsAuthtentcating(false);
                          clearFormInputs(context);
                        });
                        // clear form input only when user is redirected to splash page
                      }
                    } else {
                      /// check if password and re enter password input have the same
                      /// value
                      passRepassValidator(
                        passController: _passwordController,
                        rePassController: _rePasswordController,
                        context: context,
                      );

                      if (_startDateController.text.isNotEmpty &&
                          _endDateController.text.isNotEmpty)
                        dateValidator(
                          startDate: _startDateController.text,
                          endDate: _endDateController.text,
                          context: context,
                        );

                      if (imageProvider.imagePath == null) {
                        // if the form is sign up form and user didn't provide profile image, show an error snackbar
                        CustomError error = CustomError(
                          errorTitle: "Error",
                          errorBody: "Please provide a profile picture",
                        );
                        error.showError(context);
                      }
                      // valid sign up inputs
                      if (formProvider.signUpFormKey.currentState!.validate() &&
                          !formProvider.hasPassRepassInputError &&
                          !formProvider.hasDateInputError &&
                          imageProvider.imagePath != null) {
                        formProvider.setIsAuthtentcating(true);
                        // set image profile field from image provider

                        // catch is there is storage uploading error
                        Either<CustomError, String> storageRes =
                            await formProvider.setProfileImageUrl(
                          imageProvider.imagePath!,
                          imageProvider.imageName!,
                        );
                        // show error if setProfileImageUrl returns an error
                        storageRes.fold((err) {
                          err.showError(context);
                        }, (r) => null);

                        GymUser user = GymUser(
                          firstName: _firstNameController.text,
                          lastName: _lastNameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          gymStartDate: _startDateController.text,
                          gymEndDate: _endDateController.text,
                          numWorkoutDays: formProvider.selectedWorkoutDays,
                          subscribedWorkoutType:
                              formProvider.preferedWorkoutType,
                          profileImageUrl: formProvider.profileImageUrl,
                          phoneNumber: _phoneNumberController.text,
                          createdAt: DateTime.now(),
                          paymentHistory: [],
                        );
                        Either<CustomError, String> authRes =
                            await signUpController(
                          user: user,
                        );
                        authRes.fold((err) {
                          err.showError(context);
                          formProvider.setIsAuthtentcating(false);
                        }, (r) {
                          GoRouter.of(context)
                              .pushReplacementNamed("payment-upload");
                          formProvider.setIsAuthtentcating(false);
                          // clear form inputs only if user is redirected to spalsh page
                          clearFormInputs(context);
                        });
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
                      : Text(widget.formType == "Login" ? "Login" : "Sign up"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.formType == "Login"
                        ? "Don't have an account?"
                        : "Already have an account?"),
                    TextButton(
                      onPressed: () {
                        widget.formType == "Login"
                            ? GoRouter.of(context)
                                .pushReplacementNamed("signup")
                            : GoRouter.of(context)
                                .pushReplacementNamed("login");
                      },
                      child: Text(
                          widget.formType == "Login" ? "Sign up" : "Login"),
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
