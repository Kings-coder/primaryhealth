import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Controller Page'),
        backgroundColor: const Color(0xFF21222D),
      ),
      body: const Center(
        child: Text("Payment Page"),
      ),
    );
  }
}
