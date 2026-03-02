class AreaItem {
  final String id;
  final String governorateId;
  final String nameAr;
  final String nameEn;

  const AreaItem({
    required this.id,
    required this.governorateId,
    required this.nameAr,
    required this.nameEn,
  });

  factory AreaItem.fromJson(Map<String, dynamic> json) {
    return AreaItem(
      id: (json['id'] ?? '').toString(),
      governorateId: (json['governorate_id'] ?? '').toString(),
      nameAr: (json['city_name_ar'] ?? '').toString(),
      nameEn: (json['city_name_en'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'governorate_id': governorateId,
    'city_name_ar': nameAr,
    'city_name_en': nameEn,
  };
}
