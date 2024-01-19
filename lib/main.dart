import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training/firebase_options.dart';
import 'package:training/pages/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:training/pages/test.dart';

var prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final scope = ProviderScope(child: App());
  runApp(scope);
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return NotificationPage();
  }
}
