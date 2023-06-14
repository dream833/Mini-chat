import 'package:get/get.dart';
import 'package:mini_chat/app/controllers/profile_controller_controller.dart';

class HomeController extends GetxController {
  var profileController = Get.put(ProfileControllerController());
}
