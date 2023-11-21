import 'package:clearance_system/app/ui/pages/register_page/widget/register_desktop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return Container();
          } else if (constraints.maxWidth > 600 && constraints.maxWidth < 900) {
            return Container();
          } else {
            return  Container();
          }
        },
      ),
    );
  }
}
