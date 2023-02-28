import 'package:mini_chat/app/data/config/app_cons.dart';

String getRoomID(String opponentNumber) {
  if (int.parse(opponentNumber.replaceAll("+", "")) >
      int.parse(getBox.read(USER_NUMBER))) {
    return "$opponentNumber${getBox.read(USER_NUMBER)}".replaceAll("+", "");
  } else {
    return "${getBox.read(USER_NUMBER)}$opponentNumber".replaceAll("+", "");
  }
}
