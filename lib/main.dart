// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/firebase_options.dart';
import 'package:grocery_app/screens/login_screen.dart';
import 'package:grocery_app/services/auth_service.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // runApp( GroceryApp());
    try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(GroceryApp());
  } catch (e) {
    runApp(MaterialApp(home: Scaffold(body: Center(child: Text('Firebase init failed: $e')))));
    print(e);
  }
}

class GroceryApp extends StatelessWidget {
  //  GroceryApp({super.key});
   final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
      title: 'Grocery App',
      home: LoginScreen(auth: auth,),
    );
  }
}