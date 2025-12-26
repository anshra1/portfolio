import 'package:equatable/equatable.dart';

class ArchitectureFeature extends Equatable {
  const ArchitectureFeature({
    required this.title,
    required this.description,
    required this.icon,
  });
  
  final String title;
  final String description;
  final String icon;

  @override
  List<Object?> get props => [title, description, icon];
}
