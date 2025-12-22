class ChangePasswordEntity {
  final String message;
  final String? token;
  final int? code;

  const ChangePasswordEntity({
    required this.message,
    this.token,
    this.code,
  });
}