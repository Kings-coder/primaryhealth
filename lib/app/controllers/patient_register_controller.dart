import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientController extends GetxController {

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
  TextEditingController patientIdController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController lgaController = TextEditingController();
  TextEditingController homeTownController = TextEditingController();
  TextEditingController maritalStatusController = TextEditingController();
  TextEditingController parentFullNameController = TextEditingController();
  TextEditingController relationshipToChildController = TextEditingController();
  TextEditingController parentPhoneNumberController = TextEditingController();
  TextEditingController currentAdddresscontroller = TextEditingController();

  Future<void> saveDataToFirestore(BuildContext context) async {
    try {
      // Access the Firestore instance
      final firestore = FirebaseFirestore.instance;

      // Create a map of the data to be stored
      Map<String, dynamic> data = {
        'patientId': patientIdController.text,
        'fullName': fullNameController.text,
        'age': ageController.text,
        'phoneNo': phoneNoController.text,
        'gender': genderController.text,
        'state': stateController.text,
        'lga': lgaController.text,
        'homeTown': homeTownController.text,
        'maritalStatus': maritalStatusController.text,
        'parentFullName': parentFullNameController.text,
        'relationshipToChild': relationshipToChildController.text,
        'parentPhoneNumber': parentPhoneNumberController.text,
        "currentAddress": currentAdddresscontroller.text
      };

      // Add the data to a Firestore collection
      await firestore.collection('patients').add(data);

      // Data has been successfully stored in Firestore.
      // You can add further handling here, e.g., navigation or showing a success message.
ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Data saved successfully'),
        duration: Duration(seconds: 2), // Adjust the duration as needed.
      ));

      // Clear the text controllers after successful data submission
      patientIdController.clear();
      fullNameController.clear();
      ageController.clear();
      phoneNoController.clear();
      genderController.clear();
      stateController.clear();
      lgaController.clear();
      homeTownController.clear();
      maritalStatusController.clear();
      parentFullNameController.clear();
      relationshipToChildController.clear();
      parentPhoneNumberController.clear();
      currentAdddresscontroller.clear();
    } catch (e) {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Data save failed: $e'),
        duration: Duration(seconds: 2), // Adjust the duration as needed.
      ));
      // Handle errors here, e.g., display an error message.
      print("Error: $e");
    }
  }
}
