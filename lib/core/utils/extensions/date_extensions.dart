extension DateTimeExt on DateTime {
  copyWith({int? y, int? mo, int? d, int? h, int? mi}) {
    return DateTime(
      y ?? year,
      mo ?? month,
      d ?? day,
      h ?? hour,
      mi ?? minute,
    );
  }
}
