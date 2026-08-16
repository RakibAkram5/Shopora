class BannerModel {
  final String id;
  final String title;
  final String subtitle;
  final String image;
  final String buttonText;
  final String categoryId;

  BannerModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.buttonText,
    required this.categoryId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'image': image,
      'buttonText': buttonText,
      'categoryId': categoryId,
    };
  }

  factory BannerModel.fromMap(Map<String, dynamic> map, String id) {
    return BannerModel(
      id: id,
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      image: map['image'] ?? '',
      buttonText: map['buttonText'] ?? 'Shop Now',
      categoryId: map['categoryId'] ?? '',
    );
  }
}
