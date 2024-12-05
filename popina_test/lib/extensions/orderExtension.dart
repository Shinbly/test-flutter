extension ListExtension<T> on List<T> {
  /// this function will return true if the two lists are equal in length in value and in order
  bool deepEquals(List<T> other, {bool Function(T a, T b)? areEqual}) {
    if (length != other.length) {
      print(" the length of the two lists are different");
      return false;
    }

    for (var i = 0; i < length; i++) {
      if (areEqual == null
          ? this[i] != other[i]
          : !areEqual(this[i], other[i])) {
        print(
            "the two lists are different at index $i : ${this[i]} != ${other[i]}");
        return false;
      }
    }

    return true;
  }
}
