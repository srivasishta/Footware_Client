import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

FirebaseOptions firebaseOptions = Platform.isAndroid ?   const FirebaseOptions(apiKey: '', appId: ', messagingSenderId:'', projectId: ''):
    const FirebaseOptions(apiKey: '', appId: '', messagingSenderId: '', projectId:
    '');
