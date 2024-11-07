import 'package:busha_app/core/validator.dart';
import 'package:busha_app/gen/assets.gen.dart';
import 'package:busha_app/presentation/home/home_screen.dart';
import 'package:busha_app/presentation/shared/components/app_button.dart';
import 'package:busha_app/presentation/shared/components/custom_text_field.dart';
import 'package:busha_app/presentation/shared/components/text_view.dart';
import 'package:busha_app/presentation/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailAddressTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailAddressTextController.dispose();
    _passwordTextController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colorPrimary,
        leading: Center(child: SvgPicture.asset(Assets.svg.icArrowBack, width: 20, height: 20)),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 16.0, left: 20.0, bottom: 30),
        child: AppButton(
          key: const Key("continueBtn"),
          title: 'Continue',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const HomeScreen()));
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 16.0, left: 20.0, top: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextView(
                text: "Log in to your account",
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 8),
              TextView(
                text: "Welcome back! Please enter your registered email address to continue",
                fontWeight: FontWeight.w400,
                color: Colors.black.withOpacity(0.60),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextField(
                key: const Key("emailTextField"),
                label: "Email Address",
                controller: _emailAddressTextController,
                keyboardType: TextInputType.emailAddress,
                validator: (String? input) => emailTextFieldValidator(input),
              ),
              const SizedBox(
                height: 12,
              ),
              CustomTextField(
                label: "Password",
                key: const Key("passwordTextField"),
                controller: _passwordTextController,
                enabledTextFieldBorder: false,
                hintText: "Enter Password",
                textInputAction: TextInputAction.done,
                isPasswordField: true,
                validator: (String? input) => passwordTextFieldValidator(input, includePasswordRegexValidator: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
