import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training/view/pages/ScreenWidget.dart';
import 'package:training/controller/UserInfo.dart';

class AppDescription extends StatelessWidget {
  const AppDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      debugShowCheckedModeBanner: false,
      home: AppDescriptionNavigation(),
    );
  }
}

class AppDescriptionNavigation extends ConsumerWidget {
  const AppDescriptionNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoPageScaffold(
        backgroundColor: Colors.transparent,
        child: CustomScrollView(
          slivers: <Widget>[
            const CupertinoSliverNavigationBar(
                backgroundColor: Colors.transparent,
                leading: Icon(
                  CupertinoIcons.person,
                  color: Colors.white,
                ),
                largeTitle: Text(
                  'Instructions for use',
                  style: TextStyle(color: Colors.white),
                )),
            SliverFillRemaining(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "HELLO WORLD !",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    'Go to NEXT PAGESボタンをクリックすることで次のページに進めます。',
                    style: TextStyle(color: Colors.white),
                  ),
                  CupertinoButton(
                    color: Colors.transparent,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Go to NEXT PAGES",
                        ),
                        Icon(CupertinoIcons.hand_point_right)
                      ],
                    ),
                    onPressed: () {
                      print(userName);
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (BuildContext context) {
                            return const ScreenWidget();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = CupertinoTheme.brightnessOf(context);
    return CupertinoPageScaffold(
      backgroundColor: Colors.transparent,
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            leading: IconButton(
              icon: Icon(
                CupertinoIcons.arrow_left_circle,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: const Color.fromARGB(0, 255, 204, 0),
            border: Border(
              bottom: BorderSide(
                color: brightness == Brightness.light
                    ? CupertinoColors.black
                    : CupertinoColors.white,
              ),
            ),
            middle: const Text(
              'Instructions for use',
              style: TextStyle(color: Colors.white),
            ),
            largeTitle: const Text(
              'Description(説明)',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SliverFillRemaining(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Drag me up',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
