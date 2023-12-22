import 'package:flutter_riverpod/flutter_riverpod.dart';

var userId;
var userName;
var userEmail;
var userImage;
var photoURL;

//ログイン後、新規登録後にuidを状態管理する
final userInfoProvider = StateProvider<String>((ref) {
  return userId;
});
void updateUid(WidgetRef ref) {
  final notifier = ref.read(userInfoProvider.notifier);
  notifier.state = userId;
}

//ログイン後、新規登録後にuserNameを状態管理する
final userNameProvider = StateProvider<String>((ref) {
  return userName;
});
void updateUserName(WidgetRef ref) {
  final notifier = ref.read(userNameProvider.notifier);
  notifier.state = userName;
}

//ログアウトボタンを押下されたときの処理
final userLogout = StateProvider<bool>((ref) {
  return false;
});
void updateLogout(WidgetRef ref) {
  final notifieruid = ref.read(userInfoProvider.notifier);
  final notifiername = ref.read(userNameProvider.notifier);
  final notifierlogout = ref.read(userLogout.notifier);
  notifieruid.state = '';
  notifiername.state = '';
  notifierlogout.state = true;
}
