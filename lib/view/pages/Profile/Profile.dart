import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training/view/pages/Profile/CircleAvator.dart';
import 'package:training/components/backgroundAnimation.dart';
import 'package:training/main.dart';
import 'package:training/view/pages/app.dart';
import 'package:training/view/pages/bodyRegistration/body_registration.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class MainContents extends StatelessWidget {
  MainContents({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [BackgroundAnimation(), Profile()],
    );
  }
}

class Profile extends StatelessWidget {
  Profile({super.key});
  final _auth = FirebaseAuth.instance;
  var userEmail = prefs.getString('userEmail') ?? "";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.settings,
            color: Colors.white,
          ),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          userEmail,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => CupertinoAlertDialog(
                  title: Text("Do you want to log out?"),
                  content: Text("ログアウトしますか?"),
                  actions: [
                    CupertinoDialogAction(
                      child: Text('Cancel'),
                      isDestructiveAction: true,
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true)
                            .pop(); // キャンセルボタンが押されたらダイアログを閉じる
                      },
                    ),
                    CupertinoDialogAction(
                      child: Text('OK'),
                      onPressed: () async {
                        Navigator.of(context, rootNavigator: true).pop();
                        await _auth.signOut();
                        if (_auth.currentUser == null) {
                          prefs.setString('userName', '');
                          prefs.setString("favorite_part_of_training", "");
                        }
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => App()));
                      },
                    )
                  ],
                ),
              );
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ContainerAvator(),
      drawer: SizedBox(
        width: 190,
        height: 400,
        child: Drawer(
          backgroundColor: Colors.black87,
          child: ListView(
            children: [
              SizedBox(
                height: 60,
                child: DrawerHeader(
                  child: Text(
                    "MENU",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text(
                  "通知設定",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  openAppSettings();
                },
              ),
              ListTile(
                leading: Icon(Icons.accessibility),
                title: Text(
                  "体型登録",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              BodyRegistration()));
                },
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text(
                  "共有",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Share.share('シェアしたい文', subject: 'Flutterシェア機能');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}