import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:training/components/custom_components.dart';
import 'package:training/models/Data/app_colors.dart';
import 'package:training/controller/UserInfo.dart';
import 'package:training/view/pages/body_registations/body_register_page.dart';

class LinerGraph extends StatefulWidget {
  const LinerGraph({super.key});

  @override
  State<LinerGraph> createState() => _LinerGraphState();
}

class _LinerGraphState extends State<LinerGraph> {
  List<WeightData> weightDataList = [];
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    userId = prefs.getString("uid");
    userName = prefs.getString('userName') ?? "";
    setState(() {});
    // データ取得後にsetStateを呼び出して反映させる
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Center(
          child: CustomComponents(
        text: 'BMI',
        ontap: null,
        params: _controller.text,
        width: 360,
        height: 240,
        child: GraphContainer(),
        icon: Icon(
          Icons.person,
          size: 35,
        ),
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await readWeight();
          setState(() {
            _controller.text = weightDataList[0].weight.toString();
          });
        },
        label: Icon(Icons.check),
      ),
    );
  }

  Future<void> readWeight() async {
    final db = FirebaseFirestore.instance;
    DateTime dt = DateTime.now();
    final days = dt.year.toString() + dt.month.toString() + dt.day.toString();
    final doc = await db
        .collection('userId')
        .doc(userId)
        .collection('weight')
        //ここのdocはriverpodによりカウンターを作成してtest○○というようにする
        //こうすることで翌日読み込むことが難しくなる days.toString()
        .doc(days)
        //Modelを使用してtitleに値を入れる
        .get();
    if (doc.exists) {
      // 'height' フィールドが存在する場合にのみ代入する
      fitnessWeight = doc.data()?['WeightData'] as double;
      fitnessWeight = fitnessWeight.toStringAsFixed(1);
    } else {
      //userIdがnullの場合がこれになる
      print(fitnessWeight);
    }
  }
}

class WeightData {
  final double weight;
  final DateTime time;
  WeightData({required this.weight, required this.time});
}

class GraphContainer extends StatefulWidget {
  const GraphContainer({Key? key}) : super(key: key);

  @override
  State<GraphContainer> createState() => _GraphContainerState();
}

class _GraphContainerState extends State<GraphContainer> {
  late List<FlSpot> spots; // グラフのデータポイント
  late double minY; // グラフのy軸最小値
  late double maxY; // グラフのy軸最大値
  List<WeightData> weightDataList = [];

  bool animationCompleted = false;
  List<Color> gradientColors = [
    AppColors.contentColorCyan,
    AppColors.contentColorBlue,
  ];
  @override
  void initState() {
    minY = 9.0; // 初期値は9kgから-10kg
    maxY = 120.0; // 初期値は120kgから+10kg
    spots = [];
    // 本日の体重を取得（仮の例）
    getCurrentWeightFromFirebase().then((value) {
      setState(() {
        updateGraphData();
      });
    });
    _initData();
    // グラフにアニメーションを追加
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        animationCompleted = true;
      });
    });
    super.initState();
  }

  Future<void> _initData() async {
    userId = prefs.getString("uid");
    userName = prefs.getString('userName') ?? "";
    await _getDataFromFirebase();
    // データ取得後にsetStateを呼び出して反映させる

    setState(() {});
  }

  //ここでグラフのデータ取得
  Future<void> _getDataFromFirebase() async {
    final List<WeightData> data = await allread();
    weightDataList = data;
  }

  Future<double> getCurrentWeightFromFirebase() async {
    // Firebaseからのデータ取得ロジックを追加
    var snapshot = await FirebaseFirestore.instance
        .collection('weights')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first['weight'];
    } else {
      return 0.0; // データがない場合のデフォルト値
    }
  }

  void updateGraphData() {
    // weightDataListの各要素をFlSpotに変換し、spotsに追加
    spots = weightDataList.asMap().entries.map((entry) {
      int index = entry.key;
      WeightData data = entry.value;
      // 日付を順番に使用
      return FlSpot(index.toDouble(), data.weight);
    }).toList();
    // グラフのy軸範囲を更新
    // グラフのy軸範囲を更新
    //updateYAxisRange();

    // 表示データを制限
    if (spots.length > 30) {
      spots = spots.sublist(spots.length - 7);
    }
  }

  void updateYAxisRange() {
    if (spots.isNotEmpty) {
      minY = spots
          .map((spot) => spot.y)
          .reduce((value, element) => value < element ? value : element);
      maxY = spots
          .map((spot) => spot.y)
          .reduce((value, element) => value > element ? value : element);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340, // 任意の幅を指定
      height: 170, // 任意の高さを指定
      decoration: BoxDecoration(
        color: Color(0xff37434d),
        borderRadius: BorderRadius.circular(20),
      ),
      child: LineChart(
        LineChartData(
          // 中心のラインを設定
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            getDrawingHorizontalLine: (value) {
              return FlLine(color: Colors.white, strokeWidth: 0);
            },
          ),
          // グラフの外側の数値を表示
          titlesData: FlTitlesData(
            topTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),

          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.white, width: 1),
          ),

          minX: 0,
          maxX: 30,
          minY: minY,
          maxY: maxY,
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              gradient: LinearGradient(
                colors: [
                  ColorTween(begin: gradientColors[0], end: gradientColors[1])
                      .lerp(0.2)!,
                  ColorTween(begin: gradientColors[0], end: gradientColors[1])
                      .lerp(0.2)!,
                ],
              ),
              barWidth: 5,
              color: gradientColors[0],
              dotData: FlDotData(show: false),
              isStrokeCapRound: true,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    ColorTween(begin: gradientColors[0], end: gradientColors[1])
                        .lerp(0.2)!
                        .withOpacity(0.1),
                    ColorTween(begin: gradientColors[0], end: gradientColors[1])
                        .lerp(0.2)!
                        .withOpacity(0.1),
                  ],
                ),
              ),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 0),
      ),
    );
  }

  Future<List<WeightData>> allread() async {
    final db = FirebaseFirestore.instance;
    //ここでsnapshotにweightデータを取得する
    final snapshot =
        await db.collection('userId').doc(userId).collection('weight').get();

    // ドキュメントデータをList<TrainingData>として取得
    final List<WeightData> documents = snapshot.docs.map(
      (QueryDocumentSnapshot<Map<String, dynamic>> e) {
        final data = e.data();
        return WeightData(
          weight: data['WeightData'],
          time: data['time'].toDate(), // FirestoreのTimestampをDateTimeに変換
        );
      },
    ).toList();
    // documentsを使って何かしらの処理を行う
    return documents;
  }
}
