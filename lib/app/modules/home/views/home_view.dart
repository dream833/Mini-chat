import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mini_chat/app/data/config/app_color.dart';
import 'package:mini_chat/app/widgets/profile_picture.dart';

import '../../../routes/app_pages.dart';
import '../../Chat/views/chat_view.dart';
import '../../callhistory/views/callhistory_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.apcolor,
          bottom: TabBar(
            labelStyle: TextStyle(fontSize: 16.r, fontWeight: FontWeight.w500),
            tabs: const [
              Tab(text: 'Inbox'),
              Tab(text: 'Calls'),
            ],
          ),
          title: Row(
            children: [
              const Expanded(child: Text('Mini Chat')),
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.USER_SETTINGS_PAGE);
                },
                child: Obx(() => CustomProfileAvatar(
                      profilePicLink: controller
                                  .profileController.myProfile.value.message !=
                              null
                          ? controller.profileController.myProfile.value
                              .message!.profilePicture
                          : "",
                      name: controller
                                  .profileController.myProfile.value.message !=
                              null
                          ? controller
                              .profileController.myProfile.value.message!.name
                          : "",
                      size: 30.sp,
                    )),
              ),
            ],
          ),
          leading: const Text(''),
        ),
        body: const TabBarView(
          children: [ChatView(), CallhistoryView()],
        ),
      ),
    );
  }
}
