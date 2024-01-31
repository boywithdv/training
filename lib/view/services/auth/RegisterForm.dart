import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training/components/TextFieldForLogin.dart';
import 'package:training/components/backgroundAnimation.dart';
import 'package:training/controller/RegisterModel.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  var _isObscured = true;
  var _password = true;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    double sizedBoxWidth = deviceWidth * 0.26;
    double sizedBoxHeight = deviceHeight * 0.35;
    double _sizedBoxWidth = deviceWidth * 0.1;
    double _sizedBoxHeight = deviceHeight * 0.6;
    return ChangeNotifierProvider<RegisterModel>(
      create: (_) => RegisterModel(),
      child: Scaffold(
        body: Consumer<RegisterModel>(
          builder: (context, model, child) {
            return Stack(
              children: [
                BackgroundAnimation(),
                Center(
                  child: Container(
                    height: 140,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black87,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: _sizedBoxWidth,
                            ),
                            TextFieldForLogin(
                              prefixIcon: Icon(
                                Icons.mail,
                                color: Colors.white70,
                              ),
                              hinttext: "メールアドレス",
                              pw: false,
                              textController: model.titleController,
                              onChanged: (text) {
                                print(text);
                                model.setEmail(text);
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: _sizedBoxWidth,
                            ),
                            TextFieldForLogin(
                              suffixIcon: IconButton(
                                icon: _isObscured
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off),
                                onPressed: () {
                                  setState(
                                    () {
                                      _isObscured = !_isObscured;
                                      _password = !_password;
                                    },
                                  );
                                },
                              ),
                              prefixIcon: Icon(
                                Icons.password_rounded,
                                color: Colors.white70,
                              ),
                              hinttext: "パスワード",
                              pw: _password,
                              textController: model.authorController,
                              onChanged: (text) {
                                print(text);
                                model.setPassword(text);
                              },
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
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(186, 126, 137, 126),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          onPressed: () async {
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
                                    content:
                                        Text('指定したメールアドレス・パスワードは現在使用できません'),
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
                            }
                          },
                          child: Text(
                            "サインアップ",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_circle_left_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "ログイン画面に戻る",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
