import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mini_chat/app/data/functions/get_user_contact.dart';
import 'package:mini_chat/app/widgets/contact_name_text.dart';
import 'package:mini_chat/app/widgets/profile_picture.dart';

import '../routes/app_pages.dart';

// ignore: must_be_immutable
class ChatUserListWidget extends StatelessWidget {
  String name;
  String number;
  String profilePicture;
  String lastMsg;
  String msgTime;
  ChatUserListWidget({
    required this.name,
    required this.number,
    required this.profilePicture,
    required this.lastMsg,
    required this.msgTime,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    late String dateText;
    var todaysDate = DateTime.now();
    var date = DateTime.fromMillisecondsSinceEpoch(int.parse(msgTime));

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
    return Card(
      child: ListTile(
        onTap: () {
          Get.toNamed(
            Routes.CHAT_DETAILS,
            parameters: {"number": number},
          );
        },
        leading: CustomProfileAvatar(
          profilePicLink: profilePicture,
          name: name,
          size: 60.sp,
        ),
        title: FutureBuilder(
            future: getUserContact(number),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return ContactsNameWidget(
                  myContactModel: snapshot.data!,
                );
              } else {
                return const SizedBox();
              }
            }),
        subtitle: Row(
          children: [Expanded(child: Text(lastMsg)), Text(dateText)],
        ),
      ),
    );
  }
}
