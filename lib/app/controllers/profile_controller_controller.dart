import 'package:get/get.dart';
import 'package:mini_chat/app/data/functions/dio_get.dart';
import 'package:mini_chat/app/data/models/get_a_user_model.dart';

class ProfileControllerController extends GetxController {
  var myProfile = GetAUserModel().obs;

  @override
  void onInit() {
    super.onInit();
    getMyProfile();
  }

  void getMyProfile() async {
    var response = await dioGet("/api/user/fetch/1");
    if (response.statusCode == 200) {
      myProfile(GetAUserModel.fromJson(response.data));
    }
  }
}
