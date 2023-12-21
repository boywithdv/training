import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training/controller/LoginModel.dart';
import 'package:training/controller/RegisterModel.dart';

var userId;

//ログイン後、新規登録後にuidを状態管理する
final userInfoProvider = StateProvider<String>((ref) {
  return userId;
});
void updateUid(WidgetRef ref) {
  final notifier = ref.read(userInfoProvider.notifier);
  notifier.state = userId;
}
