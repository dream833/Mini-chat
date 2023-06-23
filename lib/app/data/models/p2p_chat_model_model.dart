// To parse this JSON data, do
//
//     final p2PChatModel = p2PChatModelFromJson(jsonString);

import 'dart:convert';

P2pChatModel p2PChatModelFromJson(String str) => P2pChatModel.fromJson(json.decode(str));

String p2PChatModelToJson(P2pChatModel data) => json.encode(data.toJson());

class P2pChatModel {
    bool? success;
    List<P2PMessageModel>? messages;

    P2pChatModel({
        this.success,
        this.messages,
    });

    factory P2pChatModel.fromJson(Map<String, dynamic> json) => P2pChatModel(
        success: json["success"],
        messages: json["messages"] == null ? [] : List<P2PMessageModel>.from(json["messages"]!.map((x) => P2PMessageModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "messages": messages == null ? [] : List<dynamic>.from(messages!.map((x) => x.toJson())),
    };
}

class P2PMessageModel {
    String? id;
    String? text;
    String? image;
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

    P2PMessageModel({
        this.id,
        this.text,
        this.image,
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

    factory P2PMessageModel.fromJson(Map<String, dynamic> json) => P2PMessageModel(
        id: json["_id"],
        text: json["text"],
        image:json["image"],
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
        "image":image,
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
