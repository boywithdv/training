import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training/controller/UserInfo.dart';
import 'package:training/view/components/TextFieldForLogin.dart';
import 'package:training/controller/LoginModel.dart';
import 'package:training/view/pages/LoginedPage.dart';
import 'package:training/view/pages/ScreenWidget.dart';
import 'package:training/view/services/auth/RegisterForm.dart';
import 'package:training/view/services/auth/passwordForgetForm.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _mailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  var _isObscured = true;
  var password = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _mailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                    height: 220,
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
                    height: 250,
                  ),
                  FadeInUp(
                      duration: Duration(milliseconds: 1700),
                      child: Center(
                        child: Container(
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black87,
                            border: Border(),
                          ),
                          child: Column(
                            children: <Widget>[
                              TextFieldForLogin(
                                prefixIcon: Icon(
                                  Icons.mail,
                                  color: Colors.white70,
                                ),
                                onChanged: (text) {
                                  model.mail = text;
                                },
                                textController: _mailController,
                                hinttext: "メールアドレス",
                                pw: false,
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
                                        password = !password;
                                      },
                                    );
                                  },
                                ),
                                prefixIcon: Icon(
                                  Icons.password,
                                  color: Colors.white70,
                                ),
                                onChanged: (text) {
                                  model.password = text;
                                },
                                textController: _passwordController,
                                hinttext: "パスワード",
                                pw: password,
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
                          if (_mailController.text == "") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('メールアドレスが入力されていません。'),
                              ),
                            );
                            return;
                          } else if (_passwordController.text == "") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('パスワードが入力されていません。'),
                              ),
                            );
                            return;
                          }
                          await model.login();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginedPage()),
                          );
                        } on FirebaseAuthException catch (e) {
                          print(e.code);
                          _showDialog(context, 'ログインできません');
                          return;
                        }
                      },
                      color: Color.fromARGB(186, 126, 137, 126),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      height: 50,
                      child: Center(
                        child: Text(
                          "ログイン",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FadeInUp(
                        duration: Duration(milliseconds: 2000),
                        child: Center(
                          child: TextButton(
                            onPressed: () async {
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => PasswordForgetForm()),
                              );
                            },
                            child: Text(
                              "パスワードを忘れた方はこちら",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),
                      ),
                      FadeInUp(
                        duration: Duration(milliseconds: 2000),
                        child: Center(
                          child: TextButton(
                            onPressed: () async {
                              nonRegister();
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => ScreenWidget()),
                              );
                            },
                            child: Text(
                              'アカウントを登録せず使用',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

void _showDialog(BuildContext context, String title) {
  showDialog(
    context: context,
    builder: (BuildContext contxt) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      );
    },
  );
}
