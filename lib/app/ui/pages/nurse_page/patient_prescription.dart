import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NurseViewPrescriptionScreen extends StatelessWidget {
  final String patientName;
  const NurseViewPrescriptionScreen({
    Key? key,
    required this.patientName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Prescription: $patientName'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(
                'prescriptions') // Assuming the prescriptions collection name
            .where('patientName', isEqualTo: patientName)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final prescriptions = snapshot.data!.docs;

          if (prescriptions.isEmpty) {
            return const Center(
              child: Text(
                'No prescriptions available for this patient.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          }

          return ListView.builder(
            itemCount: prescriptions.length,
            itemBuilder: (context, index) {
              final 
              prescriptionData =
                  prescriptions[index].data() as Map<String, dynamic>;
              return Card(
                margin: const EdgeInsets.all(8),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(
                    'Date: ${prescriptionData['date']}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTileInfo(
                          'Medication', prescriptionData['prescription']),
                      ListTileInfo('Treatment', prescriptionData['treatment']),
                      // Add more fields as needed
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
