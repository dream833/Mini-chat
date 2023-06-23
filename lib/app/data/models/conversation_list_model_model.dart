// To parse this JSON data, do
//
//     final conversationListModel = conversationListModelFromJson(jsonString);

import 'dart:convert';

ConversationListModel conversationListModelFromJson(String str) => ConversationListModel.fromJson(json.decode(str));

String conversationListModelToJson(ConversationListModel data) => json.encode(data.toJson());

class ConversationListModel {
    bool? success;
    List<Message>? messages;

    ConversationListModel({
        this.success,
        this.messages,
    });

    factory ConversationListModel.fromJson(Map<String, dynamic> json) => ConversationListModel(
        success: json["success"],
        messages: json["messages"] == null ? [] : List<Message>.from(json["messages"]!.map((x) => Message.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "messages": messages == null ? [] : List<dynamic>.from(messages!.map((x) => x.toJson())),
    };
}

class Message {
    String? id;
    String? text;
    String? sender;
    String? senderNumber;
    String? senderName;
    String? senderImage;
    String? receiver;
    String? receiverNumber;
    String? receiverName;
    String? receiverImage;
    int? date;
    bool? isLastChat;
    int? v;

    Message({
        this.id,
        this.text,
        this.sender,
        this.senderNumber,
        this.senderName,
        this.senderImage,
        this.receiver,
        this.receiverNumber,
        this.receiverName,
        this.receiverImage,
        this.date,
        this.isLastChat,
        this.v,
    });

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["_id"],
        text: json["text"],
        sender: json["sender"],
        senderNumber: json["senderNumber"],
        senderName: json["senderName"],
        senderImage: json["senderImage"],
        receiver: json["receiver"],
        receiverNumber: json["receiverNumber"],
        receiverName: json["receiverName"],
        receiverImage: json["receiverImage"],
        date: json["date"],
        isLastChat: json["isLastChat"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "text": text,
        "sender": sender,
        "senderNumber": senderNumber,
        "senderName": senderName,
        "senderImage": senderImage,
        "receiver": receiver,
        "receiverNumber": receiverNumber,
        "receiverName": receiverName,
        "receiverImage": receiverImage,
        "date": date,
        "isLastChat": isLastChat,
        "__v": v,
    };
}


class MessageModel {
  String? type;
  String? value;

  MessageModel({this.type, this.value});

  MessageModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['value'] = value;
    return data;
  }
}
