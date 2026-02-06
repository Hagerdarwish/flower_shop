class TextStyleDto {
  final double? fontSize;
  final String? fontWeight;
  final String? color;
  final dynamic textAlign;
  final String? backgroundColor;

  TextStyleDto({
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.backgroundColor,
  });

  factory TextStyleDto.fromJson(Map<String, dynamic> json) {
    return TextStyleDto(
      fontSize: (json['fontSize'] != null)
          ? (json['fontSize'] as num).toDouble()
          : null,
      fontWeight: json['fontWeight'] as String?,
      color: json['color'] as String?,
      textAlign: json['textAlign'],
      backgroundColor: json['backgroundColor'] as String?,
    );
  }
}
