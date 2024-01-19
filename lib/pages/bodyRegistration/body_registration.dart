import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training/components/backgroundAnimation.dart';
import 'package:training/pages/bodyRegistration/body_register_page.dart';

class BodyRegistration extends StatefulWidget {
  const BodyRegistration({super.key});

  @override
  State<BodyRegistration> createState() => _BodyRegistrationState();
}

class _BodyRegistrationState extends State<BodyRegistration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Body',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [BackgroundAnimation(), BodyRegisterPage()],
      ),
    );
  }
}
