import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training/components/Circle.dart';
import 'package:training/components/TextFieldComponents.dart';
import 'package:training/components/backgroundAnimation.dart';
import 'package:training/components/menuBarComponents/ThemeColor.dart';
import 'package:training/controller/RegisterModel.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    double sizedBoxWidth = deviceWidth * 0.26;
    double sizedBoxHeight = deviceHeight * 0.35;
    return ChangeNotifierProvider<RegisterModel>(
      create: (_) => RegisterModel(),
      child: Scaffold(
        body: Consumer<RegisterModel>(builder: (context, model, child) {
          return Stack(
            children: [
              BackgroundAnimation(),
              Circle(),
              TextFieldComponents(
                mailController: model.titleController,
                passwordController: model.authorController,
                onChangedMail: (String) {
                  (text) {
                    print(text);
                    model.setEmail(text);
                  };
                },
                onChangedPassword: (String) {
                  (text) {
                    print(text);
                    model.setPassword(text);
                  };
                },
                onSignUP: () async {
                  model.startLoading();
                  try {
                    await model.signUp(context);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'email-already-in-use') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('指定したメールアドレスは登録済みです'),
                        ),
                      );
                      print('指定したメールアドレスは登録済みです');
                    } else if (e.code == 'invalid-email') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('メールアドレスのフォーマットが正しくありません'),
                        ),
                      );
                      print('メールアドレスのフォーマットが正しくありません');
                    } else if (e.code == 'operation-not-allowed') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('指定したメールアドレス・パスワードは現在使用できません'),
                        ),
                      );
                      print('指定したメールアドレス・パスワードは現在使用できません');
                    } else if (e.code == 'weak-password') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('パスワードは６文字以上にしてください'),
                        ),
                      );
                      print('パスワードは６文字以上にしてください');
                    }
                  } finally {}
                },
              ),
              Column(
                children: [
                  SizedBox(height: sizedBoxHeight),
                  Row(
                    children: [
                      SizedBox(
                        width: sizedBoxWidth,
                      ),
                      Container(
                        child: TextButton(
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_circle_left_outlined,
                                color: Colors.white,
                              ),
                              Text(
                                "ログイン画面に戻る",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          );
        }),
      ),
    );
  }
}
