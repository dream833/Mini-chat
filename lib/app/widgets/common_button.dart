// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonButton extends StatelessWidget {
  String? text;
  Function? onTap;
  Rx<bool>? isLoading;
  CommonButton({
    Key? key,
    required this.text,
    required this.onTap,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap != null ? onTap!() : null;
      },
      child: Container(
        height: 50,
        width: Get.width - 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color(0xffb71a34),
        ),
        child: Center(
            child: isLoading != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => !(isLoading!.value)
                          ? Text(
                              text ?? "",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                    ),
                  )
                : Text(
                    text ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
      ),
    );
  }
}
