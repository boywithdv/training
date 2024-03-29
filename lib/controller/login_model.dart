import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:training/controller/user_info.dart';

class LoginModel extends ChangeNotifier {
  String mail = '';
  String password = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future login() async {
    if (mail.isEmpty) {
      throw ('メールアドレスを入力してください');
    }
    if (password.isEmpty) {
      throw ('パスワードを入力してください');
    }
    final result = await _auth.signInWithEmailAndPassword(
      email: mail,
      password: password,
    );
    if (result.user != null) {
      favorite_part_of_training =
          prefs.getString("favorite_part_of_training") ?? "";
      userId = result.user!.uid;
      userName = result.user!.displayName;
      userEmail = result.user!.email;
      setPrefItems();
    }
    /**
     * result.userには以下のプロパティがある
     * displayName : ユーザーの名前
     * email : jukiya8891@gmail.com
     * isEmailverified : 
     * isAnonymous : 
     * metadata : 
     */
  }
}
