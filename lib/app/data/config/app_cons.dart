// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

final getBox = GetStorage();
const String USER_NUMBER = "USER_NUMBER";
const String USER_CONTACTS = "USER_CONTACTS";
const String USER_TOKEN = "USER_TOKEN";
const String IS_USER_LOGGED_IN = "IS_USER_LOGGED_IN";

var isDebugMode = false.obs;

const String BASE_URL = 'https://api.minichat.smartbeautylive.com';

void SHOW_SNACKBAR({int? duration, String? message, bool? isSuccess}) {
  final snackbar = GetSnackBar(
      backgroundColor: (isSuccess ?? true) ? Colors.green : Colors.red,
      duration: Duration(milliseconds: duration ?? 2500),
      message: message ?? "No Message");
  Get.showSnackbar(snackbar);
}
