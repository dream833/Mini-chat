// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mini_chat/app/data/config/app_cons.dart';
import 'package:mini_chat/app/data/models/p2p_chat_model_model.dart';
import 'package:mini_chat/app/widgets/profile_picture.dart';

import '../data/config/app_color.dart';
import '../data/functions/get_user_contact.dart';
import 'contact_name_text.dart';

class ChatBubble extends StatelessWidget {
  P2PMessageModel p2pMessageModel;
  ChatBubble({required this.p2pMessageModel, super.key});

  @override
  Widget build(BuildContext context) {
    late String dateText;
    var todaysDate = DateTime.now();
    var date = DateTime.fromMillisecondsSinceEpoch(p2pMessageModel.date ?? 0);

    if (todaysDate.day == date.day &&
        date.month == todaysDate.month &&
        date.year == todaysDate.year) {
      dateText = DateFormat('hh:mm a').format(date);
    } else {
      if ((todaysDate.day - date.day == 1) &&
          date.month == todaysDate.month &&
          date.year == todaysDate.year) {
        dateText = "Yesterday, ${DateFormat('hh:mm a').format(date)}";
      } else {
        dateText =
            "${date.year.toString().substring(1, 3)}/${date.month}/${date.day > 9 ? date.day : '0${date.day}'} ${DateFormat('hh:mm a').format(date)}";
      }
    }

    return Builder(
        key: key,
        builder: (context) {
          if (p2pMessageModel.senderNumber == getBox.read(USER_NUMBER)) {
            
            return Container(
              width: Get.width / 3,
              margin: EdgeInsets.only(
                  left: 80.r, bottom: 4.r, top: 4.r, right: 5.r),
              child: Card(
                color: AppColor.pinklitecolor,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      ((p2pMessageModel.text.toString() != "")?Text(p2pMessageModel.text.toString())
                      :Image.network(
                          p2pMessageModel.image.toString())),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(dateText),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Container(
              width: Get.width / 3,
              margin: EdgeInsets.only(
                  right: 100.r, top: 5.r, bottom: 5.r, left: 4.r),
              child: ListTile(
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: AppColor.white)),
                onTap: () {},
                leading: CustomProfileAvatar(
                  profilePicLink: p2pMessageModel.senderImage,
                  name: p2pMessageModel.senderName,
                  size: 40.r,
                ),
                tileColor: AppColor.white,
                title: FutureBuilder(
                    future: getUserContact(p2pMessageModel.senderNumber ?? ""),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        return ContactsNameWidget(
                          myContactModel: snapshot.data!,
                        );
                      } else {
                        return const SizedBox();
                      }
                    }),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    
                    ((p2pMessageModel.text.toString() != "")
                        ? 
                        Text(
                            p2pMessageModel.text.toString(),
                            style:
                                TextStyle(color: Colors.black, fontSize: 14.sp),
                          )
                        :Image.network(p2pMessageModel.image.toString()) ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(dateText),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        });
  }
}
