import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:training_app/ui/root_page/root_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const DearDiaryApp());
}
