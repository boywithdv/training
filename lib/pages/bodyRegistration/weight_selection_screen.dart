import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:tuple/tuple.dart';

class WeightSelectionScreen extends StatefulWidget {
  const WeightSelectionScreen({super.key});

  @override
  State<WeightSelectionScreen> createState() => _WeightSelectionScreenState();
}

class _WeightSelectionScreenState extends State<WeightSelectionScreen> {
  WeightType weightType = WeightType.kg;

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
          type: weightType,
          onChanged: (value) => setState(() => weight = value),
        )
      ]),
    );
  }
}

class WeightSelection extends StatefulWidget {
  const WeightSelection({super.key});

  @override
  State<WeightSelection> createState() => _WeightSelection();
}

//体重のタイプを作成
enum WeightType {
  kg,
  lb,
}

class _WeightSelection extends State<WeightSelection> {
  WeightType weightType = WeightType.kg;

  double weight = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$weight ${weightType.name}'),
            //ボタンがクリックされると画面下部から表示される
            ElevatedButton(
              onPressed: () => _openBottomSheet(context),
              child: const Text('Change'),
            ),
          ],
        ),
      ),
    );
  }

  void _openBottomSheet(BuildContext context) async {
    final res = await showModalBottomSheet<Tuple2<WeightType, double>>(
      context: context,
      elevation: 0,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            decoration: _bottomSheetDecoration,
            height: 500,
            child: Column(
              children: [
                //ヘッダー部分
                _Header(
                  weightType: weightType,
                  inKg: weight,
                ),
                //Kgかlibのどちらかを選択する
                _Switcher(
                  weightType: weightType,
                  onChanged: (type) => setState(() => weightType = type),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: DivisionSlider(
                    from: 0,
                    max: 190,
                    initialValue: weight,
                    type: weightType,
                    onChanged: (value) => setState(() => weight = value),
                  ),
                )
              ],
            ),
          );
        });
      },
    );
    if (res != null) {
      setState(() {
        weightType = res.item1;
        weight = res.item2;
      });
    }
  }
}

const _bottomSheetDecoration = BoxDecoration(
  color: Color(0xffD9D9D9),
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(30),
    topRight: Radius.circular(30),
  ),
);

class _Header extends StatelessWidget {
  const _Header({
    required this.weightType,
    required this.inKg,
  });

  final WeightType weightType;
  final double inKg;

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            color: Colors.black54,
            onPressed: () => navigator.pop(),
            icon: const Icon(Icons.close),
          ),
          const Text('Weight',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          IconButton(
            color: Colors.black54,
            onPressed: () => navigator.pop<Tuple2<WeightType, double>>(
              Tuple2(weightType, inKg),
            ),
            icon: const Icon(Icons.check),
          ),
        ],
      ),
    );
  }
}

extension WeightTypeExtension on WeightType {
  String get name {
    switch (this) {
      case WeightType.kg:
        return 'kg';
      case WeightType.lb:
        return 'lb';
    }
  }
}

class _Switcher extends StatelessWidget {
  final WeightType weightType;
  final ValueChanged<WeightType> onChanged;
  const _Switcher({
    Key? key,
    required this.weightType,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 250,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            top: 2,
            width: 121,
            height: 36,
            left: weightType == WeightType.kg ? 2 : 127,
            duration: const Duration(milliseconds: 300),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildButton(WeightType.kg),
              _buildButton(WeightType.lb)
            ],
          ))
        ],
      ),
    );
  }

  Widget _buildButton(WeightType type) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onChanged(type),
        child: Center(
          child: Text(
            type.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class DivisionSlider extends StatefulWidget {
  final double from;
  final double max;
  final double initialValue;
  final Function(double) onChanged;
  final WeightType type;

  const DivisionSlider({
    required this.from,
    required this.max,
    required this.initialValue,
    required this.onChanged,
    required this.type,
    super.key,
  });

  @override
  State<DivisionSlider> createState() => _DivisionSliderState();
}

class _DivisionSliderState extends State<DivisionSlider> {
  PageController? numbersController;
  final itemsExtension = 1000;
  late double value;

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
              Text(
                'Weight: $value ${widget.type.name}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 10,
                width: 11.5,
                child: CustomPaint(
                  painter: TrianglePainter(),
                ),
              ),
              _Numbers(
                itemsExtension: itemsExtension,
                controller: numbersController,
                start: widget.from.toInt(),
                end: widget.max.toInt(),
              ),
            ],
          );
        },
      ),
    );
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

const greenColor = Color(0xff90D855);

class _Numbers extends StatelessWidget {
  final PageController? controller;
  final int itemsExtension;
  final int start;
  final int end;

  const _Numbers({
    required this.controller,
    required this.itemsExtension,
    required this.start,
    required this.end,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: PageView.builder(
        pageSnapping: false,
        controller: controller,
        physics: _CustomPageScrollPhysics(
          start: itemsExtension + start.toDouble(),
          end: itemsExtension + end.toDouble(),
        ),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, rawIndex) {
          final index = rawIndex - itemsExtension;
          return _Item(index: index >= start && index <= end ? index : null);
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
