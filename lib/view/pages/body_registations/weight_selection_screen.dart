import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:training/controller/UserInfo.dart';
import 'package:training/view/pages/screen_widget.dart';

class Weight extends StatefulWidget {
  const Weight({super.key});

  @override
  State<Weight> createState() => _WeightState();
}

class _WeightState extends State<Weight> {
  double weight = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weight"),
      ),
      body: Column(children: [
        SizedBox(
          height: 200,
        ),
        DivisionSlider(
          from: 0,
          max: 190,
          initialValue: weight,
          onChanged: (value) => setState(() => weight = value),
        )
      ]),
    );
  }
}

class DivisionSlider extends StatefulWidget {
  final double from;
  final double max;
  final double initialValue;
  final Function(double) onChanged;

  const DivisionSlider({
    required this.from,
    required this.max,
    required this.initialValue,
    required this.onChanged,
    super.key,
  });

  @override
  State<DivisionSlider> createState() => _DivisionSliderState();
}

class _DivisionSliderState extends State<DivisionSlider> {
  PageController? numbersController;
  final itemsExtension = 1000;
  late double value;
  TextEditingController _weightController = TextEditingController();
  @override
  void initState() {
    value = widget.initialValue;
    super.initState();
  }

  void _updateValue() {
    value = ((((numbersController?.page ?? 0) - itemsExtension) * 10)
                .roundToDouble() /
            10)
        .clamp(widget.from, widget.max);
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.initialValue >= widget.from &&
        widget.initialValue <= widget.max);
    return Container(
      color: Colors.white,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final viewPortFraction = 1 / (constraints.maxWidth / 10);
          numbersController = PageController(
            initialPage: itemsExtension + widget.initialValue.toInt(),
            viewportFraction: viewPortFraction * 10,
          );
          numbersController?.addListener(_updateValue);
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Container(
                width: 80,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '入力',
                  ),
                  controller: _weightController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onChanged: (idx) {
                    setState(() {
                      value = double.parse(idx);
                      numbersController
                          ?.jumpToPage(itemsExtension + value.toInt());
                      _updateValue();
                    });
                  },
                ),
              ),
              Text(
                'Weight: $value kg',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              //中心の棒
              SizedBox(
                height: 10,
                width: 11.5,
                child: CustomPaint(
                  painter: TrianglePainter(),
                ),
              ),
              //横にスライドできるもの
              _Numbers(
                itemsExtension: itemsExtension,
                controller: numbersController,
                start: widget.from.toInt(),
                onSlide: (idx) {
                  value = idx.toDouble();
                },
                end: widget.max.toInt(),
              ),
              FloatingActionButton(
                onPressed: () {
                  if (value == "" || value == 0) {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text("Input values are incorrect."),
                        content: Text("体重を入力してください"),
                        actions: [],
                      ),
                    );
                  } else {
                    weight_create();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ScreenWidget(),
                      ),
                    );
                  }
                },
                child: Icon(Icons.check),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> weight_create() async {
    final db = FirebaseFirestore.instance;
    DateTime dt = DateTime.now();
    final days = dt.year.toString() + dt.month.toString() + dt.day.toString();
    await db
        .collection('userId')
        .doc(userId)
        .collection('weight')
        .doc(days.toString())
        .set({'WeightData': value, 'time': dt});
  }

  @override
  void dispose() {
    numbersController?.removeListener(_updateValue);
    numbersController?.dispose();
    super.dispose();
  }
}

class TrianglePainter extends CustomPainter {
  TrianglePainter();

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.transparent;
    Paint paint2 = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
    canvas.drawPath(line(size.width, size.height), paint2);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..lineTo(x, 0)
      ..lineTo(x / 2, y)
      ..lineTo(0, 0);
  }

  Path line(double x, double y) {
    return Path()
      ..moveTo(x / 2, 0)
      ..lineTo(x / 2, y * 2);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return true;
  }
}

class _Numbers extends StatefulWidget {
  final PageController? controller;
  final int itemsExtension;
  final int start;
  final int end;
  final ValueChanged<double> onSlide;

  const _Numbers({
    required this.controller,
    required this.itemsExtension,
    required this.start,
    required this.end,
    required this.onSlide,
    Key? key,
  }) : super(key: key);

  @override
  _NumbersState createState() => _NumbersState();
}

class _NumbersState extends State<_Numbers> {
  double currentValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: PageView.builder(
        pageSnapping: false,
        controller: widget.controller,
        physics: _CustomPageScrollPhysics(
          start: widget.itemsExtension + widget.start.toDouble(),
          end: widget.itemsExtension + widget.end.toDouble(),
        ),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, rawIndex) {
          final index = rawIndex - widget.itemsExtension;
          return _Item(
            index: index >= widget.start && index <= widget.end ? index : null,
          );
        },
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final int? index;

  const _Item({
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          const _Dividers(),
          if (index != null)
            Expanded(
              child: Center(
                child: Text(
                  '$index',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Dividers extends StatelessWidget {
  const _Dividers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(10, (index) {
          final thickness = index == 5 ? 1.5 : 0.5;
          return Expanded(
            child: Row(
              children: [
                Transform.translate(
                  offset: Offset(-thickness / 2, 0),
                  child: VerticalDivider(
                    thickness: thickness,
                    width: 1,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _CustomPageScrollPhysics extends ScrollPhysics {
  final double start;
  final double end;

  const _CustomPageScrollPhysics({
    required this.start,
    required this.end,
    ScrollPhysics? parent,
  }) : super(parent: parent);

  @override
  _CustomPageScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _CustomPageScrollPhysics(
      parent: buildParent(ancestor),
      start: start,
      end: end,
    );
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    final oldPosition = position.pixels;
    final frictionSimulation =
        FrictionSimulation(0.4, position.pixels, velocity * 0.2);

    double newPosition = (frictionSimulation.finalX / 10).round() * 10;

    final endPosition = end * 10 * 10;
    final startPosition = start * 10 * 10;
    if (newPosition > endPosition) {
      newPosition = endPosition;
    } else if (newPosition < startPosition) {
      newPosition = startPosition;
    }
    if (oldPosition == newPosition) {
      return null;
    }
    return ScrollSpringSimulation(
      spring,
      position.pixels,
      newPosition.toDouble(),
      velocity,
      tolerance: tolerance,
    );
  }

  @override
  SpringDescription get spring => const SpringDescription(
        mass: 20,
        stiffness: 100,
        damping: 0.8,
      );
}
