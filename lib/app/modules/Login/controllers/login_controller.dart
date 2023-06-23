import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mini_chat/app/data/functions/dio_send.dart';
import 'package:mini_chat/app/routes/app_pages.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../../../data/config/app_color.dart';
import '../../../data/config/app_cons.dart';

class LoginController extends GetxController {
  var phone = TextEditingController();
  var countryName = "India".obs;
  var countryID = "IN".obs;
  var countryCode = "91".obs;
  var isNextButtonLoading = false.obs;
  var istDialogButtonLoading = false.obs;
  var phoneAuth = FirebaseAuth.instance;
  var myOTP = "";
  var verrifyID = "";

  void phoneLogin() async {
    if (phone.text.length < 7) {
      SHOW_SNACKBAR(message: "Invalid Phone Number", isSuccess: false);
    } else {
      isNextButtonLoading(true);
      // await phoneAuth.verifyPhoneNumber(
      //   phoneNumber: "+${countryCode.value}${phone.text.trim()}",
      //   verificationCompleted: (PhoneAuthCredential credential) {},
      //   verificationFailed: (FirebaseAuthException expection) {
      //     isNextButtonLoading(false);
      //     SHOW_SNACKBAR(
      //       message: expection.message ?? "Verification Failed",
      //       isSuccess: false,
      //     );
      //   },
      //   codeSent: (String verificationID, int? resendToken) async {
      //     isNextButtonLoading(false);
      //     verrifyID = verificationID;
      //     SHOW_SNACKBAR(message: "OTP sent to your mobile number");
          showOTPSubmitDialog();
      //   },
      //   timeout: const Duration(seconds: 60),
      //   codeAutoRetrievalTimeout: (String verificationID) {},
      // );
    }
  }

  void showOTPSubmitDialog() {
    Get.defaultDialog(
      titleStyle: TextStyle(
        color: AppColor.apcolor,
        fontWeight: FontWeight.bold,
      ),
      title: "Verification",
      backgroundColor: Colors.white,
      content: Column(
        children: [
          OTPTextField(
            length: 6,
            width: Get.width - 45,
            outlineBorderRadius: 10,
            fieldWidth: ((Get.width) / 8.7) - 2,
            otpFieldStyle: OtpFieldStyle(
              backgroundColor: Colors.grey.shade50,
              enabledBorderColor: Colors.blueGrey.shade200,
              borderColor: Colors.purple.shade300,
              focusBorderColor: Colors.purple.shade800,
            ),
            style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xff003a00)),
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldStyle: FieldStyle.box,
            onChanged: (pin) {
              myOTP = pin;
            },
            spaceBetween: 3,
            contentPadding: EdgeInsets.symmetric(horizontal: 4.r),
            onCompleted: (pin) {
              if (pin.length == 6) {
                verifyOTP(pin);
              } else {
                SHOW_SNACKBAR(
                    message: "Your Entered OTP is Invalid", isSuccess: false);
              }
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 10.sp),
            child: Center(
              child: Container(
                width: 250.w,
                decoration: BoxDecoration(
                  color: AppColor.apcolor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Obx(
                  () => MaterialButton(
                    minWidth: 100.w,
                    onPressed: () {
                      verifyOTP(myOTP);
                    },
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28.r),
                        borderSide: BorderSide(color: AppColor.apcolor)),
                    child: istDialogButtonLoading.value
                        ? const CircularProgressIndicator()
                        : Text(
                            'Verify',
                            style: TextStyle(
                                color: AppColor.white,
                                fontSize: 18.r,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      titlePadding: const EdgeInsets.all(16),
      contentPadding: const EdgeInsets.all(16),
    );
  }

  void verifyOTP(String otp) async {
    istDialogButtonLoading(true);
    try {
      // var credential = PhoneAuthProvider.credential(
      //   verificationId: verrifyID,
      //   smsCode: otp,
      // );
      // await phoneAuth.signInWithCredential(credential).then((value) async {
        
        if (otp=="123456") {
          var response = await dioPost(
            data: {"phone": "+${countryCode.value}${phone.text.trim()}"},
            endUrl: "/api/user/login",
          );
          
          if (response.statusCode == 200) {
            istDialogButtonLoading(false);
            getBox.write(USER_NUMBER, "+$countryCode${phone.text}");
            getBox.write(IS_USER_LOGGED_IN, true);
            getBox.write(USER_TOKEN, response.data["message"]);
            SHOW_SNACKBAR(message: "Number is verified");
            Get.offAllNamed(Routes.HOME);
          }
           
        } else {
            istDialogButtonLoading(false);
          SHOW_SNACKBAR(message: "Login failed");
        }
      }
    // } on FirebaseException catch (e) {
    
    //   SHOW_SNACKBAR(message: e.message, isSuccess: false);
    // }
    catch (e) {
        istDialogButtonLoading(false);
         SHOW_SNACKBAR(message: e.toString(), isSuccess: false);   
          }
  }
}
