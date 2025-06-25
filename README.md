# 👟 Footwear Client App (Flutter + Firebase)

This is the **Client-Side Application** for a Flutter-based Footwear E-Commerce platform. Customers can **browse, filter, and purchase homemade footwear products**, with real-time data fetched from Firebase, added via the [Footware_Admin](https://github.com/srivasishta/Footware_Admin) panel.

> 🛍️ A complete, smooth shopping experience for users – with secure login, filtered product exploration, and easy checkout!

---

## 🌟 Features

- 🔐 **OTP Login** via Fast2SMS API
- 📦 Real-time Product Sync with Firebase Firestore
- 🏷️ **Brand Filtering** and **Price Sorting**
- 💳 Integrated with **PayPal Payment Gateway**
- 🖼️ Detailed product view with:
  - Name
  - Description
  - Price
  - Discount Status
  - Brand
  - Image
- 🚀 Fast and responsive UI built using Flutter

---

---

## 🔐 OTP Authentication (Fast2SMS)

- Uses Fast2SMS API to verify mobile numbers.
- OTP is sent to user’s phone via SMS.
- OTP verification allows access to the app.

> Make sure to add your API key securely in the OTP service file.

---

## 💳 Payment Gateway (PayPal)

- Integrated using `flutter_paypal_checkout` plugin
- Secure payment redirection to PayPal
- Confirmation of transaction before order placement

---

## 🛠 Firebase Setup

1. Follow Firebase setup instructions from [official docs](https://firebase.flutter.dev/)
2. Use `firebase_options.dart` generated from `flutterfire configure`
3. Ensure Firestore rules are correctly set for public reads or authenticated users

---

