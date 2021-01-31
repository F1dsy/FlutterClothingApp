class SelectionHandler<T> {
  SelectionHandler(this._setState);
  Function _setState;
  bool _isSelectable = false;
  List<T> _selectedList = [];

  List<T> get selectedList {
    return _selectedList;
  }

  bool get isSelectable {
    return _isSelectable;
  }

  void toggleSelection(T item) {
    _setState(() {
      if (!_isSelectable) {
        _isSelectable = true;
      }
      if (_selectedList.contains(item)) {
        _selectedList.remove(item);
        if (_selectedList.isEmpty) {
          _isSelectable = false;
        }
      } else {
        _selectedList.add(item);
      }
    });
  }

  void reset() {
    _setState(() {
      _isSelectable = false;
      _selectedList = [];
    });
  }
}
