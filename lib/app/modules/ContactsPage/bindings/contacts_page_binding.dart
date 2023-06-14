import 'package:get/get.dart';

import '../controllers/contacts_page_controller.dart';

class ContactsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactsPageController>(
      () => ContactsPageController(),
    );
  }
}
