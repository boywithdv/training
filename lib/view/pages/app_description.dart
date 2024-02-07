import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training/view/components/imageContainer.dart';
import 'package:training/view/pages/ScreenWidget.dart';

class AppDescription extends StatefulWidget {
  const AppDescription({Key? key}) : super(key: key);

  @override
  State<AppDescription> createState() => _AppDescriptionState();
}

class _AppDescriptionState extends State<AppDescription> {
  late final PageController _pageController;
  int pageNo = 0;
  late final Timer _timer;
  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 2), (timer) {
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double circlewidth = width * 0.43;
    double circleheight = height * 0.86;
    double arrowForwardWidth = width * 0.8;
    double arrowForwardHeight = height * 0.84;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          "AppDescription",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
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
            top: circleheight * 0.9,
            left: circlewidth,
            child: Row(
              children: List.generate(
                3,
                (index) => Container(
                  margin: EdgeInsets.all(3.0),
                  child: Icon(
                    Icons.circle,
                    size: 12.0,
                    color: pageNo == index ? Colors.green : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: arrowForwardHeight * 0.9,
            left: arrowForwardWidth,
            child: IconButton(
              icon: Icon(
                pageNo == 2 ? Icons.arrow_forward : null,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const ScreenWidget();
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget getPageContainer(int index) {
    switch (index) {
      case 0:
        return Container(
          child: ImageContainer(
            img: Image.asset("assets/img/profile.png"),
            txt: 'プロフィール画面で1日の筋トレを記録することができます^_^',
          ),
        );
      case 1:
        return Container(
          child: ImageContainer(
            img: Image.asset("assets/img/selection.png"),
            txt: '筋トレの部位選択をしてトレーニングをしよう！',
          ),
        );
      case 2:
        return Container(
          child: ImageContainer(
            img: Image.asset("assets/img/body.png"),
            txt: '身長と体重を入力してBMIの数値を記録してくれます!',
          ),
        );
      default:
        return Container();
    }
  }
}
