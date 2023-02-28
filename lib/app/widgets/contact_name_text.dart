import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

import '../data/models/multi_number_checker_model_model.dart';

// ignore: must_be_immutable
class ContactsNameWidget extends StatelessWidget {
  MyContactModel myContactModel;
  TextStyle? textStyle;
  ContactsNameWidget({
    required this.myContactModel,
    this.textStyle,
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
                  return Text(
                    data.displayName ?? myContactModel.phone ?? "",
                    style: textStyle,
                  );
                } else {
                  return const SizedBox(height: 0, width: 0);
                }
              });
        } else {
          return Builder(builder: (context) {
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
                future:
                    ContactsService.getContactsForPhone(myContactModel.phone),
                builder: (context, snapshot) {
                  if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                    return Text(
                      snapshot.data!.first.displayName ?? myContactModel.name!,
                      style: textStyle,
                    );
                  } else {
                    return Text(myContactModel.phone ?? "", style: textStyle);
                  }
                },
              );
            }
          });
        }
      },
    );
  }
}
