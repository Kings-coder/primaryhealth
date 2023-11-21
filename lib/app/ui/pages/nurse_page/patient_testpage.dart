import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NurseTestReportScreen extends StatefulWidget {
  const NurseTestReportScreen({super.key});

  @override
  _NurseTestReportScreenState createState() => _NurseTestReportScreenState();
}

class _NurseTestReportScreenState extends State<NurseTestReportScreen> {
  String? selectedPatient;

  // Create TextEditingController instances for each input field
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController temperatureController = TextEditingController();
  final TextEditingController pulseRateController = TextEditingController();
  final TextEditingController sugarLevelController = TextEditingController();
  final TextEditingController gravidaController = TextEditingController();
  final TextEditingController bloodGroupController = TextEditingController();
  final TextEditingController bodySurfaceAreaController =
      TextEditingController();
  final TextEditingController respirationRateController =
      TextEditingController();
  final TextEditingController RHController = TextEditingController();
  final TextEditingController EDDController = TextEditingController();

  List<String> patientNames = [];
  CollectionReference patients =
      FirebaseFirestore.instance.collection('patients');
  CollectionReference testReports =
      FirebaseFirestore.instance.collection('test_reports');

  @override
  void initState() {
    super.initState();
    loadPatientNames();
  }

  Future<void> loadPatientNames() async {
    final QuerySnapshot patientsSnapshot = await patients.get();
    List<String> patientNamesList = patientsSnapshot.docs
        .map<String>((doc) => doc.get('fullName') as String)
        .toList();

    setState(() {
      patientNames = patientNamesList;
    });
  }

  void updateTestReport() async {
    if (selectedPatient != null) {
      await testReports.add({
        'patientName': selectedPatient,
        'weight': weightController.text,
        'height': heightController.text,
        'temperature': temperatureController.text,
        'pulseRate': pulseRateController.text,
        'sugarLevel': sugarLevelController.text,
        'gravida': gravidaController.text,
        'bloodGroup': bloodGroupController.text,
        'bodySurfaceArea': bodySurfaceAreaController.text,
        'respirationRate': respirationRateController.text,
        'RH': RHController.text,
        'EDD': EDDController.text,
      });

      // Clear the text controllers after data submission
      weightController.clear();
      heightController.clear();
      temperatureController.clear();
      pulseRateController.clear();
      sugarLevelController.clear();
      gravidaController.clear();
      bloodGroupController.clear();
      bodySurfaceAreaController.clear();
      respirationRateController.clear();
      RHController.clear();
      EDDController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Test report updated for the selected patient.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a patient.')),
      );
    }
  }

  @override
  void dispose() {
    // Dispose of the text controllers to prevent memory leaks
    weightController.dispose();
    heightController.dispose();
    temperatureController.dispose();
    pulseRateController.dispose();
    sugarLevelController.dispose();
    gravidaController.dispose();
    bloodGroupController.dispose();
    bodySurfaceAreaController.dispose();
    respirationRateController.dispose();
    RHController.dispose();
    EDDController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nurse Test Report'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              value: selectedPatient,
              hint: const Text('Select a patient'),
              items: patientNames
                  .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedPatient = newValue;
                });
              },
            ),
            const SizedBox(height: 20),

            // Use TextFormField widgets with the corresponding text controllers
            TextFormField(
              controller: weightController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Weight'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: heightController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Height'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: temperatureController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Temperature'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: pulseRateController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Pulse Rate'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: sugarLevelController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Sugar Level'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: gravidaController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Gravida'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: bloodGroupController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Blood Group'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: bodySurfaceAreaController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Body Surface Area'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: respirationRateController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Respiration Rate'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: RHController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'RH'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: EDDController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'EDD'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateTestReport,
              child: const Text('Update Test Report'),
            ),
          ],
        ),
      ),
    );
  }
}
