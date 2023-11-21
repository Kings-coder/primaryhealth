import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PaymentHistoryTable extends StatelessWidget {
  const PaymentHistoryTable({super.key});

  Future<void> generateReceipt(
      BuildContext context, Map<String, dynamic> paymentData) async {
    // Create a formatted receipt message
    String receipt = '''
    Payment Receipt
    Date: ${paymentData['timestamp'].toDate()}
    Amount: ₦${paymentData['amount']}
    Level: ${paymentData['level']}
    Payment Option: ${paymentData['payment_option']}
    ''';

    // Show the receipt in a dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Receipt'),
          content: Text(receipt),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: 30,
                width: 100,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: const Color(0xFF21222D),
                    borderRadius: BorderRadius.circular(8)),
                child: const Text(
                  'Print Receipt',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser == null) {
      // User is not authenticated, handle this as needed
      return const Center(
        child: Text('User is not authenticated.'),
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('payments')
          .where('user_email',
              isEqualTo: auth.currentUser!.email) // Filter by user email
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final payments = snapshot.data!.docs;

        if (payments.isEmpty) {
          return const Center(
            child: Text('No payment history available for this user.'),
          );
        }

        return DataTable(
          headingRowColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return const Color(0xFF21222D); // Color when header is hovered
              }
              return const Color(0xFF21222D); // Default header color
            },
          ),
          columns: const [
            DataColumn(
              label: Text(
                'Payment Date',
                style: TextStyle(color: Colors.white), // Header text color
              ),
            ),
            DataColumn(
              label: Text(
                'Amount',
                style: TextStyle(color: Colors.white), // Header text color
              ),
            ),
            DataColumn(
              label: Text(
                'Level',
                style: TextStyle(color: Colors.white), // Header text color
              ),
            ),
            DataColumn(
              label: Text(
                'Payment Option',
                style: TextStyle(color: Colors.white), // Header text color
              ),
            ),
            DataColumn(
              label: Text(
                'Printing',
                style: TextStyle(color: Colors.white), // Header text color
              ),
            ),
          ],
          rows: payments.asMap().entries.map((entry) {
            final index = entry.key;
            final payment = entry.value;

            final paymentData = payment.data() as Map<String, dynamic>;

            final paymentDate =
                (paymentData['timestamp'] as Timestamp).toDate();
            final paymentAmount = paymentData['amount'] as int;
            final leveltOption = paymentData['level'] as String;
            final paymentOption = paymentData['payment_option'] as String;

            // Determine the row color based on the index
            final rowColor = index % 2 == 0 ? Colors.grey : Colors.white;
            final textColor = index % 2 == 0 ? Colors.white : Colors.grey;
            return DataRow(
              color: MaterialStateProperty.all<Color>(rowColor),
              cells: [
                DataCell(
                  Text(paymentDate.toString(),
                      style: TextStyle(color: textColor)),
                  onTap: () {
                    generateReceipt(context, paymentData);
                  },
                ),
                DataCell(
                  Text('₦$paymentAmount', style: TextStyle(color: textColor)),
                ),
                DataCell(
                  Text(leveltOption, style: TextStyle(color: textColor)),
                ),
                DataCell(
                  Text(paymentOption, style: TextStyle(color: textColor)),
                ),
                DataCell(
                  Container(
                      height: 30,
                      width: 100,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text("Print Receipt",
                          style: TextStyle(color: textColor))),
                  onTap: () {
                    generateReceipt(context, paymentData);
                  },
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}
