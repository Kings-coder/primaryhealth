import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/admin_login_Controller.dart';
import 'widget/login_desktop.dart';

class AdminLoginPage extends GetView<AdminLoginController> {
  const AdminLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return  Container();
          } else if (constraints.maxWidth > 600 && constraints.maxWidth < 900) {
            return  Container();
          } else {
            return const AdminLoginDesktop();
          }
        },
      ),
    );
  }
}
