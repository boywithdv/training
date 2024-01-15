import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:training/controller/UserInfo.dart';
import 'package:training/pages/Profile/Profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Height extends StatefulWidget {
  const Height({Key? key}) : super(key: key);

  @override
  State<Height> createState() => _HeightState();
}

class _HeightState extends State<Height> {
  double index = 0;
  TextEditingController heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Height"),
      ),
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
                    setState(() {
                      index = double.parse(value);
                    });
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
                        index = value;
                        heightController.text = index.toStringAsFixed(1);
                      });
                    },
                    dragBehavior: LinearMarkerDragBehavior.free,
                    shapeType: LinearShapePointerType.circle,
                    color: Colors.green,
                    value: index,
                    borderWidth: 2,
                    borderColor: Colors.green,
                    position: LinearElementPosition.cross,
                  ),
                ],
                barPointers: [
                  LinearBarPointer(
                    value: index,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          height_create();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => MainContents(),
            ),
          );
        },
        label: Icon(Icons.check),
      ),
    );
  }

  Future<void> height_create() async {
    final db = FirebaseFirestore.instance;
    DateTime dt = DateTime.now();
    await db
        .collection('userId')
        .doc(userId)
        .collection('height')
        .doc('data')
        .set({'HeightData': index, 'time': dt});
  }
}

/*
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
                _heightSave(ref, 200);
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
*/