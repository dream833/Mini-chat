// ignore_for_file: library_prefixes

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart' as DIO;

import '../config/app_cons.dart';

Future<DIO.Response<dynamic>> dioGet(String endUrl) async {
  var dio = DIO.Dio();
  if (getBox.read(IS_USER_LOGGED_IN) ?? false) {
    dio.options.headers['authSmartliveChatUser'] = getBox.read(USER_TOKEN);
  }

  dio.options.headers['authSmartliveChat'] =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcHAiOiJzbWFydGxpdmVtaW5pY2hhdCIsImlhdCI6MTY2MTE3MTU1OH0._65E395SZXzdXnDtJlwR91E7X6fIO0M78123biRfV0E";

  var response = await dio.get(
    "$BASE_URL$endUrl",
    options: DIO.Options(
      validateStatus: (status) => true,
      sendTimeout: 100000,
      receiveTimeout: 15000,
    ),
  );
  isDebugMode.value
      ? log(
          "\n\nGET: $endUrl\nSTATUS CODE: ${response.statusCode}\n${jsonEncode(response.data)}\n\n")
      : null;
  return response;
}

Future<DIO.Response<dynamic>> dioUGet(String endUrl) async {
  var dio = DIO.Dio();
  if (getBox.read(IS_USER_LOGGED_IN) ?? false) {
    dio.options.headers['authSmartliveChatUser'] = getBox.read(USER_TOKEN);
  }

  dio.options.headers['authSmartliveChat'] =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcHAiOiJzbWFydGxpdmVtaW5pY2hhdCIsImlhdCI6MTY2MTE3MTU1OH0._65E395SZXzdXnDtJlwR91E7X6fIO0M78123biRfV0E";

  var response = await dio.get(
    endUrl,
    options: DIO.Options(
      validateStatus: (status) => true,
      sendTimeout: 100000,
      receiveTimeout: 15000,
    ),
  );
  isDebugMode.value
      ? log(
          "\n\nGET: $endUrl\nSTATUS CODE: ${response.statusCode}\n${jsonEncode(response.data)}\n\n")
      : null;
  return response;
}
