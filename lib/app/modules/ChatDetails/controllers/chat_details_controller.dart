// ignore_for_file: library_prefixes

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart' as DIO;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mini_chat/app/data/functions/dio_get.dart';
import 'package:mini_chat/app/data/functions/dio_send.dart';
import 'package:mini_chat/app/data/functions/get_room_id.dart';
import 'package:mini_chat/app/data/functions/get_user_contact.dart';
import 'package:mini_chat/app/data/models/p2p_chat_model_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../data/config/app_cons.dart';
import '../../../data/models/multi_number_checker_model_model.dart';

class ChatDetailsController extends GetxController {
  var parameters = Get.parameters;
  var myContactModel = MyContactModel().obs;
  RxList<P2PMessageModel> p2pMessageList = <P2PMessageModel>[].obs;

  var chatController = TextEditingController();
  IO.Socket? socket;
  var isSendButoonLaoding = false.obs;
  var chatDetailsRefreshController = ScrollController();
  var channelId = "".obs;
  var token = "".obs;

  String getChannelName(localUserId, remoteUserId) {
    String channelName;
    if (localUserId.compareTo(remoteUserId) == 1) {
      channelName = localUserId + remoteUserId;
    } else {
      channelName = remoteUserId + localUserId;
    }
    return channelName;
  }

  Future<String> getToken(link) async {
    var dio = DIO.Dio();
    var response = await dio.get(
      link,
      options: DIO.Options(
        validateStatus: (status) => true,
        sendTimeout: 100000,
        receiveTimeout: 15000,
      ),
    );
    return response.data["token"];
  }

  @override
  void onInit() async {
    super.onInit();
    channelId(getChannelName(
        getBox.read(USER_NUMBER).toString(), parameters["number"].toString()));
    token(await getToken(
        "http://159.89.164.125:8080/api/access_token?channelName=${channelId.value}"));
    myContactModel(await getUserContact(parameters["number"] ?? ""));
    fetchMessages();
    connect();
  }

  void connect() {
    socket = IO.io("http://159.89.164.125:4000", <String, dynamic>{
      "transports": ["websocket"],
      "force new connection": true,
      "cookie": false
    });

    socket!.onConnect((_) async {
      isDebugMode.value ? log("CHAT ROOM: SOCKET CONNECTED") : null;
    });
    socket!.on('server-${getRoomID(myContactModel.value.phone ?? '')}', (data) {
      isDebugMode.value
          ? log("CHAT ROOM: MSG RECEIVED \n ${jsonEncode(data)}")
          : null;

      p2pMessageList.add(P2PMessageModel.fromJson(data));
      Future.delayed(const Duration(milliseconds: 400), () {
        chatDetailsRefreshController.animateTo(
            chatDetailsRefreshController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.bounceInOut);
      });
    });
  }

  void sendAMsg(String msg) async {
    if (chatController.text.trim().isNotEmpty) {
      isSendButoonLaoding(true);
      await dioPost(endUrl: "/api/message/send", data: {
        "text": jsonEncode({
          "type": "text",
          "value": msg,
        }),
        "receiverId": myContactModel.value.sId
      }).then((value) {
        if (value.statusCode == 200) {
          socket!.emit("msg", {
            "roomID": getRoomID(myContactModel.value.phone ?? ''),
            "data": value.data["message"]
          });
        }
        Future.delayed(const Duration(milliseconds: 400), () {
          chatDetailsRefreshController.animateTo(
              chatDetailsRefreshController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 200),
              curve: Curves.bounceInOut);
        });
        isSendButoonLaoding(false);
        chatController.clear();
      });
    }
  }

  Future fetchMessages() async {
    var response =
        await dioGet("/api/message/fetch/${myContactModel.value.sId}");
    print(response.data);
    if (response.statusCode == 200) {
      if (P2pChatModel.fromJson(response.data).messages != null) {
        for (var element in P2pChatModel.fromJson(response.data).messages!) {
          p2pMessageList.add(element);
        }
      }
    }
    Future.delayed(const Duration(milliseconds: 400), () {
      chatDetailsRefreshController.animateTo(
          chatDetailsRefreshController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.bounceInOut);
    });
  }
}
