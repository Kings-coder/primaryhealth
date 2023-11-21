import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_paystack_client/flutter_paystack_client.dart';

import 'payment_success.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final List<String> _paymentOptions = ['SUG Dues', "NURSS Dues"];

  String _selectedPaymentOption = 'SUG Dues';
  String userState = 'Rivers State'; // Replace with the actual user's state

  final List<String> _levelOptions = [
    'ND1',
    'ND2',
    'HND1',
    "HND2",
  ];
  String _levelPaymentOption = 'ND1';

  TextEditingController amountController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String publicKey = 'pk_test_63cf86f6c99897f69f560f5b4fdf85e1ca122314';
  //final plugin = PaystackClient();
  String successMessage = '';

  @override
  void initState() {
    super.initState();
    PaystackClient.initialize(publicKey);
    fetchUserState();
  }

  // Function to fetch the user's state from Firestore
  void fetchUserState() async {
    String? state = await getUserState();
    if (state != null) {
      setState(() {
        userState = state;
        updatePaymentOptions();
      });
    }
  }

  void updatePaymentOptions() {
    if (userState == 'Bayelsa State' ||
        userState == 'Delta State' ||
        userState == 'Akwa Ibom State' ||
        userState == 'Edo State' ||
        userState == 'Cross River State' ||
        userState == 'Abia State' ||
        userState == 'Imo State' ||
        userState == 'Ondo State') {
      if (!_paymentOptions.contains('NIDSUG Dues')) {
        _paymentOptions.add('NIDSUG Dues');
        _paymentOptions.remove('NURSS Dues');
      }
    } else if (userState == 'Rivers State') {
      if (!_paymentOptions.contains('NURSS Dues')) {
        _paymentOptions.add('NURSS Dues');
      } else if (!_paymentOptions.contains('NIDSUG Dues')) {
        _paymentOptions.add('NIDSUG Dues');
      }
    } else {
      _paymentOptions.remove('NIDSUG Dues');
      _paymentOptions.remove('NURSS Dues');
    }
  }

  // Function to fetch user's state from Firestore
  Future<String?> getUserState() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        final userState = userData['stateOfOrigin'];
        return userState as String?;
      }
    }
    return null;
  }

  checkout() async {
    try {
      final User? user = _firebaseAuth.currentUser;

      if (user != null) {
        int price = int.parse(amountController.text) * 100;
        final String userEmail = user.email ?? '';
        Charge charge = Charge()
          ..amount = price
          ..reference = 'ref_${DateTime.now().millisecondsSinceEpoch}'
          ..email = userEmail
          ..currency = "NGN";
        CheckoutResponse response = await PaystackClient.checkout(
          context,
          //method: CheckoutMethod.card,
          charge: charge,
        );
        print(response);
        if (response.status == true) {
          print(response);
          successMessage = 'Payment was successful. Ref: ${response.reference}';
          _storePaymentDetails(response.reference!, successMessage, userEmail);
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) =>
          //             PaymentSuccess(successMessage: successMessage)),
          //     ModalRoute.withName('/'));
        } else {
          print(response.message);
        }
      } else {}
    } catch (e) {
      print("Error: $e");
    }
  }
  //////// --> to here

  Future<void> _storePaymentDetails(
      String paymentReference, String sucess, String userMail) async {
    try {
      // Initialize Firebase Firestore
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Create a new document with a unique ID
      DocumentReference paymentRef = firestore.collection('payments').doc();

      // Define payment data
      Map<String, dynamic> paymentData = {
        "user_email": userMail,
        'user_name': nameController.text,
        'payment_option': _selectedPaymentOption,
        'amount': int.parse(amountController.text),
        "level": _levelPaymentOption,
        'reference': paymentReference,
        'timestamp': FieldValue.serverTimestamp(),
      };

      // Store payment data in Firestore
      await paymentRef.set(paymentData);
      Navigator.of(context, rootNavigator: true).pop();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                  padding: const EdgeInsets.all(16),
                  width: 500, // Adjust the width as needed
                  child: PaymentSuccess(successMessage: sucess)),
            );
          });
      // Print success message (you can handle this as needed)
      print('Payment details stored in Firestore');
    } catch (e) {
      // Handle Firestore storage error
      print('Error storing payment details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(centerTitle: true, title: const Text('Checkout Page')),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: amountController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter amount';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              prefix: Text('₦',
                                  style: TextStyle(color: Colors.black)),
                              hintText: '2000',
                              labelText: 'Amount',
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(height: 30),
                        DropdownButtonFormField<String>(
                          value: _selectedPaymentOption,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _selectedPaymentOption = newValue;
                              });
                            }
                          },
                          items: _paymentOptions.map((String option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
                            );
                          }).toList(),
                          decoration: const InputDecoration(
                            labelText: 'Payment Option',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 30),
                        DropdownButtonFormField<String>(
                          value: _levelPaymentOption,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _levelPaymentOption = newValue;
                              });
                            }
                          },
                          items: _levelOptions.map((String option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
                            );
                          }).toList(),
                          decoration: const InputDecoration(
                            labelText: 'Payment Option',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.emailAddress,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter full name';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                hintText: 'kadum priye',
                                labelText: 'Full Name',
                                border: OutlineInputBorder())),
                        const SizedBox(height: 50),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  checkout();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors
                                    .white, //change background color of button
                                backgroundColor:
                                    Colors.teal, //change text color of button
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                elevation: 5.0,
                              ),
                              child: const Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text('Proceed to Pay',
                                      style: TextStyle(fontSize: 20))),
                            )),
                      ],
                    )))));
  }
}
