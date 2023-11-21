import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PatientTestReportsPage extends StatelessWidget {
  final CollectionReference testReports =
      FirebaseFirestore.instance.collection('test_reports');

  PatientTestReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Test Reports'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: testReports.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          final reports = snapshot.data!.docs;

          return Scrollbar(
            trackVisibility: true,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Patient Name')),
                  DataColumn(label: Text('Weight')),
                  DataColumn(label: Text('Height')),
                  DataColumn(label: Text('Temperature')),
                  DataColumn(label: Text('Pulse Rate')),
                  DataColumn(label: Text('Sugar Level')),
                  DataColumn(label: Text('Gravida')),
                  DataColumn(label: Text('Blood Group')),
                  DataColumn(label: Text('Body Surface Area')),
                  DataColumn(label: Text('Respiration Rate')),
                  DataColumn(label: Text('RH')),
                  DataColumn(label: Text('EDD')),
                ],
                rows: reports.map((report) {
                  final data = report.data() as Map<String, dynamic>;
                  return DataRow(
                    cells: [
                      DataCell(Text(data['patientName'])),
                      DataCell(Text(data['weight'])),
                      DataCell(Text(data['height'])),
                      DataCell(Text(data['temperature'])),
                      DataCell(Text(data['pulseRate'])),
                      DataCell(Text(data['sugarLevel'])),
                      DataCell(Text(data['gravida'])),
                      DataCell(Text(data['bloodGroup'])),
                      DataCell(Text(data['bodySurfaceArea'])),
                      DataCell(Text(data['respirationRate'])),
                      DataCell(Text(data['RH'])),
                      DataCell(Text(data['EDD'])),
                    ],
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
