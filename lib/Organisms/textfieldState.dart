import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training/components/textfield.dart';
import 'package:training/controller/Auth/LoginModel.dart';
import 'package:training/views/Page/RegisterForm.dart';

class LoginPage extends StatelessWidget {
  String mail = '';
  String password = '';
  // TextEditingControllerの作成
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
                    height: 270,
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
                                  color: Colors.black,
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
                                onChanged: (newValue) {
                                  model.setEmail(newValue);
                                },
                                textController: _nameController,
                                hinttext: "メールアドレス",
                                pw: false,
                              ),
                              TextFieldForLogin(
                                onChanged: (newValue) {
                                  model.setPassword(newValue);
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
                        onPressed: () {
                          //Logind();
                        },
                        color: Color.fromRGBO(49, 39, 79, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        height: 50,
                        child: Center(
                            child: TextButton(
                                child: Text(
                                  'ログイン',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  try {
                                    await model.login();
                                    print("ログイン成功");
                                  } catch (e) {
                                    print("エラー" + e.toString());
                                  } finally {
                                    print("finally");
                                  }
                                })),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  FadeInUp(
                      duration: Duration(milliseconds: 2000),
                      child: Center(
                          child: TextButton(
                              onPressed: () async {
                                await Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => RegisterForm()));
                                //このボタンが押下した後に実行される
                                print("create account button");
                              },
                              child: Text(
                                "Create Account",
                                style: TextStyle(
                                    color: Color.fromRGBO(49, 39, 79, .6)),
                              )))),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
