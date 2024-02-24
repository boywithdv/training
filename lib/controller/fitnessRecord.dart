// firestore通信するクラス

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training/controller/user_info.dart';

class FirestoreService {
  final db = FirebaseFirestore.instance;
  DateTime dt = DateTime.now();

  Future<void> read() async {
    final doc = await db
        .collection('userId')
        .doc(userId)
        .collection('favorite')
        .doc("fitness")
        .get();
    if (doc.exists == false) {
      favorite_part_of_training = "大胸筋";
    } else {
      favorite_part_of_training = doc.data()?["title"];
    }
  }

  Future<void> delete() async {
    await db
        .collection('userId')
        .doc(userId)
        .collection('fitness')
        .doc('1day')
        .collection('training')
        .doc('test2')
        .delete();
  }

  Future<List<TrainingData>> allread() async {
    final snapshot = await db
        .collection('userId')
        .doc(userId)
        .collection('fitness')
        .doc(dt.year.toString() +
            '-' +
            dt.month.toString() +
            '-' +
            dt.day.toString())
        .collection('training')
        .get();

    // ドキュメントデータをList<TrainingData>として取得
    final List<TrainingData> documents = snapshot.docs.map(
      (QueryDocumentSnapshot<Map<String, dynamic>> e) {
        final data = e.data();
        return TrainingData(
          title: data['title'],
          time: data['time'].toDate(), // FirestoreのTimestampをDateTimeに変換
        );
      },
    ).toList();
    // documentsを使って何かしらの処理を行う
    for (var doc in documents) {
      print(doc.title);
      print(doc.time);
    }
    return documents; // データを返す
  }
}

class TrainingData {
  final String title;
  final DateTime time;
  TrainingData({required this.title, required this.time});
}
