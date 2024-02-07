import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training/controller/UserInfo.dart';
import 'package:training/firebase_options.dart';
import 'package:training/view/pages/app.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (prefs.getBool('first_launch') ?? true) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    prefs.setBool('first_launch', false);
  }

  MobileAds.instance.initialize();
  final scope = ProviderScope(child: App());
  runApp(scope);
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return App();
  }
}
