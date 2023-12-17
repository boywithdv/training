import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training/components/TextFieldForLogin.dart';
import 'package:training/models/LoginModel.dart';
import 'package:training/pages/LoginedPage.dart';
import 'package:training/services/auth/RegisterForm.dart';

class LoginPage extends StatelessWidget {
  // TextEditingControllerの作成
  TextEditingController _mailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModel>(
      create: (_) => LoginModel(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Consumer<LoginModel>(builder: (context, model, child) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 240,
                  ),
                  FadeInUp(
                      duration: Duration(milliseconds: 1500),
                      child: Center(
                        child: Text(
                          "LOGIN"..toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 27),
                        ),
                      )),
                  SizedBox(
                    height: 200,
                  ),
                  FadeInUp(
                      duration: Duration(milliseconds: 1700),
                      child: Center(
                        child: Container(
                          width: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border(
                                  bottom: BorderSide(
                                      color:
                                          Color.fromRGBO(0, 255, 174, 0.467)))),
                          child: Column(
                            children: <Widget>[
                              TextFieldForLogin(
                                onChanged: (text) {
                                  model.mail = text;
                                },
                                textController: _mailController,
                                hinttext: "メールアドレス",
                                pw: false,
                              ),
                              TextFieldForLogin(
                                onChanged: (text) {
                                  model.password = text;
                                },
                                textController: _passwordController,
                                hinttext: "パスワード",
                                pw: true,
                              )
                            ],
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  FadeInUp(
                      duration: Duration(milliseconds: 1900),
                      child: MaterialButton(
                        onPressed: () async {
                          try {
                            await model.login();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginedPage()),
                            );
                          } catch (e) {
                            print(e);
                            _showDialog(context, e.toString());
                            return;
                          }
                        },
                        color: Color.fromRGBO(49, 39, 79, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        height: 50,
                        child: Center(
                            child: Text(
                          "ログイン",
                          style: TextStyle(color: Colors.white),
                        )),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 2000),
                    child: Center(
                      child: TextButton(
                        onPressed: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => RegisterForm()),
                          );
                        },
                        child: Text(
                          "Create Account",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, String title) {
    showDialog(
        context: context,
        builder: (BuildContext contxt) {
          return AlertDialog(
            title: Text(title),
            actions: [],
          );
        });
  }
}
