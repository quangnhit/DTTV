extension ListGetExtension<T> on List<T> {
  T? tryGet(int index) => index < 0 || index >= length ? null : this[index];

  T? getIndex(int index) => length > index ? this[index] : null;
}
