import 'package:equatable/equatable.dart';
import 'package:portfolio/features/homepage/skill.dart';

class Profile extends Equatable {
  const Profile({
    required this.bio,
    required this.avatarAsset,
    required this.email,
    required this.githubUrl,
    required this.linkedinUrl,
    required this.mediumUrl,
    required this.skills,
  });

  final String bio;
  final String avatarAsset;
  final String email;
  final String githubUrl;
  final String linkedinUrl;
  final String mediumUrl;
  final List<Skill> skills;

  @override
  List<Object?> get props => [
    bio,
    avatarAsset,
    email,
    githubUrl,
    linkedinUrl,
    mediumUrl,
    skills,
  ];
}
