import 'package:clearance_system/app/AdminPanel/dashboard.dart';
import 'package:clearance_system/app/ui/pages/register_page/widget/newdasboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui/pages/doctorspage/doctor_dasboard.dart';

class LoginController extends GetxController {
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
    update();
  }

  Color _passborderColor = const Color(0xffeaebed);

  Color get passborderColor => _passborderColor;

  set passborderColor(Color value) {
    _passborderColor = value;
    update();
  }

  Color _textColor = const Color(0xff9ca3af);

  Color get textColor => _textColor;

  set textColor(Color value) {
    _textColor = value;
    update();
  }

  Color _passtextColor = const Color(0xff9ca3af);

  Color get passtextColor => _passtextColor;

  set passtextColor(Color value) {
    _passtextColor = value;
    update();
  }

  String _passerrorMessage = '';

  String get passerrorMessage => _passerrorMessage;

  set passerrorMessage(String value) {
    _passerrorMessage = value;
    update();
  }

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  set errorMessage(String value) {
    _errorMessage = value;
    update();
  }

  bool _obscure = true;
  bool get obscure => _obscure;
  void onChangeObscure() {
    _obscure = !_obscure;
    update();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<String> getUserRole(String userId) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final DocumentSnapshot userSnapshot =
          await firestore.collection('users').doc(userId).get();

      if (userSnapshot.exists) {
        final userData = userSnapshot.data() as Map<String, dynamic>;
        final userRole = userData['role'];
        if (userRole != null) {
          return userRole;
        }
      }

      return 'unknown';
    } catch (e) {
      print("Error retrieving user role from Firestore: $e");

      return 'error';
    }
  }

  login(email, password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Successful'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );

      final userRole = await getUserRole(userCredential.user!.uid);

      if (userRole == 'Admin') {
        Get.to(() => const DashBoard());
      } else if (userRole == 'Nurse') {
        Get.to(() => const UserDashBoard());
      } else if (userRole == 'Doctor') {
        Get.to(() => const DoctorDashBoard());
      } else {
        Get.snackbar("NOT FOUND", "USER CANNOT BE FOUND");
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: ${e.message}'),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
