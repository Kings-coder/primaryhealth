import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminPaymentHistoryTable extends StatelessWidget {
  const AdminPaymentHistoryTable({Key? key}) : super(key: key);

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
          .where('payment_option', isEqualTo: "SUG Dues")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No patient history available.'),
          );
        }

        final payments = snapshot.data!.docs;

        if (payments.isEmpty) {
          return const Center(
            child: Text('No patient history available.'),
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
            final rowColor = index.isEven ? Colors.grey : Colors.white;
            final textColor = index.isEven ? Colors.white : Colors.grey;
            return DataRow(
              color: MaterialStateProperty.all<Color>(rowColor),
              cells: [
                DataCell(
                  Text(paymentDate.toString(),
                      style: TextStyle(color: textColor)),
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
              ],
            );
          }).toList(),
        );
      },
    );
  }
}

class AdminPaymentHistoryTable1 extends StatelessWidget {
  const AdminPaymentHistoryTable1({Key? key}) : super(key: key);

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
          .where('payment_option', isEqualTo: "NURSS Dues")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No patient history available.'),
          );
        }

        final payments = snapshot.data!.docs;

        if (payments.isEmpty) {
          return const Center(
            child: Text('No patient history available.'),
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
            final rowColor = index.isEven ? Colors.grey : Colors.white;
            final textColor = index.isEven ? Colors.white : Colors.grey;
            return DataRow(
              color: MaterialStateProperty.all<Color>(rowColor),
              cells: [
                DataCell(
                  Text(paymentDate.toString(),
                      style: TextStyle(color: textColor)),
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
              ],
            );
          }).toList(),
        );
      },
    );
  }
}

class AdminPaymentHistoryTable2 extends StatelessWidget {
  const AdminPaymentHistoryTable2({Key? key}) : super(key: key);

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
          .where('payment_option', isEqualTo: "NIDSUG Dues")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No patient history available.'),
          );
        }

        final payments = snapshot.data!.docs;

        if (payments.isEmpty) {
          return const Center(
            child: Text('No patient history available.'),
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
            final rowColor = index.isEven ? Colors.grey : Colors.white;
            final textColor = index.isEven ? Colors.white : Colors.grey;
            return DataRow(
              color: MaterialStateProperty.all<Color>(rowColor),
              cells: [
                DataCell(
                  Text(paymentDate.toString(),
                      style: TextStyle(color: textColor)),
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
              ],
            );
          }).toList(),
        );
      },
    );
  }
}

class AdminStudentHistoryTable1 extends StatelessWidget {
  const AdminStudentHistoryTable1({Key? key}) : super(key: key);

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
          .collection('users')
          //.where('payment_option', isEqualTo: "SUG Dues")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No User history available.'),
          );
        }

        final payments = snapshot.data!.docs;

        if (payments.isEmpty) {
          return const Center(
            child: Text('No User history available.'),
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
                'NAME',
                style: TextStyle(color: Colors.white), // Header text color
              ),
            ),
            DataColumn(
              label: Text(
                'MAT NUMBER',
                style: TextStyle(color: Colors.white), // Header text color
              ),
            ),
            DataColumn(
              label: Text(
                'PHONE NUMBER',
                style: TextStyle(color: Colors.white), // Header text color
              ),
            ),
            DataColumn(
              label: Text(
                'DEPARTMENT',
                style: TextStyle(color: Colors.white), // Header text color
              ),
            ),
          ],
          rows: payments.asMap().entries.map((entry) {
            final index = entry.key;
            final payment = entry.value;

            final paymentData = payment.data() as Map<String, dynamic>;
            final paymentDate = paymentData['name'] as String;
            final paymentAmount = paymentData['matNo'] as String;
            final leveltOption = paymentData['phoneNo'] as String;
            final paymentOption = paymentData['department'] as String;

            // Determine the row color based on the index
            final rowColor = index.isEven ? Colors.grey : Colors.white;
            final textColor = index.isEven ? Colors.white : Colors.grey;
            return DataRow(
              color: MaterialStateProperty.all<Color>(rowColor),
              cells: [
                DataCell(
                  Text(paymentDate.toString(),
                      style: TextStyle(color: textColor)),
                ),
                DataCell(
                  Text(paymentAmount, style: TextStyle(color: textColor)),
                ),
                DataCell(
                  Text(leveltOption, style: TextStyle(color: textColor)),
                ),
                DataCell(
                  Text(paymentOption, style: TextStyle(color: textColor)),
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}
