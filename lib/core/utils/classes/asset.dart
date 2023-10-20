class Assets {
  static ImageAsset images = ImageAsset();
  static LottieAsset lotties = LottieAsset();
}

class ImageAsset {
  ImageAsset();
  var path = 'assets/images/';
}

class LottieAsset {
  LottieAsset();
  String path = 'assets/lotties/';

  String get loading => '${path}loading.json';
  String get rain => '${path}rain.json';
  String get wind => '${path}wind.json';
}
