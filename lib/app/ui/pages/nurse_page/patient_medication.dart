import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../data/models/patient_model.dart';
import 'patient_prescription.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  _PatientListScreenState createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  List<Patient> patients = [];

  @override
  void initState() {
    super.initState();
    fetchPatients();
  }

  Future<void> fetchPatients() async {
    final QuerySnapshot patientsSnapshot =
        await FirebaseFirestore.instance.collection('patients').get();

    final List<Patient> patientList = patientsSnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final fullName = data['fullName']; // Adjust to your data structure
      return Patient(fullName: fullName);
    }).toList();

    setState(() {
      patients = patientList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient List'),
      ),
      body: ListView.builder(
        itemCount: patients.length,
        itemBuilder: (context, index) {
          final patient = patients[index];
          return Card(
            elevation: 8,
            child: ListTile(
              title: Text(patient.fullName),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NurseViewPrescriptionScreen(
                      patientName: patient.fullName,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
