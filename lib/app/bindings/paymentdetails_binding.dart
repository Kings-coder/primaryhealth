
import 'package:get/get.dart';
import '../controllers/paymentdetails_controller.dart';


class PaymentdetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentdetailsController>(() => PaymentdetailsController());
  }
}