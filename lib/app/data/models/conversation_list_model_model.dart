import 'dart:convert';

class ConversationListModel {
  bool? success;
  List<Messages>? messages;

  ConversationListModel({this.success, this.messages});

  ConversationListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages?.add(Messages.fromJson(v));
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

class Messages {
  String? sId;
  MessageModel? text;
  String? sender;
  String? senderName;
  String? receiverNumber;
  String? senderNumber;
  String? senderImage;
  String? receiver;
  String? receiverName;
  String? receiverImage;
  int? date;
  bool? isLastChat;
  int? iV;

  Messages(
      {this.sId,
      this.text,
      this.sender,
      this.senderName,
      this.receiverNumber,
      this.senderNumber,
      this.senderImage,
      this.receiver,
      this.receiverName,
      this.receiverImage,
      this.date,
      this.isLastChat,
      this.iV});

  Messages.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    text = MessageModel.fromJson(jsonDecode(json['text']));
    sender = json['sender'];
    senderName = json['senderName'];
    senderImage = json['senderImage'];
    receiver = json['receiver'];
    senderNumber = json['senderNumber'];
    receiverNumber = json['receiverNumber'];
    receiverName = json['receiverName'];
    receiverImage = json['receiverImage'];
    date = json['date'];
    isLastChat = json['isLastChat'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['text'] = text;
    data['sender'] = sender;
    data['senderName'] = senderName;
    data['senderImage'] = senderImage;
    data['receiver'] = receiver;
    data['receiverName'] = receiverName;
    data['receiverImage'] = receiverImage;
    data['date'] = date;
    data['receiverNumber'] = receiverNumber;
    data['senderNumber'] = senderNumber;
    data['isLastChat'] = isLastChat;
    data['__v'] = iV;
    return data;
  }
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
