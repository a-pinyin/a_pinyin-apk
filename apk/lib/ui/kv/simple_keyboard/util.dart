List<List<String>> cutList(List<String> raw, int len) {
  final result = <List<String>>[];
  for (var i = 0; i < raw.length; i += len) {
    result.add(raw.sublist(i, i + len));
  }
  return result;
}
