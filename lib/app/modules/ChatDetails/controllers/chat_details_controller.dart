// ignore_for_file: library_prefixes

// import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as DIO;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_chat/app/data/config/app_color.dart';
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
  var isImage = false.obs;

  final picker = ImagePicker();
  XFile? selectedImage;
  Future getImage() async {
    selectedImage = (await picker.pickImage(source: ImageSource.gallery));

    if (selectedImage != null) {
      Get.defaultDialog(
          title: '',
          content: SafeArea(
            child: SizedBox(
              height: 350.h,
              width: Get.width,
              child: Wrap(
                children: [
                  SizedBox(
                    height: 300.h,
                    width: 450.w,
                    child: Image.file(
                        fit: BoxFit.cover, File(selectedImage!.path)),
                  ),
                  // Row(
                  //   children: [
                  //     TextFormField(
                  //       keyboardType: TextInputType.text,
                  //       textInputAction: TextInputAction.send,
                  //       // controller: chatController1,
                  //       decoration: InputDecoration(
                  //           contentPadding:
                  //               EdgeInsets.symmetric(horizontal: 25.r),
                  //           hintText: "Type here...",
                  //           hintStyle: TextStyle(
                  //               color: AppColor.grey), //Color(0xFF00BFA5)
                  //           border: InputBorder.none),
                  //     ),

                  //   ],
                  // )
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.all(20.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: AppColor.apcolor, shape: BoxShape.circle),
                      child: InkWell(
                        child: sendIcon(),
                        onTap: () {
                          sendAMsg(chatController.text);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ));
    } else {
      SHOW_SNACKBAR(isSuccess: false, message: "Nothing selected");
    }
  }

  Widget sendIcon() {
    return Obx(() => (isSendButoonLaoding.value == false)
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.send_sharp,
              color: Colors.white,
              size: 19.w,
            ),
          )
        : const CircularProgressIndicator());
  }

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
        sendTimeout: const Duration(milliseconds: 100000),
        receiveTimeout: const Duration(milliseconds: 15000),
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
    
    Map<String, Object?> data;
    if (selectedImage != null) {
      // pic = await DIO.MultipartFile.fromFile(
      //     selectedImage!.path,
      //     );

          data = {
            "text": msg,
            "receiverId": myContactModel.value.sId,
            "image": await DIO.MultipartFile.fromFile(selectedImage!.path)
          };
    }
    else{
      data = {
            "text": msg,
            "receiverId": myContactModel.value.sId,
            "image": ""
          };
    }

    isSendButoonLaoding(true);
    DIO.FormData fromData = DIO.FormData.fromMap(data);
    await dioPost(endUrl: "/api/message/send", data: fromData).then((value) {
      if (value.statusCode == 200) {
        socket!.emit("msg", {
          "roomID": getRoomID(myContactModel.value.phone ?? ''),
          "data": value.data["message"]
        });
      }
      Future.delayed(const Duration(milliseconds: 400), () {
        chatDetailsRefreshController.animateTo(
            chatDetailsRefreshController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200000),
            curve: Curves.bounceInOut);
      });
      isSendButoonLaoding(false);
      chatController.clear();
    });
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
