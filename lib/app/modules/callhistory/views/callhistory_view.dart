import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/config/app_color.dart';
import '../controllers/callhistory_controller.dart';

class CallhistoryView extends GetView<CallhistoryController> {
  const CallhistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.litegrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ListBody(children: const []),
        ),
      ),
    );
  }

  builCall(String time, String number, Widget icon) {
    return Container(
      height: 70.h,
      width: Get.width / 3,
      margin: EdgeInsets.symmetric(vertical: 4.r),
      child: ListTile(
        onTap: () {},
        leading: CircleAvatar(
          radius: 20.r,
          backgroundColor: AppColor.apcolor,
        ),
        trailing: Icon(
          Icons.call,
          color: AppColor.green,
        ),
        title: Text(
          '+91 $number',
          style: TextStyle(color: Colors.black, fontSize: 17.r),
        ),
        subtitle: Wrap(
          spacing: 5.w,
          children: [
            icon,
            Text(
              time,
              style: TextStyle(color: Colors.black54, fontSize: 13.r),
            ),
          ],
        ),
      ),
    );
  }
}
