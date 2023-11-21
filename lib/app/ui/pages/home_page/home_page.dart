import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final User? user = auth.currentUser;

    if (user == null) {
      // User is not authenticated, handle this as needed
      return const Center(
        child: Text('User is not authenticated.'),
      );
    }
    return Container(
      color: Colors.grey.withOpacity(0.2),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/teacher040517.jpg",
              height: 250,
              filterQuality: FilterQuality.high,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('payments')
                        .where('user_email',
                            isEqualTo: user.email) // Filter by user email
                        .where('payment_option',
                            isEqualTo: 'SUG Dues') // Filter by payment_option
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }

                      final payments = snapshot.data!.docs;
                      final numberOfPayments = payments.length;

                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shadowColor: Colors.blue[900],
                        elevation: 12,
                        color: Colors.blue, // Change the card background color
                        child: SizedBox(
                          height: 180,
                          width: 300,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.payment, // Add a payment icon
                                  size: 40,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Patient',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '$numberOfPayments',
                                  style: const TextStyle(
                                    fontSize: 36,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Center(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('payments')
                        .where('user_email',
                            isEqualTo: user.email) // Filter by user email
                        .where('payment_option',
                            isEqualTo:
                                'NIDSUG Dues') // Filter by payment_option
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }

                      final payments = snapshot.data!.docs;
                      final numberOfPayments = payments.length;

                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shadowColor: Colors.blue[900],
                        elevation: 12,
                        color: Colors.blue, // Change the card background color
                        child: SizedBox(
                          height: 180,
                          width: 300,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.payment, // Add a payment icon
                                  size: 40,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'PATIENT ASSIGN TO ME',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '$numberOfPayments',
                                  style: const TextStyle(
                                    fontSize: 36,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Center(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('payments')
                        .where('user_email',
                            isEqualTo: user.email) // Filter by user email
                        .where('payment_option',
                            isEqualTo: 'NURSS Dues') // Filter by payment_option
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }

                      final payments = snapshot.data!.docs;
                      final numberOfPayments = payments.length;

                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shadowColor: Colors.blue[900],
                        elevation: 12,
                        color: Colors.blue, // Change the card background color
                        child: SizedBox(
                          height: 180,
                          width: 300,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.payment, // Add a payment icon
                                  size: 40,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'ON TREATMENT',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '$numberOfPayments',
                                  style: const TextStyle(
                                    fontSize: 36,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     InkWell(
            //       onTap: () {
            //         //Show the CheckoutPage in a dialog
            //         showDialog(
            //           context: context,
            //           builder: (BuildContext context) {
            //             return Dialog(
            //               shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(16),
            //               ),
            //               elevation: 0,
            //               backgroundColor: Colors.transparent,
            //               child: Container(
            //                 padding: const EdgeInsets.all(16),
            //                 width: 500, // Adjust the width as needed
            //                 child: const CheckoutPage(),
            //               ),
            //             );
            //           },
            //         );
            //       },
            //       child: Card(
            //         elevation: 8,
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //         color: Colors.green,
            //         child: const SizedBox(
            //           height: 50,
            //           width: 200,
            //           child: Center(
            //             child: Text(
            //               "Make Payment",
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontWeight: FontWeight.w600,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //     InkWell(
            //       onTap: () {
            //         Get.to(() => const PaymentHistoryTable());
            //       },
            //       child: Card(
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //         elevation: 8,
            //         color: Colors.orange,
            //         child: const SizedBox(
            //           height: 50,
            //           width: 200,
            //           child: Center(
            //             child: Text(
            //               "Clearance Details",
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontWeight: FontWeight.w600,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //     Card(
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //       elevation: 8,
            //       color: Colors.brown,
            //       child: const SizedBox(
            //         height: 50,
            //         width: 200,
            //         child: Center(
            //           child: Text(
            //             "Print Clearance",
            //             style: TextStyle(
            //               color: Colors.white,
            //               fontWeight: FontWeight.w600,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(
              height: 16,
            ),
            // const OurSchool()
          ],
        ),
      ),
    );
  }
}
