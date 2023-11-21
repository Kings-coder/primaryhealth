import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack_client/flutter_paystack_client.dart';
import 'package:get/get.dart';

import 'app/ui/pages/landing_page/landing_page.dart';
import 'firebase_options.dart';

Future<void> main() async {
  String paystackPublicKey = 'pk_test_63cf86f6c99897f69f560f5b4fdf85e1ca122314';
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await PaystackClient.initialize(paystackPublicKey);
  runApp(const GetMaterialApp(
    debugShowCheckedModeBanner: false,
    // initialRoute: Routes.SPLASH,
    // theme: appThemeData,
    defaultTransition: Transition.fade,
    // initialBinding: LoginBinding(),
    // getPages: AppPages.pages,
    home: LandingPage(),
  ));
}
