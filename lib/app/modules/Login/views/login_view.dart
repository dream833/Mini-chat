import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mini_chat/app/data/config/app_color.dart';
import 'package:mini_chat/app/widgets/common_button.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(LoginController());
    return Scaffold(
      backgroundColor: AppColor.apcolor,
      body: SafeArea(
        child: Center(
          child: Container(
            height: 300.h,
            width: 320.w,
            padding: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 20.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: AppColor.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 21.w,
                      color: AppColor.apcolor,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  'Please enter your phone number so that we will send an OTP on it',
                  style: TextStyle(
                      fontSize: 15.r,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                IntlPhoneField(
                  textInputAction: TextInputAction.done,
                  onTap: () {},
                  flagsButtonMargin: EdgeInsets.only(left: 10.r),
                  flagsButtonPadding: EdgeInsets.only(
                    left: 2.r,
                  ),
                  dropdownIconPosition: IconPosition.trailing,
                  dropdownDecoration: const BoxDecoration(),
                  dropdownIcon: const Icon(Icons.arrow_drop_down),
                  controller: controller.phone,
                  onCountryChanged: (country) {
                    controller.countryCode(country.dialCode.toString());
                    controller.countryID(country.code);
                    controller.countryName(country.name);
                  },
                  decoration: InputDecoration(
                    fillColor: AppColor.white,
                    filled: true,
                    hintText: 'Enter Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13.r),
                      borderSide:
                          BorderSide(color: AppColor.black.withOpacity(0.4)),
                    ),
                  ),
                  initialCountryCode: 'IN',
                ),
                SizedBox(
                  height: 1.h,
                ),
                CommonButton(
                    text: "Submit",
                    onTap: () {
                      controller.phoneLogin();
                    },
                    isLoading: controller.isNextButtonLoading),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
