import 'package:flutter/material.dart';
import 'package:training/pages/bodyRegistration/height_selection_screen.dart';
import 'package:training/pages/bodyRegistration/weight_selection_screen.dart';

class CustomComponents extends StatefulWidget {
  const CustomComponents({Key? key}) : super(key: key);

  @override
  State<CustomComponents> createState() => _CustomComponentsState();
}

class _CustomComponentsState extends State<CustomComponents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              '登録するパラメータを選択してください',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Components(
                  text: "身長",
                  child: HeightRegister(),
                ),
                Components(
                  text: "体重",
                  child: WeightSelectionScreen(),
                )
              ],
            ),
          ],
        ));
  }
}

class Components extends StatefulWidget {
  final String text;
  final Widget child;
  const Components({Key? key, required this.text, required this.child})
      : super(key: key);

  @override
  _ComponentsState createState() => _ComponentsState();
}

class _ComponentsState extends State<Components>
    with SingleTickerProviderStateMixin {
  bool isTapped = false;
  late final _controller = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  );
  late final _animation = _controller.drive(Tween<double>(begin: 1, end: 0.95));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isTapped = !isTapped;
        });
        // Navigatorをアニメーション後に呼び出す
        _controller.reverse().then((_) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => widget.child));
        });
      },
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _animation,
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
              color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 10,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 0,
                child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
