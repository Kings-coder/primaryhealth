import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchPaymentDetails(String reference) async {
  final url = 'https://api.paystack.co/transaction/verify/$reference';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['data'];
  } else {
    throw Exception('Failed to fetch payment details');
  }
}
