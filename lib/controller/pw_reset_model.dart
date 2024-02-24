import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PwResetModel extends ChangeNotifier {
  final mailController = TextEditingController();
  String? email;
  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  Future passwordReset() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: mailController.text);
  }
}
