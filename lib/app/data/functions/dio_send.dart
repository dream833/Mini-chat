// ignore_for_file: library_prefixes

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart' as DIO;

import '../config/app_cons.dart';

Future<DIO.Response<dynamic>> dioPost(
    {bool? isPost, dynamic data, String? endUrl, bool? sendFile}) async {
  var dio = DIO.Dio();
  if (getBox.read(IS_USER_LOGGED_IN) ?? false) {
    dio.options.headers['authSmartliveChatUser'] = getBox.read(USER_TOKEN);
  }

  dio.options.headers['authSmartliveChat'] =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcHAiOiJzbWFydGxpdmVtaW5pY2hhdCIsImlhdCI6MTY2MTE3MTU1OH0._65E395SZXzdXnDtJlwR91E7X6fIO0M78123biRfV0E";

  sendFile ?? false
      ? dio.options.headers["Content-Type"] = "multipart/form-data"
      : null;

  if (isPost ?? true) {
    var response = await dio.post(
      "$BASE_URL$endUrl",
      data: data,
      options: DIO.Options(
        validateStatus: (status) => true,
        sendTimeout: 100000,
        receiveTimeout: 100000,
      ),
    );
    isDebugMode.value
        ? log(
            "\n\n${isPost ?? true ? 'POST:' : 'PUT'} $endUrl\nSTATUS CODE: ${response.statusCode}\n${jsonEncode(response.data)}\n\n")
        : null;

    return response;
  } else {
    var response = await dio.put(
      "$BASE_URL$endUrl",
      data: data,
      options: DIO.Options(
        validateStatus: (status) => true,
        sendTimeout: 100000,
        receiveTimeout: 100000,
      ),
    );
    isDebugMode.value
        ? log(
            "\n\n${isPost ?? true ? 'POST:' : 'PUT'} $endUrl\nSTATUS CODE: ${response.statusCode}\n${jsonEncode(response.data)}\n\n")
        : null;
    return response;
  }
}
