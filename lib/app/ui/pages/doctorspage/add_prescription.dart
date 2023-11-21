import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPrescriptionScreen extends StatefulWidget {
  final String patientName;
  final String testReportId;

  const AddPrescriptionScreen({
    Key? key,
    required this.patientName,
    required this.testReportId,
  }) : super(key: key);

  @override
  _AddPrescriptionScreenState createState() => _AddPrescriptionScreenState();
}

class _AddPrescriptionScreenState extends State<AddPrescriptionScreen> {
  final TextEditingController prescriptionController = TextEditingController();
  final TextEditingController treatmentController = TextEditingController();

  void addPrescriptionAndTreatment() async {
    final String prescription = prescriptionController.text;
    final String treatment = treatmentController.text;
    final String patientName = widget.patientName;
    final String testReportId = widget.testReportId;

    if (prescription.isNotEmpty && treatment.isNotEmpty) {
      final CollectionReference prescriptions =
          FirebaseFirestore.instance.collection('prescriptions');

      final Timestamp currentDate = Timestamp.now();

      await prescriptions.add({
        'patientName': patientName,
        'testReportId': testReportId,
        'prescription': prescription,
        'treatment': treatment,
        'date': currentDate, // Include the current date
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Prescription and treatment added successfully.'),
        ),
      );

      // Clear the input fields
      prescriptionController.clear();
      treatmentController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Please fill in both prescription and treatment fields.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Prescription and Treatment for ${widget.patientName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: prescriptionController,
              decoration: const InputDecoration(
                labelText: 'Prescription',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: treatmentController,
              decoration: const InputDecoration(
                labelText: 'Treatment',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: addPrescriptionAndTreatment,
              child: const Text('Add Prescription and Treatment'),
            ),
          ],
        ),
      ),
    );
  }
}
