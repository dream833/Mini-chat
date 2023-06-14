import 'package:get/get.dart';

import '../controllers/callhistory_controller.dart';

class CallhistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CallhistoryController>(
      () => CallhistoryController(),
    );
  }
}
