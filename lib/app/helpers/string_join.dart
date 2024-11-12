extension StringJoin on List<String> {
  String? joinOrNull([String separator = ""]) {
    if (isEmpty) {
      return null;
    }
    return join(separator);
  }
}
