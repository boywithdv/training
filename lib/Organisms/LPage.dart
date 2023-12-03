import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:training/components/textfield.dart';

class LPage extends StatefulWidget {
  const LPage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<LPage> {
  String mail = '';
  String password = '';
  //final _auth = FirebaseAuth.instance;
  // TextEditingControllerの作成
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // ウィジェットが破棄されるときにコントローラーも破棄する
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                            onChanged: (newValue) {},
                            textController: _nameController,
                            text: "メールアドレス",
                            pw: false,
                          ),
                          TextFieldForLogin(
                            onChanged: (newValue) {},
                            textController: _passwordController,
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
                      //Logind();
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

/*
  void Logind() async {
    print("this is login");
    try {
      final newUser = await _auth.signInWithEmailAndPassword(
          email: mail, password: password);
      if (newUser != null) {
        Navigator.pushReplacement(
            context,
            //ログインが成功した場合の遷移先
            MaterialPageRoute(builder: (context) => MyWidget()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(''),
          ),
        );
        print('メールアドレスのフォーマットが正しくありません');
      } else if (e.code == 'user-disabled') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('現在指定したメールアドレスは使用できません'),
          ),
        );
        print('現在指定したメールアドレスは使用できません');
      } else if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('指定したメールアドレスは登録されていません'),
          ),
        );
        print('指定したメールアドレスは登録されていません');
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('パスワードが間違っています'),
          ),
        );
        print('パスワードが間違っています');
      }
    }
  }
  */
}
