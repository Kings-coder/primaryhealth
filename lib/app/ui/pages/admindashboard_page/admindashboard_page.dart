
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/admindashboard_controller.dart';


class AdmindashboardPage extends GetView<AdmindashboardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AdmindashboardPage'),
      ),
      body: SafeArea(
        child: Text('AdmindashboardController'),
      ),
    );
  }
}
  