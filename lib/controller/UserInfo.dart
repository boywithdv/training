import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

var userId;
var userName;
var userEmail;
var userImage;
var photoURL;

// Shared PreferenceでuserIdを取得する
setPrefItems() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // userIdにuidを入れる
  prefs.setString('uid', userId);
  prefs.setString('userName', userName!);
}

//ログイン後、新規登録後にuserNameを状態管理する
final userNameProvider = StateProvider<String>((ref) {
  return userName;
});


//ユーザIDなどはローカル上に保存するようにプログラムを作成する
