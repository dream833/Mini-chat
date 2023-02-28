import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mini_chat/app/data/config/app_color.dart';
import 'package:mini_chat/app/widgets/chat_bubble_widget.dart';
import 'package:mini_chat/app/widgets/profile_picture.dart';

import '../../../widgets/contact_name_text.dart';
import '../controllers/chat_details_controller.dart';

class ChatDetailsView extends GetView<ChatDetailsController> {
  const ChatDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatDetailsController());

    return Scaffold(
        backgroundColor: AppColor.litegrey,
        appBar: AppBar(
          backgroundColor: AppColor.apcolor,
          title: Wrap(
            spacing: 6.w,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.center,
            children: [
              Obx(() => CustomProfileAvatar(
                    profilePicLink:
                        controller.myContactModel.value.profilePicture,
                    name: controller.myContactModel.value.name,
                    size: 30.sp,
                  )),
              Obx(() => ContactsNameWidget(
                    myContactModel: controller.myContactModel.value,
                  )),
            ],
          ),
          actions: [
            Icon(
              Icons.call,
              color: AppColor.white,
              size: 23.w,
            ),
            SizedBox(
              width: 25.w,
            ),
            Icon(
              Icons.more_vert,
              color: AppColor.white,
              size: 24.w,
            ),
          ],
          // centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            controller: controller.chatDetailsRefreshController,
            child: Column(
              children: [
                Obx(
                  () => ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.p2pMessageList.length,
                    itemBuilder: (context, index) {
                      var data = controller.p2pMessageList[index];
                      return ChatBubble(
                        p2pMessageModel: data,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 70,
                )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          alignment: Alignment.bottomCenter,
          margin: const EdgeInsets.all(6.0),
          height: 60,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35.0),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 7,
                          color: Colors.grey)
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.send,
                          controller: controller.chatController,
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 25.r),
                              hintText: "Type here...",
                              hintStyle: TextStyle(
                                  color: AppColor.grey), //Color(0xFF00BFA5)
                              border: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: AppColor.apcolor, shape: BoxShape.circle),
                child: InkWell(
                  child: sendIcon(),
                  onTap: () {
                    controller.sendAMsg(controller.chatController.text);
                  },
                ),
              )
            ],
          ),
        ));
  }

  Widget sendIcon() {
    return Obx(() => (controller.isSendButoonLaoding.value == false)
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.send_sharp,
              color: Colors.white,
              size: 19.w,
            ),
          )
        : const CircularProgressIndicator());
  }
}
