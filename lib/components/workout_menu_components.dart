import 'package:flutter/material.dart';

class WorkoutMenuComponents extends StatefulWidget {
  final Color? colors;
  final double width;
  final double height;
  final Function() ontap;
  final Widget? widgetChild;

  const WorkoutMenuComponents({
    super.key,
    this.colors,
    required this.width,
    required this.height,
    this.widgetChild,
    required this.ontap,
  });

  @override
  State<WorkoutMenuComponents> createState() => _WorkoutMenuComponentsState();
}

class _WorkoutMenuComponentsState extends State<WorkoutMenuComponents>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    duration: const Duration(milliseconds: 100),
    vsync: this,
  );
  late final _animation = _controller.drive(Tween<double>(begin: 1, end: 0.95));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
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
              Center(
                child: widget.widgetChild,
              )
            ],
          ),
        ),
      ),
    );
  }
}
