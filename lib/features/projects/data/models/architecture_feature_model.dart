// PATH: lib/features/projects/data/models/architecture_feature_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio/features/projects/domain/entities/architecture_feature.dart';

part 'architecture_feature_model.freezed.dart';
part 'architecture_feature_model.g.dart';

@freezed
abstract class ArchitectureFeatureModel with _$ArchitectureFeatureModel {
  const factory ArchitectureFeatureModel({
    required String title,
    required String description,
    required String icon,
  }) = _ArchitectureFeatureModel;

  const ArchitectureFeatureModel._();

  factory ArchitectureFeatureModel.fromJson(Map<String, dynamic> json) =>
      _$ArchitectureFeatureModelFromJson(json);

  factory ArchitectureFeatureModel.fromEntity(ArchitectureFeature entity) {
    return ArchitectureFeatureModel(
      title: entity.title,
      description: entity.description,
      icon: entity.icon,
    );
  }

  ArchitectureFeature toEntity() {
    return ArchitectureFeature(
      title: title,
      description: description,
      icon: icon,
    );
  }
}
