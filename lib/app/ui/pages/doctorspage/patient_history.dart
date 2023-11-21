import 'package:clearance_system/app/ui/pages/doctorspage/add_prescription.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientHistoryScreen extends StatelessWidget {
  final String patientName;
  const PatientHistoryScreen({
    Key? key,
    required this.patientName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient History: $patientName'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('test_reports')
            .where('patientName', isEqualTo: patientName)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final reports = snapshot.data!.docs;

          if (reports.isEmpty) {
            return const Center(
              child: Text(
                'No test reports available for this patient.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          }

          return ListView.builder(
            itemCount: reports.length,
            itemBuilder: (context, index) {
              final reportData = reports[index].data() as Map<String, dynamic>;
              final testReportId =
                  reports[index].id; // Retrieve the test report ID
              return Card(
                margin: const EdgeInsets.all(8),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(
                    'Date: ${reportData['date']}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTileInfo('Weight', reportData['weight']),
                      ListTileInfo('Height', reportData['height']),
                      ListTileInfo('Temperature', reportData['temperature']),
                      ListTileInfo('Pulse Rate', reportData['pulseRate']),
                      ListTileInfo('Sugar Level', reportData['sugarLevel']),
                      ListTileInfo('Gravida', reportData['gravida']),
                      ListTileInfo('Blood Group', reportData['bloodGroup']),
                      ListTileInfo(
                          'Body Surface Area', reportData['bodySurfaceArea']),
                      ListTileInfo(
                          'Respiration Rate', reportData['respirationRate']),
                      ListTileInfo('RH', reportData['RH']),
                      ListTileInfo('EDD', reportData['EDD']),
                      // Add more fields as needed
                      ElevatedButton(
                        onPressed: () {
                          Get.to(() => AddPrescriptionScreen(
                              patientName: patientName,
                              testReportId:
                                  testReportId)); // Pass the testReportId
                        },
                        child: Text('prescription for patient $patientName'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ListTileInfo extends StatelessWidget {
  final String label;
  final dynamic value;

  const ListTileInfo(this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            '$value',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
