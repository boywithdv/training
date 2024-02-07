import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var fitnessHeight;
var fitnessWeight;

class CustomComponents extends StatefulWidget {
  final String? text;
  final String? params;
  final Widget? ontap;
  final double width;
  final double height;
  final Widget? child;
  final Icon? icon;
  final Color? colors;
  final Widget? profileEditButton;

  const CustomComponents({
    Key? key,
    this.text,
    this.colors,
    this.ontap,
    this.params,
    required this.width,
    required this.height,
    this.child,
    this.icon,
    this.profileEditButton,
  }) : super(key: key);

  @override
  _CustomComponentsState createState() => _CustomComponentsState();
}

class _CustomComponentsState extends State<CustomComponents>
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
        _controller.reverse().then(
          (_) {
            // widget.ontapを評価し、nullでない場合のみNavigator.pushを呼び出す
            if (widget.ontap != null) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return widget.ontap!;
              }));
            }
          },
        );
      },
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _animation,
        child: Container(
          width: widget.width,
          height: widget.height,
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
              color: widget.colors),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 10,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    widget.text ?? "",
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
                child:
                    Padding(padding: EdgeInsets.all(8.0), child: widget.icon),
              ),
              Positioned(
                top: 35,
                left: 10,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    widget.params ?? "",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Positioned(
                top: 65,
                left: 10,
                child: Center(
                  child: widget.child,
                ),
              ),
              Center(
                child: widget.profileEditButton,
              )
            ],
          ),
        ),
      ),
    );
  }
}
