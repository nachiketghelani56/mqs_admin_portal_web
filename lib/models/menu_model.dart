class MenuModel {
  final String icon;
  final String title;
  final List<String> subtitles;

  MenuModel(
      {required this.icon, required this.title, this.subtitles = const []});
}
