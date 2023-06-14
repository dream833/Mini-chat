import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../data/config/app_color.dart';
import '../../../widgets/contacts_widget.dart';
import '../controllers/contacts_page_controller.dart';

class ContactsPageView extends GetView<ContactsPageController> {
  const ContactsPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(ContactsPageController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.apcolor,
        title: const Text('Contacts'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() => Visibility(
                visible: controller.isContactsPageLoading.value,
                child: const LinearProgressIndicator())),
            Obx(
              () => ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.multiNumberCheckerModel.value.message !=
                        null
                    ? controller.multiNumberCheckerModel.value.message!.length
                    : 0,
                itemBuilder: (context, index) {
                  var data =
                      controller.multiNumberCheckerModel.value.message![index];

                  return ContactsWidget(
                    onInviteClick: () {
                      Share.share(
                          'Register on minichat app today.\n Download now: https://play.google.com/store/apps/details?id=com.bs.mini_chat');
                    },
                    myContactModel: data,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
