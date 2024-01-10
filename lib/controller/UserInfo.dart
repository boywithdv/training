import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

var userId;
var userName;
var userEmail;
var userImage;
var photoURL;
var favorite_part_of_training;

// Shared PreferenceでuserIdを取得する
setPrefItems() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // userIdにuidを入れる
  prefs.setString('uid', userId);
  prefs.setString('userName', userName);
  prefs.setString('userEmail', userEmail);
  print("これはLoginModel.dartファイルです" + userName);
}

//ユーザネーム更新
void updateDisplayName(String displayName) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await user.updateDisplayName(displayName);
      user = FirebaseAuth.instance.currentUser; // 更新後のユーザー情報を再度取得

      print("DisplayName updated: ${user?.displayName}");
    } else {
      print("User not signed in.");
    }
  } catch (e) {
    print("Error updating DisplayName: $e");
  }
}

//ユーザIDなどはローカル上に保存するようにプログラムを作成する
