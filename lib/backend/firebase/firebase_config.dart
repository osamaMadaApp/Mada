import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyALFp2rlma2tV4qmpAfndLHYElxjpNdDxs",
            authDomain: "mycar-5128d.firebaseapp.com",
            projectId: "mycar-5128d",
            storageBucket: "mycar-5128d.firebasestorage.app",
            messagingSenderId: "159616523246",
            appId: "1:159616523246:web:1ffbb5e091d120b710ccff",
            measurementId: "G-KW4S20P6MK"));
  } else {
    await Firebase.initializeApp();
  }
}
