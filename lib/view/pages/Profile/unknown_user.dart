import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:training/components/backgroundAnimation.dart';
import 'package:training/components/imageContainer.dart';
import 'package:training/controller/UserInfo.dart';
import 'package:training/controller/open_web_page.dart';
import 'package:training/models/Data/app_colors.dart';
import 'package:training/view/services/auth/LoginForm.dart';
import 'package:training/view/services/auth/RegisterForm.dart';

class UnknownUser extends StatefulWidget {
  const UnknownUser({super.key});

  @override
  State<UnknownUser> createState() => _UnknownUserState();
}

class _UnknownUserState extends State<UnknownUser> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [BackgroundAnimation(), UnknownUserView()],
    );
  }
}

class UnknownUserView extends StatefulWidget {
  const UnknownUserView({super.key});

  @override
  State<UnknownUserView> createState() => _UnknownUserViewState();
}

class _UnknownUserViewState extends State<UnknownUserView> {
  var userEmail = prefs.getString('userEmail') ?? "";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final user = FirebaseAuth.instance.currentUser;
  late final PageController _pageController;
  int pageNo = 0;
  late final Timer _timer;
  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 1), (timer) {
      if (pageNo == 3) {
        pageNo = 0;
      }
      _pageController.animateToPage(pageNo,
          duration: const Duration(seconds: 1), curve: Curves.easeInOutCirc);
      pageNo++;
    });
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 0, viewportFraction: 0.85);
    _timer = getTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double circlewidth = screenWidth * 0.43;
    double circleheight = screenHeight * 0.86;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'プロフィール',
          style: TextStyle(color: Colors.white),
        ),
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
      ),
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              pageNo = index;
              setState(() {
                if (pageNo == 4) {
                  pageNo = 0;
                }
              });
            },
            itemBuilder: (_, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  return child!;
                },
                child: getPageContainer(index),
              );
            },
            itemCount: 3,
          ),
          Positioned(
            top: circleheight * 0.8,
            left: circlewidth,
            child: Row(
              children: List.generate(
                3,
                (index) => Container(
                  margin: EdgeInsets.all(3.0),
                  child: Icon(
                    Icons.circle,
                    size: 12.0,
                    color: pageNo == index
                        ? AppColors.contentColorCyan
                        : AppColors.borderColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.black87,
        child: ListView(
          children: [
            SizedBox(
              height: 60,
              child: DrawerHeader(
                child: Center(
                  child: Text(
                    "-MENU-",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(CupertinoIcons.person),
              title: Text(
                "アカウント登録",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => RegisterForm(),
                  ),
                );
              },
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
              leading: Icon(Icons.share),
              title: Text(
                "友達に教える",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Share.share(
                    'おうちで気楽に筋トレをしましょう。気楽に。\n https://apps.apple.com/jp/app/%E3%82%A4%E3%82%A8%E3%83%88%E3%83%AC-home-workout/id6476892667',
                    subject: 'イエトレ(Home Fitness)');
              },
            ),
            ListTile(
              leading: Icon(CupertinoIcons.person_crop_circle_badge_checkmark),
              title: Text(
                "問い合わせ",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                final _openWebUrl = OpenWebPage();
                _openWebUrl.launchUriWithString(
                    context, "https://boywithdv.github.io/InquiryForm/");
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                "ログイン画面に戻る",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                setUnknounUserPrefsLogin();
                showDialog(
                  context: context,
                  builder: (_) => CupertinoAlertDialog(
                    title:
                        Text("Would you like to return to the login screen?"),
                    content: Text("ログイン画面に戻りますか?"),
                    actions: [
                      CupertinoDialogAction(
                        child: Text('Cancel'),
                        isDestructiveAction: true,
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                      ),
                      CupertinoDialogAction(
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginForm(),
                            ),
                          );
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
    );
  }

  Widget getPageContainer(int index) {
    switch (index) {
      case 0:
        return Container(
          child: ImageContainer(
            img: Image.asset("assets/img/accountRegister.png"),
            txt: '左上のsettingIcon押下でアカウントの登録ができます^_^',
          ),
        );
      case 1:
        return Container(
          child: ImageContainer(
            img: Image.asset("assets/img/profile.png"),
            txt: '登録することで筋トレの記録をとります！',
          ),
        );
      case 2:
        return Container(
          child: ImageContainer(
            img: Image.asset("assets/img/body.png"),
            txt: '他に身長体重の入力をしてBMI数値の計測が可能となります!',
          ),
        );
      default:
        return SizedBox();
    }
  }
}
