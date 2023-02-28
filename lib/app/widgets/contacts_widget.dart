import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_chat/app/widgets/profile_picture.dart';

import '../data/models/multi_number_checker_model_model.dart';
import '../routes/app_pages.dart';

// ignore: must_be_immutable
class ContactsWidget extends StatelessWidget {
  MyContactModel myContactModel;
  Callback? onInviteClick;

  ContactsWidget({
    required this.myContactModel,
    this.onInviteClick,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (myContactModel.status == "Not Registered") {
          return FutureBuilder(
              future: ContactsService.getContactsForPhone(myContactModel.phone),
              builder: (context, snapshot) {
                if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                  var data = snapshot.data!.first;
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Get.offNamed(
                          Routes.CHAT_DETAILS,
                          parameters: {"number": myContactModel.phone ?? ""},
                        );
                      },
                      trailing: InkWell(
                        onTap: () {
                          if (onInviteClick != null) {
                            onInviteClick!();
                          }
                        },
                        child: Card(
                          color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Invite",
                              style: GoogleFonts.varelaRound(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      leading: CustomProfileAvatar(
                        profilePicLink: myContactModel.profilePicture,
                        name: myContactModel.name,
                        size: 60.sp,
                      ),
                      subtitle: Text(myContactModel.phone ?? ""),
                      title: Text(
                        data.displayName ?? myContactModel.phone ?? "",
                      ),
                    ),
                  );
                } else {
                  return const SizedBox(height: 0, width: 0);
                }
              });
        } else {
          return Card(
            child: ListTile(
              onTap: () {
                Get.offNamed(
                  Routes.CHAT_DETAILS,
                  parameters: {"number": myContactModel.phone ?? ""},
                );
              },
              leading: CustomProfileAvatar(
                profilePicLink: myContactModel.profilePicture,
                name: myContactModel.name,
                size: 60.sp,
              ),
              title: Builder(builder: (context) {
                if (myContactModel.name != null &&
                    myContactModel.name!.length > 1) {
                  return Text(
                    myContactModel.name!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  );
                } else {
                  return FutureBuilder(
                    future: ContactsService.getContactsForPhone(
                        myContactModel.phone),
                    builder: (context, snapshot) {
                      if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                        return Text(
                          snapshot.data!.first.displayName ??
                              myContactModel.name!,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        );
                      } else {
                        return Text(
                          myContactModel.phone ?? "",
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        );
                      }
                    },
                  );
                }
              }),
              subtitle: Text(myContactModel.phone ?? ""),
            ),
          );
        }
      },
    );
  }
}
