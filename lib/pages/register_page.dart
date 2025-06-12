import 'package:clients/controller/login_controller.dart';
import 'package:clients/pages/login_page.dart';
import 'package:clients/widgets/otp_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final LoginController ctrl = Get.put(LoginController());

    return Scaffold(
      body: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Create Your Account!!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 20),

            // Name TextField
            TextField(
              keyboardType: TextInputType.text,
              controller: ctrl.registerNameCtrl,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.person),
                labelText: 'Your Name',
                hintText: 'Enter your Name',
              ),
            ),
            const SizedBox(height: 20),

            // Mobile Number TextField
            TextField(
              keyboardType: TextInputType.number,
              controller: ctrl.registerNumberCtrl,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.phone_android),
                labelText: 'Mobile Number',
                hintText: 'Enter your mobile Number',
              ),
            ),
            const SizedBox(height: 20),

            // OTP Text Field - Visible only if `otpFieldShow` is true
            Obx(() => Visibility(
              visible: ctrl.otpFieldShow.value,
              child: OtpText(
                otpController: ctrl.otpController,
                visible: ctrl.otpFieldShow.value,
                onComplete: (otp) {
                  ctrl.otpEnter = int.tryParse(otp ?? '0000');
                },
              ),
            )),

            const SizedBox(height: 20),

            // Register Button
            Obx(
                  () => ElevatedButton(
                onPressed: () {
                  ctrl.otpFieldShow.value
                      ? ctrl.addUser()
                      : ctrl.sendOTP(); // Trigger respective action
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepPurple,
                ),
                child: Text(ctrl.otpFieldShow.value ? 'Register' : 'Send OTP'),
              ),
            ),

            // Login Text Button (without background color or button)
            TextButton(
              onPressed: () {
                Get.to(LoginPage()); // Navigate to the login page
              },
              child: const Text('Login'),
              ),

          ],
        ),
      ),
    );
  }
}