import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training/controller/UserInfo.dart';
import 'package:training/controller/open_web_page.dart';

import 'package:training/view/components/user_null_profile.dart';
import 'package:training/view/pages/Profile/CircleAvator.dart';
import 'package:training/view/components/backgroundAnimation.dart';
import 'package:training/view/pages/app.dart';
import 'package:training/view/pages/bodyRegistration/body_registration.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class MainContents extends StatelessWidget {
  MainContents({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(
      children: [BackgroundAnimation(), Profile()],
    ));
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
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return UserNullProfile();
  }
}
