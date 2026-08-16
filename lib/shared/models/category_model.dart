class CategoryModel {
  final String id;
  final String name;
  final String image;
  final String icon;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.icon,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'icon': icon,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map, String id) {
    return CategoryModel(
      id: id,
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      icon: map['icon'] ?? '',
    );
  }
}
