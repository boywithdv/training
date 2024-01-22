import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training/components/Circle.dart';
import 'package:training/components/TextFieldForLogin.dart';
import 'package:training/components/backgroundAnimation.dart';
import 'package:training/controller/LoginModel.dart';
import 'package:training/controller/PwResetModel.dart';

class PasswordForgetForm extends StatefulWidget {
  const PasswordForgetForm({super.key});

  @override
  State<PasswordForgetForm> createState() => _PasswordForgetFormState();
}

class _PasswordForgetFormState extends State<PasswordForgetForm> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [BackgroundAnimation(), Circle(), PasswordResetForm()],
    );
  }
}

class PasswordResetForm extends StatefulWidget {
  const PasswordResetForm({super.key});

  @override
  State<PasswordResetForm> createState() => _PasswordResetFormState();
}

class _PasswordResetFormState extends State<PasswordResetForm> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider<PwResetModel>(
      create: (_) => PwResetModel(),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Consumer<PwResetModel>(
            builder: (context, model, child) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    top: deviceHeight * 0.36,
                    child: Row(
                      children: [
                        SizedBox(
                          width: deviceWidth * 0.26,
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
                    ),
                  ),
                  Positioned(
                      top: deviceHeight * 0.42,
                      left: deviceWidth * 0.2,
                      child: Container(
                        child: Text(
                          "メールアドレスを入力してください",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )),
                  Positioned(
                    top: deviceHeight * 0.46,
                    left: deviceWidth * 0.12,
                    child: Container(
                      width: 300,
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black87,
                          border: Border(
                              bottom: BorderSide(
                                  color: Color.fromRGBO(0, 255, 174, 0.467)))),
                      child: TextFieldForLogin(
                        prefixIcon: Icon(
                          Icons.mail,
                          color: Colors.white70,
                        ),
                        onChanged: (text) {
                          model.setEmail(text);
                        },
                        textController: model.mailController,
                        hinttext: "メールアドレス",
                        pw: false,
                      ),
                    ),
                  ),
                  Positioned(
                    top: deviceHeight * 0.6,
                    left: deviceWidth * 0.39,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(186, 126, 137, 126),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          if (model.mailController.text == "") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('メールアドレスが入力されていません。'),
                              ),
                            );
                          }
                          try {
                            await model.passwordReset();
                          } on FirebaseAuthException catch (e) {
                            print(e.code);
                          }
                        },
                        child: Text(
                          "SUBMIT",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          )),
    );
  }
}
