import 'package:equatable/equatable.dart';

class TrackStep extends Equatable {
  const TrackStep({
    required this.title,
    required this.subtitle,
    required this.isDone,
    required this.isActive,
  });

  final String title;
  final String subtitle;
  final bool isDone;
  final bool isActive;

  TrackStep copyWith({
    String? title,
    String? subtitle,
    bool? isDone,
    bool? isActive,
  }) {
    return TrackStep(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      isDone: isDone ?? this.isDone,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props => [title, subtitle, isDone, isActive];
}
