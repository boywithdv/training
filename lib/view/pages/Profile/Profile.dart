import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training/controller/user_info.dart';
import 'package:training/controller/open_web_page.dart';
import 'package:training/components/background_animation.dart';
import 'package:training/view/pages/Profile/circle_avator.dart';
import 'package:training/view/pages/body_registations/body_registration.dart';
import 'package:training/view/pages/profile/unknown_user.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:training/view/services/auth/login_form.dart';

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
    return _auth.currentUser == null
        ? UnknownUser()
        : Scaffold(
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
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            body: ContainerAvator(),
            drawer: SizedBox(
              width: 200,
              height: 470,
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
                        "友達に教える",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        _shareText(
                            context,
                            'おうちで気楽に筋トレをしましょう。気楽に。\n https://apps.apple.com/jp/app/%E3%82%A4%E3%82%A8%E3%83%88%E3%83%AC-home-workout/id6476892667',
                            'イエトレ(Home Fitness)');
                      },
                    ),
                    ListTile(
                      leading: Icon(
                          CupertinoIcons.person_crop_circle_badge_checkmark),
                      title: Text(
                        "問い合わせ",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        final _openWebUrl = OpenWebPage();
                        _openWebUrl.launchUriWithString(context,
                            "https://boywithdv.github.io/InquiryForm/");
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.logout),
                      title: Text(
                        "ログアウト",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
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
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  await _auth.signOut();
                                  if (_auth.currentUser == null) {
                                    prefs.setString('userName', '');
                                    prefs.setString(
                                        "favorite_part_of_training", "");
                                  }
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginForm()));
                                },
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading:
                          Icon(CupertinoIcons.person_crop_circle_badge_minus),
                      title: Text(
                        "アカウント削除",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => CupertinoAlertDialog(
                            title: Text(
                              "Do you want to delete your account?",
                              style: TextStyle(color: Colors.red),
                            ),
                            content: Text(
                              "アカウント削除しますか？",
                              style: TextStyle(color: Colors.red),
                            ),
                            actions: [
                              CupertinoDialogAction(
                                child: Text('いいえ'),
                                onPressed: () {
                                  print(userId);
                                  Navigator.of(context, rootNavigator: true)
                                      .pop(); // キャンセルボタンが押されたらダイアログを閉じる
                                },
                              ),
                              CupertinoDialogAction(
                                child: Text('はい'),
                                isDestructiveAction: true,
                                onPressed: () async {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  if (_auth.currentUser != null) {
                                    FirebaseFirestore.instance
                                        .collection('userId')
                                        .doc(userId)
                                        .delete();
                                    await _auth.currentUser?.delete();
                                    await _auth.signOut();
                                    prefs.setString('userName', '');
                                    prefs.setString(
                                        "favorite_part_of_training", "");
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginForm()));
                                  }
                                },
                              )
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          );
  }

  void _shareText(BuildContext context, String text, String subject) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(text,
        subject: subject,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}
