import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'patient_history.dart';

class DoctorAppointmentsScreen extends StatefulWidget {
  const DoctorAppointmentsScreen({super.key});

  @override
  _DoctorAppointmentsScreenState createState() =>
      _DoctorAppointmentsScreenState();
}

class _DoctorAppointmentsScreenState extends State<DoctorAppointmentsScreen> {
  List<DocumentSnapshot> appointments = [];
  final User user = FirebaseAuth.instance.currentUser!;
  CollectionReference appointmentsCollection =
      FirebaseFirestore.instance.collection('Appointments');

  @override
  void initState() {
    super.initState();
    loadAppointments();
  }

  Future<void> loadAppointments() async {
    final QuerySnapshot appointmentsSnapshot = await appointmentsCollection
        .where('doctorId', isEqualTo: user.uid)
        .get();
    setState(() {
      appointments = appointmentsSnapshot.docs;
    });
  }

  Future<void> acceptAppointment(String appointmentId) async {
    await appointmentsCollection.doc(appointmentId).update({'accepted': true});
    _showAlert('Appointment Accepted', 'You have accepted the appointment.');
  }

  Future<void> declineAppointment(String appointmentId) async {
    await appointmentsCollection.doc(appointmentId).update({'declined': true});
    _showAlert('Appointment Declined', 'You have declined the appointment.');
  }

  Future<void> _showAlert(String title, String message) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void viewPatientHistory(String patientName) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PatientHistoryScreen(patientName: patientName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Appointments'),
      ),
      body: appointments.isEmpty
          ? const Center(
              child: Text('No Appointments', style: TextStyle(fontSize: 20)),
            )
          : ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointmentData =
                    appointments[index].data() as Map<String, dynamic>;
                final appointmentId = appointments[index].id;
                final isAccepted = appointmentData['accepted'] ?? false;
                final isDeclined = appointmentData['declined'] ?? false;

                return InkWell(
                  onTap: () {
                    Get.to(() => PatientHistoryScreen(
                        patientName: appointmentData['patientName']));
                  },
                  child: Card(
                    elevation: 3,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      title: Text('Patient: ${appointmentData['patientName']}'),
                      subtitle: Text(
                          'Appointment Date: ${appointmentData['appointmentDate']}'),
                      trailing: isAccepted
                          ? const Text('Accepted',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 16))
                          : isDeclined
                              ? const Text('Declined',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 16))
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextButton(
                                      onPressed: () =>
                                          acceptAppointment(appointmentId),
                                      child: const Text('Accept',
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 16)),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          declineAppointment(appointmentId),
                                      child: const Text('Decline',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 16)),
                                    ),
                                  ],
                                ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
