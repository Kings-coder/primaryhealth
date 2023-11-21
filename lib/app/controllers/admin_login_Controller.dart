import 'package:clearance_system/app/AdminPanel/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui/pages/register_page/widget/res.dart';

class AdminLoginController extends GetxController {
  final token = ''.obs;
  bool _isBusy = false;
  bool get isBusy => _isBusy;

  void setBusy(bool value) {
    _isBusy = value;
    update();
  }

  Color _borderColor = const Color(0xffeaebed);

  Color get borderColor => _borderColor;

  set borderColor(Color value) {
    _borderColor = value;
    update(); // Call update to notify the UI that the value has changed
  }

  Color _passborderColor = const Color(0xffeaebed);

  Color get passborderColor => _passborderColor;

  set passborderColor(Color value) {
    _passborderColor = value;
    update(); // Call update to notify the UI that the value has changed
  }

  Color _textColor = const Color(0xff9ca3af);

  Color get textColor => _textColor;

  set textColor(Color value) {
    _textColor = value;
    update(); // Call update to notify the UI that the value has changed
  }

  Color _passtextColor = const Color(0xff9ca3af);

  Color get passtextColor => _passtextColor;

  set passtextColor(Color value) {
    _passtextColor = value;
    update(); // Call update to notify the UI that the value has changed
  }

// Define the errorMessage property
  String _passerrorMessage = '';

  String get passerrorMessage => _passerrorMessage;

  set passerrorMessage(String value) {
    _passerrorMessage = value;
    update(); // Call update to notify the UI that the value has changed
  }

// Define the errorMessage property
  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  set errorMessage(String value) {
    _errorMessage = value;
    update(); // Call update to notify the UI that the value has changed
  }

  bool _obscure = true;
  bool get obscure => _obscure;
  void onChangeObscure() {
    _obscure = !_obscure;
    update();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // void login() async {
  //   // setBusy(true);
  //   signinUser(email: emailController.text, password: passwordController.text);
  //   // setBusy(false);
  // }

  login(email, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Get.to(() => const DashBoard());
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
