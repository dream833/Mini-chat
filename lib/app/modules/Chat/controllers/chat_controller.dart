import 'dart:async';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../data/functions/dio_get.dart';
import '../../../data/models/conversation_list_model_model.dart';

class ChatController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getConversations();
    getConversationListEvery5Sec();
  }

  var conversationListModel = ConversationListModel().obs;
  var chatRefreshController = RefreshController(initialRefresh: false);
  var isChatPageLoading = false.obs;

  void onRefresh() async {
    await getConversations();
    chatRefreshController.refreshCompleted();
  }

  void getConversationListEvery5Sec() async {
    Timer.periodic(
      const Duration(seconds: 4),
      ((timer) {
        getConversations();
      }),
    );
  }

  Future getConversations() async {
    isChatPageLoading(true);
    var response = await dioGet("/api/message/fetchall");
    isChatPageLoading(false);
    if (response.statusCode == 200) {
      conversationListModel(ConversationListModel.fromJson(response.data));
    }
    return;
  }
}
