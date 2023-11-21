import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminAssignDoctorScreen extends StatefulWidget {
  const AdminAssignDoctorScreen({super.key});

  @override
  _AdminAssignDoctorScreenState createState() =>
      _AdminAssignDoctorScreenState();
}

class _AdminAssignDoctorScreenState extends State<AdminAssignDoctorScreen> {
  String? selectedPatient;
  String? selectedDoctor;
  DateTime? selectedAppointmentDate;

  List<String> patientIds = [];
  List<String> doctorIds = [];
  Map<String, String> patientNamesMap = {};
  Map<String, String> doctorNamesMap = {};

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference patients =
      FirebaseFirestore.instance.collection('patients');
  CollectionReference appointments =
      FirebaseFirestore.instance.collection('Appointments');

  @override
  void initState() {
    super.initState();
    // Load patient IDs and names from Firestore
    loadPatientsData();
    loadDoctorsData();
  }

  Future<void> loadPatientsData() async {
    final QuerySnapshot patientsSnapshot = await patients.get();

    List<String> patientIdsList = [];
    Map<String, String> patientNamesMap = {};

    for (var doc in patientsSnapshot.docs) {
      final patientData = doc.data() as Map<String, dynamic>;
      final patientId = doc.id;
      final patientName = patientData[
          'fullName']; // Change this to the actual field name in your data

      patientIdsList.add(patientId);
      patientNamesMap[patientId] = patientName;
    }

    setState(() {
      patientIds = patientIdsList;
      this.patientNamesMap = patientNamesMap;
    });
  }

  Future<void> loadDoctorsData() async {
    final QuerySnapshot doctorsSnapshot =
        await users.where('role', isEqualTo: 'Doctor').get();

    List<String> doctorIdsList = [];
    Map<String, String> doctorNamesMap = {};

    for (var doc in doctorsSnapshot.docs) {
      final doctorData = doc.data() as Map<String, dynamic>;
      final doctorId = doc.id;
      final doctorName = doctorData[
          'name']; // Change this to the actual field name in your data

      doctorIdsList.add(doctorId);
      doctorNamesMap[doctorId] = doctorName;
    }

    setState(() {
      doctorIds = doctorIdsList;
      this.doctorNamesMap = doctorNamesMap;
    });
  }

  void assignPatientToDoctor() async {
    if (selectedPatient != null &&
        selectedDoctor != null &&
        selectedAppointmentDate != null) {
      // Assign the selected patient to the selected doctor
      await patients.doc(selectedPatient).update({
        'assignedDoctorId': selectedDoctor,
        'assignedPatientName':
            patientNamesMap[selectedPatient] ?? 'Unknown Patient Name',
      });

      // Create an appointment document in Firestore
      await appointments.add({
        'patientId': selectedPatient,
        'doctorId': selectedDoctor,
        'appointmentDate': selectedAppointmentDate,
        'patientName':
            patientNamesMap[selectedPatient] ?? 'Unknown Patient Name',
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Patient assigned to doctor with an appointment!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Please select a patient, a doctor, and an appointment date.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Select patient:",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              width: 500,
              height: 50,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      width: 0.50, color: Color.fromARGB(255, 86, 86, 86)),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedPatient,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedPatient = newValue;
                    });
                  },
                  items:
                      patientIds.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                          patientNamesMap[value] ?? 'Unknown Patient Name'),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Select Doctor:",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              width: 500,
              height: 50,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      width: 0.50, color: Color.fromARGB(255, 86, 86, 86)),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedDoctor,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDoctor = newValue;
                    });
                  },
                  items:
                      doctorIds.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child:
                          Text(doctorNamesMap[value] ?? 'Unknown Doctor Name'),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Select Appointment Date:",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              style: ElevatedButton.styleFrom(fixedSize: const Size(300, 40)),
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );

                if (picked != null && picked != selectedAppointmentDate) {
                  setState(() {
                    selectedAppointmentDate = picked;
                  });
                }
              },
              child: const Text('Pick Appointment Date'),
            ),
            const SizedBox(height: 5),
            Text(
              selectedAppointmentDate != null
                  ? 'Selected Appointment Date: ${selectedAppointmentDate!.toLocal()}'
                      .split(' ')[0]
                  : 'No Date Selected',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 40),
              ),
              onPressed: assignPatientToDoctor,
              child: const Text('Assign Patient to Doctor with Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}
