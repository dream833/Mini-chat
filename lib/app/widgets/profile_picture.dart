// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mini_chat/app/data/config/app_color.dart';

class CustomProfileAvatar extends StatelessWidget {
  CustomProfileAvatar({
    required this.profilePicLink,
    required this.name,
    required this.size,
    super.key,
  });
  double size;
  String? profilePicLink;
  String? name;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white),
        image: (profilePicLink ?? "").length > 6
            ? DecorationImage(
                image: CachedNetworkImageProvider(profilePicLink!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: !((profilePicLink ?? "").length > 6)
          ? CircleAvatar(
              backgroundColor: AppColor.apcolor,
              child: Center(
                child: FittedBox(
                  child: Text(
                    (name ?? "").isNotEmpty ? name!.substring(0, 1) : "U",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
