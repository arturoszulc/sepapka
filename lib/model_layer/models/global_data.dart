class GlobalData {
  int questions1Version;
  int questions2Version;
  int questions3Version;
  List<String> rankNames;
  List<int> rankThresholds;

  GlobalData(
      {required this.questions1Version,
      required this.questions2Version,
      required this.questions3Version,
      required this.rankNames,
      required this.rankThresholds});
}
