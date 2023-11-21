import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PatientDataTable extends StatefulWidget {
  const PatientDataTable({super.key});

  @override
  _PatientDataTableState createState() => _PatientDataTableState();
}

class _PatientDataTableState extends State<PatientDataTable> {
  List<Map<String, dynamic>> patientData = [];

  @override
  void initState() {
    super.initState();
    // Load patient data from Firestore when the widget is initialized
    loadPatientData();
  }

  Future<void> loadPatientData() async {
    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('patients').get();

      final List<Map<String, dynamic>> tempPatientData = [];

      for (var doc in querySnapshot.docs) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        tempPatientData.add(data);
      }

      setState(() {
        patientData = tempPatientData;
      });
    } catch (e) {
      print("Error loading patient data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: DataTable(
          columns: const [
            DataColumn(label: Text('PatientId')),
            DataColumn(label: Text('FullName')),
            DataColumn(label: Text('Age')),
            DataColumn(label: Text('Phone No')),
            DataColumn(label: Text('Gender')),
            DataColumn(label: Text('State')),
            DataColumn(label: Text('LGA')),
            DataColumn(label: Text('H/Town')),
            DataColumn(label: Text('M/Status')),
            DataColumn(label: Text('P/Name')),
            DataColumn(label: Text('Relationship')),
            DataColumn(label: Text('P/Phone')),
          ],
          rows: patientData
              .map((data) => DataRow(
                    cells: [
                      DataCell(Text(data['patientId'])),
                      DataCell(Text(data['fullName'])),
                      DataCell(Text(data['age'])),
                      DataCell(Text(data['phoneNo'])),
                      DataCell(Text(data['gender'])),
                      DataCell(Text(data['state'])),
                      DataCell(Text(data['lga'])),
                      DataCell(Text(data['homeTown'])),
                      DataCell(Text(data['maritalStatus'])),
                      DataCell(Text(data['parentFullName'])),
                      DataCell(Text(data['relationshipToChild'])),
                      DataCell(Text(data['parentPhoneNumber'])),
                    ],
                  ))
              .toList(),
        ),
      ),
    );
  }
}
