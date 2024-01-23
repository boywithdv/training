import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final Image img;
  final String txt;
  const ImageContainer({super.key, required this.img, required this.txt});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        decoration: BoxDecoration(),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            CustomContainer(
              img: img,
            ),
            SizedBox(
              height: 20,
            ),
            TextComponent(
              text: txt,
            )
          ],
        ),
      ),
    );
  }
}

class CustomContainer extends StatefulWidget {
  final Image img;
  const CustomContainer({super.key, required this.img});

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer>
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
          isTapped != isTapped;
        });
      },
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _animation,
        child: Container(
          width: 240,
          height: 460,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 8,
              ),
            ],
          ),
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: widget.img,
          ),
        ),
      ),
    );
  }
}

class TextComponent extends StatefulWidget {
  final String text;
  const TextComponent({super.key, required this.text});

  @override
  State<TextComponent> createState() => _TextComponentState();
}

class _TextComponentState extends State<TextComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 170,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          widget.text,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white70, fontSize: 20),
        ),
      ),
    );
  }
}
