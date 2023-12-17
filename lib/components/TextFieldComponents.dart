import 'package:flutter/material.dart';
import 'package:training/components/TextFieldForLogin.dart';

class TextFieldComponents extends StatelessWidget {
  final TextEditingController mailController;
  final TextEditingController passwordController;
  final Function(String) onChangedMail;
  final Function(String) onChangedPassword;
  final Function() onSignUP;
  const TextFieldComponents(
      {super.key,
      required this.mailController,
      required this.passwordController,
      required this.onChangedMail,
      required this.onChangedPassword,
      required this.onSignUP});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    double sizedBoxWidth = deviceWidth * 0.1;
    double sizedBoxHeight = deviceHeight * 0.6;
    return Stack(
      children: [
        Center(
          child: Container(
            height: 140,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(166, 1, 198, 109),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: sizedBoxWidth,
                    ),
                    Icon(Icons.mail),
                    TextFieldForLogin(
                        hinttext: "メールアドレス",
                        pw: false,
                        textController: mailController,
                        onChanged: onChangedMail),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: sizedBoxWidth,
                    ),
                    Icon(Icons.password),
                    TextFieldForLogin(
                      hinttext: "パスワード",
                      pw: true,
                      textController: passwordController,
                      onChanged: onChangedPassword,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Center(
          child: Divider(
            indent: 22,
            endIndent: 22,
            thickness: 1,
            color: Colors.white70,
          ),
        ),
        Align(
            child: Column(
          children: [
            SizedBox(
              height: sizedBoxHeight,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: TextButton(child: Text("SIGN UP"), onPressed: onSignUP),
            ),
          ],
        )),
      ],
    );
  }
}
