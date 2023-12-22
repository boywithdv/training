import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training/controller/UserInfo.dart';

class TestEdit extends ConsumerWidget {
  const TestEdit({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _controller = TextEditingController();
    final name = ref.watch(userNameProvider);
    _controller.text = name;

    return Scaffold(
      body: Container(
        child: Center(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Enter your name',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          updateUserName(_controller.text);
          _controller.dispose();
          ref.read(userNameProvider.notifier).state = _controller.text;
          Navigator.pop(context);
        },
        child: Text(" 編集ボタン"),
      ),
    );
  }
}

Future<void> updateUserName(String newUserName) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updateDisplayName(newUserName);
      await user.reload();
    }
  } catch (e) {
    print(e);
  }
}
