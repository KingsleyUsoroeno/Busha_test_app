import 'package:flutter/material.dart';

String? emailTextFieldValidator(String? email) {
  if (email == null || email.isEmpty) return "Email cannot be empty";
  if (!isValidEmail(email)) return "Please enter a valid email";
  return null;
}

String? passwordTextFieldValidator(String? password, {bool includePasswordRegexValidator = false}) {
  if (password == null || password.isEmpty) return "password cannot be empty";
  if (!isValidPasswordPattern(password) && includePasswordRegexValidator) {
    return "Your password should have at least one upper case, number and special characters";
  }
  return null;
}

bool isValidPassword(String? password) {
  return password != null && password.isNotEmpty && password.length >= 8 && isValidPasswordPattern(password);
}

bool isValidEmail(String? email) {
  return email != null && email.isNotEmpty && isValidEmailPattern(email);
}

bool isValidPasswordPattern(String password) {
  return RegExp(r'^(?=.*[A-Z])(?=.*[\W_])(?=.{8,})').hasMatch(password);
}

bool isValidEmailPattern(String email) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  return RegExp(pattern.toString()).hasMatch(email);
}
