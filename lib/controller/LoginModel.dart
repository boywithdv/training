import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:training/controller/UserInfo.dart';

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
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: mail,
        password: password,
      );
      userId = result.user!.uid;
      userName = result.user!.displayName;
      setPrefItems();

      // TODO 端末に保存
    } on FirebaseAuthException catch (error) {
      if (error.code == "wrong-password") {
        print("パスワードが間違っている");
      }
      if (error.code == "too-many-requests") {
        print("もう認証の上限に達しました。");
        print("時間が経ちましたら再度ログインを行なってください");
      }
      print(error.code);
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
