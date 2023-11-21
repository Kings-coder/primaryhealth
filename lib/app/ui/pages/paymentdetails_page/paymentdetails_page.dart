// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/paymentdetails_controller.dart';
import 'widgets/payment_request.dart';

class PaymentdetailsPage extends StatefulWidget {
  final String reference;
  const PaymentdetailsPage({
    Key? key,
    required this.reference,
  }) : super(key: key);
  @override
  State<PaymentdetailsPage> createState() => _PaymentdetailsPageState();
}

class _PaymentdetailsPageState extends State<PaymentdetailsPage> {
  Map<String, dynamic>? paymentDetails;

  @override
  void initState() {
    super.initState();
    fetchPaymentDetails(widget.reference).then((details) {
      setState(() {
        paymentDetails = details;
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Details'),
      ),
      body: paymentDetails == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Reference: ${paymentDetails!['reference']}'),
                  Text('Amount: ${paymentDetails!['amount']}'),
                  Text('Currency: ${paymentDetails!['currency']}'),
                  // Add more payment details as needed
                ],
              ),
            ),
    );
  }
}
