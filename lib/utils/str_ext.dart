extension StringExt on String {
  String ellipsize(int count) {
    if (length > count) {
      return substring(0, count);
    } else {
      return this;
    }
  }
}
