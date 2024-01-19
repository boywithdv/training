import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training/pages/Profile/CircleAvator.dart';
import 'package:training/components/backgroundAnimation.dart';
import 'package:training/main.dart';
import 'package:training/pages/app.dart';
import 'package:training/pages/bodyRegistration/body_registration.dart';

class MainContents extends StatelessWidget {
  MainContents({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [BackgroundAnimation(), Profile()],
    );
  }
}

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                await _auth.signOut();
                if (_auth.currentUser == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('ログアウトしました'),
                    ),
                  );
                  prefs.setString('userName', '');
                  print('ログアウトしました！');
                }
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => App()));
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
                  leading: Icon(Icons.directions_run),
                  title: Text(
                    "歩数",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.fitness_center_sharp),
                  title: Text(
                    "筋トレ記録",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text(
                    "通知設定",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
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
              ],
            ),
          ),
        ));
  }
}
