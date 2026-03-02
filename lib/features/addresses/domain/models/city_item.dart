class CityItem {
  final String id;
  final String nameEn;
  final String nameAr;

  CityItem({required this.id, required this.nameEn, required this.nameAr});

  factory CityItem.fromJson(Map<String, dynamic> json) {
    return CityItem(
      id: (json['id'] ?? '').toString(),
      nameEn: (json['governorate_name_en'] ?? '').toString(),
      nameAr: (json['governorate_name_ar'] ?? '').toString(),
    );
  }
}
