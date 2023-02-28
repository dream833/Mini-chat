import 'dart:convert';

import 'conversation_list_model_model.dart';

class P2pChatModel {
  bool? success;
  List<P2PMessageModel>? messages;

  P2pChatModel({this.success, this.messages});

  P2pChatModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['messages'] != null) {
      messages = <P2PMessageModel>[];
      json['messages'].forEach((v) {
        messages?.add(P2PMessageModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    if (messages != null) {
      data['messages'] = messages?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class P2PMessageModel {
  String? senderNumber;
  String? receiverNumber;
  String? sId;
  MessageModel? text;
  String? sender;
  String? senderName;
  String? senderImage;
  String? receiver;
  String? receiverName;
  String? receiverImage;
  int? date;
  bool? isLastChat;
  int? iV;

  P2PMessageModel(
      {this.senderNumber,
      this.receiverNumber,
      this.sId,
      this.text,
      this.sender,
      this.senderName,
      this.senderImage,
      this.receiver,
      this.receiverName,
      this.receiverImage,
      this.date,
      this.isLastChat,
      this.iV});

  P2PMessageModel.fromJson(Map<String, dynamic> json) {
    senderNumber = json['senderNumber'];
    receiverNumber = json['receiverNumber'];
    sId = json['_id'];
    text = MessageModel.fromJson(jsonDecode(json['text']));
    sender = json['sender'];
    senderName = json['senderName'];
    senderImage = json['senderImage'];
    receiver = json['receiver'];
    receiverName = json['receiverName'];
    receiverImage = json['receiverImage'];
    date = json['date'];
    isLastChat = json['isLastChat'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['senderNumber'] = senderNumber;
    data['receiverNumber'] = receiverNumber;
    data['_id'] = sId;
    data['text'] = text;
    data['sender'] = sender;
    data['senderName'] = senderName;
    data['senderImage'] = senderImage;
    data['receiver'] = receiver;
    data['receiverName'] = receiverName;
    data['receiverImage'] = receiverImage;
    data['date'] = date;
    data['isLastChat'] = isLastChat;
    data['__v'] = iV;
    return data;
  }
}
