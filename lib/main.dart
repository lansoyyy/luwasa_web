import 'package:firebase_core/firebase_core.dart';
import 'package:luwasa_web/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:luwasa_web/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDDC44TmNk1_SuHhdKZYN_yHECKMQmCLMc",
          authDomain: "luwasa-ae518.firebaseapp.com",
          projectId: "luwasa-ae518",
          storageBucket: "luwasa-ae518.appspot.com",
          messagingSenderId: "1020320193869",
          appId: "1:1020320193869:web:2932bae84430bf55a32b04"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
