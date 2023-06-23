import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_chat/app/data/config/app_color.dart';
import 'package:mini_chat/app/data/config/app_cons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/chat_user_list_widget.dart';
import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(ChatController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Get.toNamed(Routes.CONTACTS_PAGE);
        },
        backgroundColor: AppColor.apcolor,
        child: Icon(
          Icons.add,
          color: AppColor.white,
        ),
      ),
      body: SafeArea(
        child: SmartRefresher(
          controller: controller.chatRefreshController,
          onRefresh: () {
            controller.onRefresh();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(() => Visibility(
                    visible: controller.isChatPageLoading.value,
                    child: const LinearProgressIndicator())),
                Obx(() => ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          controller.conversationListModel.value.messages !=
                                  null
                              ? controller
                                  .conversationListModel.value.messages!.length
                              : 0,
                      itemBuilder: (context, index) {
                        var data = controller
                            .conversationListModel.value.messages![index];
                        return ChatUserListWidget(
                          lastMsg: data.text.toString(),
                          msgTime: (data.date ?? 0).toString(),
                          name: data.senderNumber == getBox.read(USER_NUMBER)
                              ? data.receiverName ?? ""
                              : data.senderName ?? "",
                          number: data.senderNumber == getBox.read(USER_NUMBER)
                              ? data.receiverNumber ?? ""
                              : data.senderNumber ?? "",
                          profilePicture:
                              data.senderNumber == getBox.read(USER_NUMBER)
                                  ? data.receiverImage ?? ""
                                  : data.senderImage ?? "",
                        );
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
