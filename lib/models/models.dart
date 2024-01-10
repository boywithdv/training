class FitnessModel {
  final int fitnessId;
  final String fitnessName;
  final String fitnessLottieName;
  final String fitnessPngName;
  final String fitnessTags;
  FitnessModel(
      {required this.fitnessId,
      required this.fitnessLottieName,
      required this.fitnessName,
      required this.fitnessPngName,
      required this.fitnessTags});
}

//大胸筋
List<FitnessModel> pectoralisMajorMuscle = [
  FitnessModel(
      fitnessId: 1,
      fitnessLottieName: 'assets/Lottie/daikyoukin2.json',
      fitnessName: 'プッシュアップ',
      fitnessPngName: 'assets/img/daikyoukin.png',
      fitnessTags: '大胸筋'),
  FitnessModel(
      fitnessId: 2,
      fitnessLottieName: 'assets/Lottie/daikyoukin1.json',
      fitnessPngName: 'assets/img/daikyoukin.png',
      fitnessName: 'スタッガードプッシュアップ',
      fitnessTags: '大胸筋'),
];
List<FitnessModel> deltoid = [
  FitnessModel(
      fitnessId: 1,
      fitnessLottieName: 'assets/Lottie/hukkin2.json',
      fitnessName: 'プランクプッシュアップ',
      fitnessPngName: 'assets/img/kata_sankakukin.PNG',
      fitnessTags: '三角筋'),
  FitnessModel(
      fitnessId: 2,
      fitnessLottieName: 'assets/Lottie/hukkin9.json',
      fitnessName: 'スパイダープランク',
      fitnessPngName: 'assets/img/kata_sankakukin.PNG',
      fitnessTags: '三角筋'),
  FitnessModel(
      fitnessId: 3,
      fitnessLottieName: 'assets/Lottie/sannkakukin.json',
      fitnessName: 'プランクプッシュアップ',
      fitnessPngName: 'assets/img/kata_sankakukin.PNG',
      fitnessTags: '三角筋')
];
//腹筋
List<FitnessModel> abs = [
  FitnessModel(
      fitnessId: 1,
      fitnessLottieName: 'assets/Lottie/hukkin1.json',
      fitnessPngName: 'assets/img/hukkin.png',
      fitnessName: '腹筋',
      fitnessTags: 'お腹'),
  FitnessModel(
      fitnessId: 2,
      fitnessLottieName: 'assets/Lottie/hukkin2.json',
      fitnessPngName: 'assets/img/hukkin.png',
      fitnessName: 'プランクプッシュアップ',
      fitnessTags: 'お腹'),
  FitnessModel(
      fitnessId: 3,
      fitnessLottieName: 'assets/Lottie/hukkin3.json',
      fitnessPngName: 'assets/img/hukkin.png',
      fitnessName: 'プランク・リーチバック',
      fitnessTags: 'お腹'),
  FitnessModel(
      fitnessId: 4,
      fitnessLottieName: 'assets/Lottie/hukkin4.json',
      fitnessPngName: 'assets/img/hukkin.png',
      fitnessName: 'クランチ',
      fitnessTags: 'お腹'),
  FitnessModel(
      fitnessId: 5,
      fitnessLottieName: 'assets/Lottie/hukkin5.json',
      fitnessPngName: 'assets/img/hukkin.png',
      fitnessName: 'ヒップヒンジ&ハイブランク',
      fitnessTags: 'お腹'),
  FitnessModel(
      fitnessId: 6,
      fitnessLottieName: 'assets/Lottie/hukkin6.json',
      fitnessPngName: 'assets/img/hukkin.png',
      fitnessName: 'ベントレッグレイズ',
      fitnessTags: 'お腹'),
  FitnessModel(
      fitnessId: 7,
      fitnessLottieName: 'assets/Lottie/hukkin7.json',
      fitnessPngName: 'assets/img/hukkin.png',
      fitnessName: 'レッグサークル',
      fitnessTags: 'お腹'),
  FitnessModel(
      fitnessId: 8,
      fitnessLottieName: 'assets/Lottie/hukkin8.json',
      fitnessPngName: 'assets/img/hukkin.png',
      fitnessName: 'デッドバグ',
      fitnessTags: 'お腹'),
  FitnessModel(
      fitnessId: 9,
      fitnessLottieName: 'assets/Lottie/hukkin9.json',
      fitnessPngName: 'assets/img/hukkin.png',
      fitnessName: 'スパイダープランク',
      fitnessTags: 'お腹'),
  FitnessModel(
      fitnessId: 10,
      fitnessLottieName: 'assets/Lottie/hukkin10.json',
      fitnessPngName: 'assets/img/hukkin.png',
      fitnessName: 'ヒップリフト',
      fitnessTags: 'お腹'),
];
List<FitnessModel> obliqueAbdominal = [
  FitnessModel(
      fitnessId: 1,
      fitnessLottieName: 'assets/Lottie/hukusyakin.json',
      fitnessName: 'サイドレッグリフト',
      fitnessPngName: 'assets/img/gaihukusyakin.PNG',
      fitnessTags: '腹斜筋'),
  FitnessModel(
      fitnessId: 11,
      fitnessLottieName: 'assets/Lottie/hukkin11.json',
      fitnessPngName: 'assets/img/gaihukusyakin.PNG',
      fitnessName: 'メイソンツイスト',
      fitnessTags: '腹斜筋'),
  FitnessModel(
      fitnessId: 3,
      fitnessLottieName: 'assets/Lottie/hukkin2.json',
      fitnessPngName: 'assets/img/hukkin.png',
      fitnessName: 'プランクプッシュアップ',
      fitnessTags: '腹斜筋'),
  FitnessModel(
      fitnessId: 4,
      fitnessLottieName: 'assets/Lottie/cross_crunch.json',
      fitnessPngName: 'assets/img/hukkin.png',
      fitnessName: 'クロスクランチ',
      fitnessTags: '腹斜筋'),
];

List<FitnessModel> thigh = [
  FitnessModel(
      fitnessId: 1,
      fitnessLottieName: 'assets/Lottie/hutomomo1.json',
      fitnessPngName: 'assets/img/hamusutoring.PNG',
      fitnessName: 'ウォークングランジ',
      fitnessTags: '太もも'),
  FitnessModel(
      fitnessId: 2,
      fitnessLottieName: 'assets/Lottie/hutomomo2.json',
      fitnessPngName: 'assets/img/hamusutoring.PNG',
      fitnessName: 'ワイド・スクワット',
      fitnessTags: '太もも'),
  FitnessModel(
      fitnessId: 3,
      fitnessLottieName: 'assets/Lottie/hutomomo3.json',
      fitnessPngName: 'assets/img/hamusutoring.PNG',
      fitnessName: '足上げスクワット',
      fitnessTags: '太もも'),
  FitnessModel(
      fitnessId: 4,
      fitnessLottieName: 'assets/Lottie/hutomomo4.json',
      fitnessPngName: 'assets/img/hamusutoring.PNG',
      fitnessName: 'スクワット',
      fitnessTags: '太もも'),
  FitnessModel(
      fitnessId: 5,
      fitnessLottieName: 'assets/Lottie/hutomomo5.json',
      fitnessPngName: 'assets/img/hamusutoring.PNG',
      fitnessName: 'ハイニーズ',
      fitnessTags: '太もも')
];

List<FitnessModel> buttocks = [
  FitnessModel(
      fitnessId: 1,
      fitnessLottieName: 'assets/Lottie/oshiri.json',
      fitnessPngName: 'assets/img/oshiri.PNG',
      fitnessName: 'リバースバードドッグ',
      fitnessTags: 'お尻'),
  FitnessModel(
      fitnessId: 2,
      fitnessLottieName: 'assets/Lottie/hukkin10.json',
      fitnessPngName: 'assets/img/hukkin.png',
      fitnessName: 'ヒップリフト',
      fitnessTags: 'お尻'),
];
