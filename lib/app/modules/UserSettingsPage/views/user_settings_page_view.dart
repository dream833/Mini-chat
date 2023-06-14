import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mini_chat/app/widgets/profile_picture.dart';

import '../../../data/config/app_color.dart';
import '../controllers/user_settings_page_controller.dart';

class UserSettingsPageView extends GetView<UserSettingsPageController> {
  const UserSettingsPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(UserSettingsPageController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.apcolor,
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: Get.width,
            height: 10.h,
          ),
          InkWell(
            onTap: () {
              controller.selectImage();
            },
            child: Obx(() => CustomProfileAvatar(
                  profilePicLink:
                      controller.profileController.myProfile.value.message !=
                              null
                          ? controller.profileController.myProfile.value
                              .message!.profilePicture
                          : "",
                  name: controller.profileController.myProfile.value.message !=
                          null
                      ? controller
                          .profileController.myProfile.value.message!.name
                      : "",
                  size: 80.sp,
                )),
          ),
          Card(
            child: ListTile(
                onTap: () {},
                title: const Text("Name"),
                subtitle: TextField(
                  controller: controller.nameTextController,
                  onSubmitted: (text) {
                    controller.updateName(text);
                  },
                  maxLength: 30,
                  decoration: InputDecoration(
                    suffix: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Icon(
                        Icons.edit,
                        size: 15.sp,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(0),
                    hintText: "Name",
                  ),
                )),
          ),
          Obx(() => Card(
                child: ListTile(
                  onTap: () {},
                  title: const Text("Number"),
                  subtitle: Text(
                    controller.profileController.myProfile.value.message != null
                        ? controller.profileController.myProfile.value.message!
                                .phone ??
                            ""
                        : "",
                  ),
                ),
              )),
          Card(
            child: ListTile(
              onTap: () {
                controller.logout();
              },
              title: const Text("Logout"),
              leading: const Icon(
                Icons.logout,
              ),
            ),
          )
        ],
      ),
    );
  }
}
