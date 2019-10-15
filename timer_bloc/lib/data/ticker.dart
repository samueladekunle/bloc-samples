class Ticker {
  Stream<int> tick({ int ticks }) {
    return Stream.periodic(Duration(seconds: 1), (int x) => ticks - x - 1).take(ticks);
  }
}