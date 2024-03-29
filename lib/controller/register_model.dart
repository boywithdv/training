import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:training/controller/user_info.dart';
import 'package:training/view/pages/logined_page.dart';

class RegisterModel extends ChangeNotifier {
  final titleController = TextEditingController();
  final authorController = TextEditingController();

  String? email;
  String? password;

  bool isLoading = false;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future signUp(BuildContext context) async {
    this.email = titleController.text;
    this.password = authorController.text;
    if (email != null && password != null) {
      // firebase authでユーザー作成
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      //作成したuserCredentialからuserを取得する
      final user = userCredential.user;
      //uidの取得をする
      if (user != null) {
        userId = user.uid;
        updateDisplayName('yourName');
        userName = 'yourName';
        userEmail = user.email;

        setPrefItems();
        // firestoreに追加
        final doc = FirebaseFirestore.instance.collection('userId').doc(userId);
        print(userId);

        //登録時に成功したら画面遷移
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginedPage()),
        );
        //PWはfireStoreに入れてはいけない
        await doc.set(
          {
            'uid': userId,
            'email': email,
          },
        );
      }
    }
  }
}

//

