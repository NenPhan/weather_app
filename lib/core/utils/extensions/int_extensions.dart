extension IntExt on num {
  Duration get seconds => Duration(seconds: toInt());
  Duration get miliSeconds => Duration(milliseconds: toInt());
  Duration get minutes => Duration(minutes: toInt());
  Future delayed() => Future.delayed(Duration(seconds: toInt()));
}
