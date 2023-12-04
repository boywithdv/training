import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training/components/backgroundAnimation.dart';
import 'package:training/components/textfield.dart';
import 'package:training/controller/Auth/RegisterModel.dart';

class RegisterPageless extends StatelessWidget {
  final _mailController = TextEditingController();
  final _pwController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterModel>(
      create: (_) => RegisterModel(),
      child: Scaffold(
        body: Center(
          child: Consumer<RegisterModel>(builder: (context, model, child) {
            return Stack(
              children: [
                BackgroundAnimation(),
                Center(
                  child: Container(
                    height: 100,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(166, 1, 198, 109),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 456,
                  left: 100,
                  child: TextFieldForLogin(
                    hinttext: "メールアドレス",
                    pw: false,
                    textController: _mailController,
                    onChanged: (newValue) {},
                  ),
                ),
                Positioned(
                  bottom: 410,
                  left: 100,
                  child: TextFieldForLogin(
                    hinttext: "パスワード",
                    pw: true,
                    textController: _pwController,
                    onChanged: (newValue) {},
                  ),
                ),
                Positioned(
                  bottom: 476,
                  left: 70,
                  child: Icon(Icons.mail),
                ),
                Positioned(
                  left: 70,
                  bottom: 430,
                  child: Icon(Icons.password),
                ),
                Center(
                  child: Divider(
                    indent: 22,
                    endIndent: 22,
                    thickness: 1,
                    color: Colors.white70,
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
