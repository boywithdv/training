import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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

class AppDescriptionNavigation extends StatelessWidget {
  const AppDescriptionNavigation({super.key});

  @override
  Widget build(BuildContext context) {
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
                'Contacts',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(
                CupertinoIcons.add_circled,
                color: Colors.white,
              ),
            ),
            SliverFillRemaining(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Drag me up",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  CupertinoButton.filled(
                      child: const Text(
                        "Go to NEXT PAGES",
                        style: TextStyle(backgroundColor: Colors.transparent),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (BuildContext context) {
                          return const NextPage();
                        }));
                      })
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
            backgroundColor: const Color.fromARGB(0, 255, 204, 0),
            border: Border(
              bottom: BorderSide(
                color: brightness == Brightness.light
                    ? CupertinoColors.black
                    : CupertinoColors.white,
              ),
            ),
            // The middle widget is visible in both collapsed and expanded states.
            middle: const Text(
              'Contacts Group',
              style: TextStyle(color: Colors.white),
            ),
            // When the "middle" parameter is implemented, the largest title is only visible
            // when the CupertinoSliverNavigationBar is fully expanded.
            largeTitle: const Text(
              'Family',
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
                // When the "leading" parameter is omitted on a route that has a previous page,
                // the back button is automatically added to the leading position.
                Text('Tap on the leading button to navigate back',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
