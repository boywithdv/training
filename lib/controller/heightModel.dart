import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training/controller/UserInfo.dart';

class FirestoreService {
  //CRUDの関数たち
  Future<void> create() async {
    final db = FirebaseFirestore.instance;
    DateTime dt = DateTime.now();
    await db
        .collection('userId')
        .doc(userId)
        .collection('height')
        //ここのdocはriverpodによりカウンターを作成してtest○○というようにする
        .doc('data')
        //Modelを使用してtitleに値を入れる
        .set({'title': '大胸筋', 'time': dt});
  }
}
