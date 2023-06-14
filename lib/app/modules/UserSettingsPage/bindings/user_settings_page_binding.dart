import 'package:get/get.dart';

import '../controllers/user_settings_page_controller.dart';

class UserSettingsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserSettingsPageController>(
      () => UserSettingsPageController(),
    );
  }
}
