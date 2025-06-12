import 'dart:math';
import 'package:clients/model/users/users.dart';
import 'package:clients/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otp_text_field_v2/otp_field_v2.dart';

class LoginController extends GetxController {

  GetStorage box =GetStorage();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference userCollection;

  TextEditingController registerNameCtrl = TextEditingController();
  TextEditingController registerNumberCtrl = TextEditingController();

  TextEditingController loginNumberCtrl = TextEditingController();
  OtpFieldControllerV2 otpController = OtpFieldControllerV2();

  var otpFieldShow = false.obs; // Reactive state
  int? otpsend;
  int? otpEnter;

  Users? loginuser;


  @override
  void onReady() {
    // TODO: implement onReady
    Map<String,dynamic>? user=box.read('loginuser');
    if(user!=null){
      loginuser=Users.fromJson(user);
      Get.to(HomePage());
    }
    super.onReady();
  }

  @override
  void onInit() {
    userCollection = firestore.collection('users');
    super.onInit();
  }

  void addUser() {
    try {
      if (otpsend == otpEnter) {
        DocumentReference doc = userCollection.doc();
        Users user = Users(
          id: doc.id,
          name: registerNameCtrl.text,
          number: int.parse(registerNumberCtrl.text),
        );

        doc.set(user.toJson());
        Get.snackbar(
            'Success', 'User added successfully', colorText: Colors.green);
        registerNameCtrl.clear();
        registerNumberCtrl.clear();
        otpController.clear();
      } else {
        Get.snackbar('Error', 'OTP is Incorrect', colorText: Colors.red);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print(e);
    }
  }

  sendOTP() async {
    try {
      if (registerNameCtrl.text.isEmpty || registerNumberCtrl.text.isEmpty) {
        Get.snackbar(
            'Error', 'Please fill in all fields', colorText: Colors.red);
        return;
      }
      final random = Random();
      int otp = 1000 + random.nextInt(9000);
      String mobileNumber = registerNumberCtrl.text;
      String url = 'https://www.fast2sms.com/dev/bulkV2?authorization=tqdc4Ri6muwyjNEHBsxWX1T78LaGnk3oQYIheVCvA5DKlPf2Zr6FgDvzUl1SfGPojQENWBX3I2ure97O&route=otp&variables_values=$otp&flash=0&numbers=$mobileNumber&schedule_time=';

      Response response = await GetConnect().get(url);
      print(otp);

      if (response.body['message'][0] == 'SMS sent successfully.') {
        otpsend = otp;
        otpFieldShow.value = true;
        Get.snackbar(
            'Success', 'OTP Sent successfully', colorText: Colors.green);
      } else {
        Get.snackbar('Error', 'OTP Not Sent', colorText: Colors.red);
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    }
  }

  Future<void> loginwithphone() async {
    try {
      String phoneNumber = loginNumberCtrl.text;

      if (phoneNumber.isNotEmpty) {
        // Query Firestore to find a user with the matching phone number
        var querySnapShot = await userCollection
            .where('number', isEqualTo: int.parse(phoneNumber))
            .limit(1)
            .get();

        if (querySnapShot.docs.isNotEmpty) {
          var userDoc = querySnapShot.docs.first;
          var userData = userDoc.data() as Map<String, dynamic>;
          box.write('loginuser', userData);
          loginNumberCtrl.clear();
          Get.to(HomePage());

          // Show success message
          Get.snackbar(
              'Success', 'Login Successfully', colorText: Colors.green);
          print('User Data: $userData');
        } else {
          // No user found
          Get.snackbar(
              'Error', 'User not found, Please Register',
              colorText: Colors.red);
        }
      } else {
        // Phone number not provided
        Get.snackbar('Error', 'Please Enter a Phone Number',
            colorText: Colors.red);
      }
    } catch (error) {
      print("Failed to login: $error");
      Get.snackbar('Error', 'Login failed. Please try again.',
          colorText: Colors.red);
    }
  }
}