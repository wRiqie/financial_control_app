class Category {
  late int id;
  late bool selected;

  Category({
    required this.id,
    this.selected = false,
  });

  Category.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    selected = map['selected'] == 1 ? true : false;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'selected': selected ? 1 : 0,
    };
  }
}
