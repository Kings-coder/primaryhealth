// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';

// import '../AdminPanel/model/health_model.dart';

// class HealthDataController extends GetxController {
//   final RxList<HealthModel> healthDetails = <HealthModel>[].obs;

//   void fetchDataFromFirestore() async {
//     try {
//       final QuerySnapshot snapshot = await FirebaseFirestore.instance
//           .collection('payment_option')
//           .get(); // Replace 'your_collection_name' with your Firestore collection name

//       final data = snapshot.docs.first.data();

//       if (data != null && data is Map<String, dynamic>) {
//         // Assuming your Firestore data structure matches the HealthModel
//         healthDetails
//             .add(HealthModel(value: data['SUG Dues'].toString(), title: "SUG"));
//             healthDetails
//             .add(HealthModel(value: data['NIDSUG Dues'].toString(), title: "NIDSUG"));
//             healthDetails
//             .add(HealthModel(value: data['NURSS Dues'].toString(), title: "NURSS"));
//         // Add other fields in a similar manner
//       } else {
//         print("Data is not in the expected format");
//       }
//     } catch (e) {
//       print("Error fetching data: $e");
//     }
//   }
// }
