import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../widgets/custom_card.dart';

class ActivityDetailsCard extends StatelessWidget {
  const ActivityDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('payments')
                .where('payment_option',
                    isEqualTo: 'SUG Dues') // Filter by payment_option
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }

              final payments = snapshot.data!.docs;
              final numberOfPayments = payments.length;
              return CustomCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SvgPicture.asset(healthDetails[i].icon),
                    const Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 4),
                      child: Text(
                        "PATIENTS",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(
                      "$numberOfPayments",
                      style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              );
            }),
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('payments')
                .where('payment_option',
                    isEqualTo: 'NURSS Dues') // Filter by payment_option
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }

              final payments = snapshot.data!.docs;
              final numberOfPayments = payments.length;
              return CustomCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SvgPicture.asset(healthDetails[i].icon),
                    const Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 4),
                      child: Text(
                        "DOCTOR",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(
                      "$numberOfPayments",
                      style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              );
            }),
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('payments')
                .where('payment_option',
                    isEqualTo: 'NIDSUG Dues') // Filter by payment_option
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }

              final payments = snapshot.data!.docs;
              final numberOfPayments = payments.length;
              return CustomCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SvgPicture.asset(healthDetails[i].icon),
                    const Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 4),
                      child: Text(
                        "NURSE",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(
                      "$numberOfPayments",
                      style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              );
            }),
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }

              final payments = snapshot.data!.docs;
              final numberOfPayments = payments.length;
              return CustomCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SvgPicture.asset(healthDetails[i].icon),
                    const Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 4),
                      child: Text(
                        "ADMIN",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(
                      "$numberOfPayments",
                      style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              );
            }),
      ],
    );
  }
}
