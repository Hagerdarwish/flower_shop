class UserProfileModel {
  final String idUser;
  final String name;
  final String phone;
  final String address;
  final String deviceToken;

  const UserProfileModel({
    required this.idUser,
    required this.name,
    required this.phone,
    required this.address,
    required this.deviceToken,
  });

  /// Convert Model -> Firestore JSON
  Map<String, dynamic> toJson() {
    return {
      "id_user": idUser,
      "name": name,
      "phone": phone,
      "address": address,
      "deviceToken": deviceToken,
    };
  }

  /// Convert Firestore JSON -> Model
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      idUser: json["id_user"] ?? "",
      name: json["name"] ?? "",
      phone: json["phone"] ?? "",
      address: json["address"] ?? "",
      deviceToken: json["deviceToken"] ?? "",
    );
  }

  /// Optional: copyWith (very useful)
  UserProfileModel copyWith({
    String? idUser,
    String? name,
    String? phone,
    String? address,
    String? deviceToken,
  }) {
    return UserProfileModel(
      idUser: idUser ?? this.idUser,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      deviceToken: deviceToken ?? this.deviceToken,
    );
  }
}
