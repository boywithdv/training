import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training/components/ProfileComponents/CircleAvator.dart';
import 'package:training/components/backgroundAnimation.dart';
import 'package:training/main.dart';
import 'package:training/pages/app.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
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
        body: ContainerAvator());
  }
}
