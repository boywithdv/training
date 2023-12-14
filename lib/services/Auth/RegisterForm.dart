import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training/components/Circle.dart';
import 'package:training/components/backgroundAnimation.dart';
import 'package:training/components/textfield.dart';
import 'package:training/models/RegisterModel.dart';
import 'package:training/pages/LoginedPage.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterModel>(
      create: (_) => RegisterModel(),
      child: Scaffold(
        body: Consumer<RegisterModel>(builder: (context, model, child) {
          return Stack(
            children: [
              BackgroundAnimation(),
              Center(
                child: Circle(),
              ),
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
                bottom: 415,
                left: 100,
                child: TextFieldForLogin(
                  hinttext: "メールアドレス",
                  pw: false,
                  textController: model.titleController,
                  onChanged: (text) {
                    print(text);
                    model.setEmail(text);
                  },
                ),
              ),
              Positioned(
                bottom: 365,
                left: 100,
                child: TextFieldForLogin(
                  hinttext: "パスワード",
                  pw: true,
                  textController: model.authorController,
                  onChanged: (text) {
                    print(text);
                    model.setPassword(text);
                  },
                ),
              ),
              Positioned(
                bottom: 435,
                left: 70,
                child: Icon(Icons.mail),
              ),
              Positioned(
                left: 70,
                bottom: 385,
                child: Icon(Icons.password),
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
                top: 300,
                left: 100,
                child: Row(
                  children: [
                    Container(
                        child: TextButton(
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_circle_left_outlined,
                            color: Colors.black,
                          ),
                          Text(
                            "ログイン画面に戻る",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )),
                  ],
                ),
              ),
              Positioned(
                top: 500,
                left: 150,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    child: Text("SIGN UP"),
                    onPressed: () async {
                      model.startLoading();
                      try {
                        await model.signUp(context);
                      } catch (e) {
                        final snackBar = SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(e.toString()));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        print(e);
                      } finally {
                        model.endLoading();
                      }
                    },
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
