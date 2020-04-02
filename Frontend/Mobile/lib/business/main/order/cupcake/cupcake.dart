class Cupcake {
  String _base;
  String _frosting;
  String _topping;

  Cupcake(
    this._base,
    this._frosting,
    this._topping
  );

  String getBase() {
    return _base;
  }

  String getFrosting() {
    return _frosting;
  }

  String getTopping() {
    return _topping;
  }

  void setBase(String base) {
    _base = base;
  }

  void setFrosting(String frosting) {
    _frosting = frosting;
  }

  void setTopping(String topping) {
    _topping = topping;
  }
}
