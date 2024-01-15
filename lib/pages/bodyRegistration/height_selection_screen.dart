import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:training/pages/Profile/Profile.dart';
import 'package:training/pages/bodyRegistration/height_provider.dart';

class HeightRegister extends ConsumerWidget {
  const HeightRegister({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _height = ref.watch(heightProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Height"),
      ),
      body: Stack(
        children: [
          Height(
            height: _height,
          ),
          Positioned(
            top: 80,
            left: 40,
            child: FloatingActionButton(
              onPressed: () {
                _heightSave(ref, _height);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => MainContents(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  _heightSave(WidgetRef ref, double _height) {
    final notifier = ref.read(heightProvider.notifier);
    notifier.state = _height;
  }
}

class Height extends StatefulWidget {
  double height;
  Height({Key? key, required this.height}) : super(key: key);

  @override
  State<Height> createState() => _HeightState();
}

class _HeightState extends State<Height> {
  TextEditingController heightController = TextEditingController();

  @override
  void dispose() {
    heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                child: Text(
                  'Height: ',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                width: 80,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '身長',
                  ),
                  controller: heightController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onChanged: (value) {
                    setState(
                      () {
                        widget.height = double.parse(value);
                      },
                    );
                  },
                ),
              ),
              Container(
                width: 70,
                child: Text(
                  'cm',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Center(
            child: Container(
              height: 600,
              child: SfLinearGauge(
                showTicks: true,
                labelPosition: LinearLabelPosition.inside,
                tickPosition: LinearElementPosition.outside,
                orientation: LinearGaugeOrientation.vertical,
                maximum: 240,
                interval: 10,
                ranges: [
                  LinearGaugeRange(
                    color: Colors.transparent,
                    startValue: 0,
                    endValue: 80,
                  ),
                ],
                markerPointers: [
                  LinearShapePointer(
                    onChanged: (value) {
                      setState(() {
                        widget.height = value;
                        heightController.text =
                            widget.height.toStringAsFixed(1);
                      });
                    },
                    dragBehavior: LinearMarkerDragBehavior.free,
                    shapeType: LinearShapePointerType.circle,
                    color: Colors.green,
                    value: widget.height,
                    borderWidth: 2,
                    borderColor: Colors.green,
                    position: LinearElementPosition.cross,
                  ),
                ],
                barPointers: [
                  LinearBarPointer(
                    value: widget.height,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
