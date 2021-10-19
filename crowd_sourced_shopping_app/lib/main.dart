import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:crowd_sourced_shopping_app/screens/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}
