
import 'package:get/get.dart';
import '../controllers/admindashboard_controller.dart';


class AdmindashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdmindashboardController>(() => AdmindashboardController());
  }
}