import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mini_chat/app/routes/app_pages.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../data/config/app_cons.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    if (await Permission.contacts.request().isGranted) {
      Timer(const Duration(seconds: 3), () async {
        if (getBox.read(IS_USER_LOGGED_IN) ?? false) {
          await Clipboard.setData(ClipboardData(text: getBox.read(USER_TOKEN)));
          Get.offAllNamed(Routes.HOME);
        } else {
          Get.offAllNamed(Routes.LOGIN);
        }
      });
    } else {
      await Permission.contacts.request();
    }
  }
}
