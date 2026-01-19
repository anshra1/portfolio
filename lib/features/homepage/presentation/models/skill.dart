import 'package:equatable/equatable.dart';

class Skill extends Equatable {
  final String title;
  final String description;
  final String icon;

  const Skill({
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  List<Object?> get props => [title, description, icon];
}
