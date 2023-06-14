// ignore_for_file: library_prefixes, implementation_imports, depend_on_referenced_packages

import 'dart:io';

import 'package:dio/dio.dart' as DIO;
import 'package:dio/src/form_data.dart' as FORMDATA;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart' as HTTP_PARSER;
import 'package:image_picker/image_picker.dart';
import 'package:mini_chat/app/data/config/app_cons.dart';
import 'package:mini_chat/app/data/functions/dio_send.dart';

import '../../../controllers/profile_controller_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/common_button.dart';

class UserSettingsPageController extends GetxController {
  var profileController = Get.put(ProfileControllerController());
  var nameTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    nameTextController.text = profileController.myProfile.value.message != null
        ? profileController.myProfile.value.message!.name ?? ""
        : "";
  }

  void selectImage() async {
    try {
      var result = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (result != null) {
        var image = File(result.path);
        var isDialogButtonLoading = false.obs;
        Get.defaultDialog(
          title: "Update profile",
          middleText: "Are you sure to update the seleted profile picture?",
          content: CircleAvatar(
            radius: 70,
            backgroundImage: FileImage(
              File(
                result.path,
              ),
            ),
          ),
          confirm: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CommonButton(
                    text: "Upload",
                    onTap: () async {
                      isDialogButtonLoading(true);
                      FORMDATA.FormData formData = FORMDATA.FormData.fromMap({
                        "profilePicture": await DIO.MultipartFile.fromFile(
                            image.path,
                            filename: image.path.split('/').last,
                            contentType: HTTP_PARSER.MediaType('image', 'png')),
                      });

                      await dioPost(
                        isPost: false,
                        endUrl: "/api/user/update/1",
                        data: formData,
                      ).then((value) {
                        isDialogButtonLoading(false);
                        if (value.statusCode == 200) {
                          Get.showSnackbar(const GetSnackBar(
                            backgroundColor: Colors.green,
                            message: "Profile picture updated",
                            duration: Duration(milliseconds: 3000),
                          ));
                          profileController.getMyProfile();
                          Navigator.of(Get.overlayContext!).pop();
                        } else {
                          Get.showSnackbar(GetSnackBar(
                            backgroundColor: Colors.red,
                            message: value.statusMessage,
                            duration: const Duration(milliseconds: 3000),
                          ));
                        }
                      });
                    },
                    isLoading: isDialogButtonLoading,
                  )),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      } else {
        Get.showSnackbar(const GetSnackBar(
          backgroundColor: Colors.red,
          message: "Please select a File to upload",
          duration: Duration(milliseconds: 3000),
        ));
      }
    } on PlatformException catch (e) {
      Get.showSnackbar(GetSnackBar(
        backgroundColor: Colors.red,
        message: "Failed: $e",
        duration: const Duration(milliseconds: 3000),
      ));
    }
  }

  void updateName(String text) async {
    var response = await dioPost(
        endUrl: "/api/user/update/1",
        isPost: false,
        data: FORMDATA.FormData.fromMap({"name": text}));
    if (response.statusCode == 200) {
      SHOW_SNACKBAR(message: response.data["message"]);
    } else {
      SHOW_SNACKBAR(message: response.data["message"], isSuccess: false);
    }
  }

  void logout() {
    getBox.write(IS_USER_LOGGED_IN, false);
    Get.offAllNamed(Routes.SPLASH);
  }
}
