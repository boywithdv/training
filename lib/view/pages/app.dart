import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:training/controller/UserInfo.dart';
import 'package:training/view/pages/ScreenWidget.dart';
import 'package:training/view/services/auth/LoginForm.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            final math = prefs.getInt("unknouwn");
            if (snapshot.connectionState == ConnectionState.waiting) {
              // スプラッシュ画面などに書き換えても良い
              return const SizedBox();
            }
            if (snapshot.hasData) {
              // User が null でなない、つまりサインイン済みのホーム画面へ
              return ScreenWidget();
            } else if (snapshot.data == null && math == 1) {
              userId = "";
              return ScreenWidget();
            }
            userId = "";

            // User が null である、つまり未サインインのサインイン画面へ
            return LoginForm();
          },
        ),
      );
}
