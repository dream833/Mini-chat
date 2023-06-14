import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';
import 'package:mini_chat/app/data/config/app_cons.dart';
import 'package:mini_chat/app/data/functions/dio_send.dart';
import 'package:mini_chat/app/data/models/multi_number_checker_model_model.dart';

class ContactsPageController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getContacts();
    multiNumberCheckerModel(
        MultiNumberCheckerModel.fromJson(getBox.read(USER_CONTACTS) ?? {}));
  }

  var myContacts = <Contact>[].obs;
  var myContactsNumbers = <String>[].obs;
  var multiNumberCheckerModel = MultiNumberCheckerModel().obs;
  var isContactsPageLoading = false.obs;

  Future<MultiNumberCheckerModel> getContacts() async {
    isContactsPageLoading(true);
    myContacts(await ContactsService.getContacts(withThumbnails: false));
    myContactsNumbers.clear();
    for (var element in myContacts) {
      if (element.phones != null) {
        for (var element in element.phones!) {
          if (element.value != null) {
            myContactsNumbers.add(element.value!.replaceAll(" ", ""));
          }
        }
      }
    }

    await dioPost(
      endUrl: "/api/user/searchnumbers",
      data: {"phoneNumbers": myContactsNumbers},
    ).then((response) {
      isContactsPageLoading(false);

      if (response.statusCode == 200) {
        getBox.write(USER_CONTACTS, response.data);
        multiNumberCheckerModel(
            MultiNumberCheckerModel.fromJson(response.data));
      } else {}
    });
    return multiNumberCheckerModel.value;
  }
}
