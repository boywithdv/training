import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

    // todo
    final result = await _auth.signInWithEmailAndPassword(
      email: mail,
      password: password,
    );
    final uid = result.user!.uid;
    // TODO 端末に保存
    print(result.user);
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
