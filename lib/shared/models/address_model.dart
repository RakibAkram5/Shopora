class AddressModel {
  final String id;
  final String fullName;
  final String phone;
  final String address;
  final String city;
  final String area;
  final String postalCode;
  final String addressType; // Home, Office, Other
  final bool isDefault;

  AddressModel({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.address,
    required this.city,
    required this.area,
    required this.postalCode,
    required this.addressType,
    this.isDefault = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'phone': phone,
      'address': address,
      'city': city,
      'area': area,
      'postalCode': postalCode,
      'addressType': addressType,
      'isDefault': isDefault,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map, {String id = ''}) {
    return AddressModel(
      id: map['id'] ?? id,
      fullName: map['fullName'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      city: map['city'] ?? '',
      area: map['area'] ?? '',
      postalCode: map['postalCode'] ?? '',
      addressType: map['addressType'] ?? 'Home',
      isDefault: map['isDefault'] ?? false,
    );
  }
}
