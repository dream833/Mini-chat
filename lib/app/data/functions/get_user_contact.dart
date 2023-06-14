import '../models/multi_number_checker_model_model.dart';
import 'dio_send.dart';

Future<MyContactModel> getUserContact(String number) async {
  var myContactModel = MyContactModel();
  var response = await dioPost(endUrl: "/api/user/searchnumbers", data: {
    "phoneNumbers": [number]
  });

  if (response.statusCode == 200) {
    if (MultiNumberCheckerModel.fromJson(response.data).message != null &&
        MultiNumberCheckerModel.fromJson(response.data).message!.isNotEmpty) {
      myContactModel =
          MultiNumberCheckerModel.fromJson(response.data).message!.first;
    }
  } else {}

  return myContactModel;
}
