import 'package:clearance_system/app/ui/pages/login_page/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientRegisterController extends GetxController {
  String? selectedState;

  final List<String> states = [
    'Abia State',
    'Adamawa State',
    'Akwa Ibom State',
    'Anambra State',
    'Bauchi State',
    'Bayelsa State',
    'Benue State',
    'Borno State',
    'Cross River State',
    'Delta State',
    'Ebonyi State',
    'Edo State',
    'Ekiti State',
    'Enugu State',
    'Gombe State',
    'Imo State',
    'Jigawa State',
    'Kaduna State',
    'Kano State',
    'Katsina State',
    'Kebbi State',
    'Kogi State',
    'Kwara State',
    'Lagos State',
    'Nasarawa State',
    'Niger State',
    'Ogun State',
    'Ondo State',
    'Osun State',
    'Oyo State',
    'Plateau State',
    'Rivers State',
    'Sokoto State',
    'Taraba State',
    'Yobe State',
    'Zamfara State',
  ];

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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController matNoController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController facultyController = TextEditingController();
  TextEditingController levelController = TextEditingController();
  TextEditingController sessionController = TextEditingController();

  TextEditingController lgaController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> registerUser(
      String name,
      String matNo,
      String department,
      String faculty,
      String level,
      String session,
      String stateOfOrigin,
      String lga,
      String phoneNo,
      String email,
      String username,
      String password,
      BuildContext context) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Create a user profile in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': nameController.text,
        'matNo': matNoController.text,
        'department': departmentController.text,
        'faculty': facultyController.text,
        'level': levelController.text,
        'session': sessionController.text,
        'stateOfOrigin': selectedState,
        'lga': lgaController.text,
        'phoneNo': phoneController.text,
        'email': emailController.text,
        'username': usernameController.text,
        'verificationStatus': 'Pending',
      });

      // Navigate to the home screen after successful registration
      Get.offAll(() => const LoginPage());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: $e'),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red, // Customize the background color
        ),
      );

      print(e.toString());
    }
  }
}
