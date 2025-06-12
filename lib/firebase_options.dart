import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

FirebaseOptions firebaseOptions = Platform.isAndroid ?   const FirebaseOptions(apiKey: 'AIzaSyCVCcIS-SeNq3jxWYndA8JRUYw4lbBzLVg', appId: '1:81784542920:android:55e7319a9378ab56d137fd', messagingSenderId:'81784542920', projectId: 'rapid-project-a7ffb'):
    const FirebaseOptions(apiKey: 'AIzaSyCVCcIS-SeNq3jxWYndA8JRUYw4lbBzLVg', appId: 'com.example.footware', messagingSenderId: '81784542920', projectId:
    '1:81784542920:ios:c0104b1e9e43a222d137fd');