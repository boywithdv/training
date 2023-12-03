import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:training/components/textfield.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
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
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 27),
                    ),
                  )),
              SizedBox(
                height: 260,
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
                                  color: Color.fromRGBO(0, 255, 174, 0.467)))),
                      child: Column(
                        children: <Widget>[
                          TextFieldForLogin(
                            text: "ユーザ名",
                            pw: false,
                          ),
                          TextFieldForLogin(
                            text: "パスワード",
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
                      print("this is ログインボタン");
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
                      ),
                    ),
                  )),
              SizedBox(
                height: 30,
              ),
              FadeInUp(
                  duration: Duration(milliseconds: 2000),
                  child: Center(
                      child: TextButton(
                          onPressed: () {
                            print("create account button");
                          },
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                                color: Color.fromRGBO(49, 39, 79, .6)),
                          )))),
            ],
          ),
        ));
  }
}
