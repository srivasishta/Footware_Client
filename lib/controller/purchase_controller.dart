import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart'; // Import PayPal

class PurchaseController extends GetxController {
  TextEditingController addressController = TextEditingController();
  double orderPrice = 0;
  String itemName = '';
  String orderAdress = '';

  // Add your PayPal Client ID and Secret here
  // For a real application, these should be fetched securely (e.g., from an environment variable or backend)
  // and not hardcoded.
  static const String paypalClientId = ''; // Replace with your Sandbox/Live Client ID
  static const String paypalSecretKey = ''; // Replace with your Sandbox/Live Secret

  Future<void> submitOrder({
    required double price,
    required String item,
    required String description,
  }) async {
    orderPrice = price;
    itemName = item;
    orderAdress = addressController.text;

    // Perform validation on address if needed
    if (orderAdress.isEmpty) {
      Get.snackbar('Error', 'Please enter your billing address.');
      return;
    }

    // Initiate PayPal Checkout
    Get.to(
          () => PaypalCheckout(
        sandboxMode: true, // Set to false for production
        clientId: paypalClientId,
        secretKey: paypalSecretKey,
        returnURL: "success.paypal.com", // This can be any valid URL for return
        cancelURL: "cancel.paypal.com", // This can be any valid URL for cancel
        transactions: [
          {
            "amount": {
              "total": price.toStringAsFixed(2), // Ensure price is formatted as string with 2 decimal places
              "currency": "USD", // Or your desired currency, e.g., "INR"
              "details": {
                "subtotal": price.toStringAsFixed(2),
                "shipping": '0', // Adjust if you have shipping costs
                "shipping_discount": 0
              }
            },
            "description": "Payment for $item",
            "item_list": {
              "items": [
                {
                  "name": item,
                  "quantity": 1,
                  "price": price.toStringAsFixed(2),
                  "currency": "USD" // Or your desired currency
                }
              ],
            }
          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          print("onSuccess: $params");
          // Handle successful payment
          Get.snackbar('Success', 'Payment successful!');
          // You might want to navigate to an order confirmation page
          // or update your order status in a backend.
        },
        onError: (error) {
          print("onError: $error");
          // Handle payment error
          Get.snackbar('Error', 'Payment failed: $error');
        },
        onCancel: () {
          print('canceled');
          // Handle payment cancellation
          Get.snackbar('Cancelled', 'Payment cancelled by user.');
        },
      ),
    );
  }
}