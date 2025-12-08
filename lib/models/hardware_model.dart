import 'hardware_component_model.dart';

class HardwareModel {
  final String id;
  final String name;
  final String logoAssetPath;
  final String basicInfo;
  final String inventorName;
  final String inventorPhotoAssetPath;
  final int yearInvented;
  final String origin;
  final String evolution;
  final List<TypeVariant> typeVariants;
  final List<HardwareComponent> components;
  final String workingFlowAssetPath;
  final List<String> technologiesUsed;
  final String connectivityAndCompatibility;
  final String trivia;

  HardwareModel({
    required this.id,
    required this.name,
    required this.logoAssetPath,
    required this.basicInfo,
    required this.inventorName,
    required this.inventorPhotoAssetPath,
    required this.yearInvented,
    required this.origin,
    required this.evolution,
    required this.typeVariants,
    required this.components,
    required this.workingFlowAssetPath,
    required this.technologiesUsed,
    required this.connectivityAndCompatibility,
    required this.trivia,
  });
}

class TypeVariant {
  final String imageAssetPath;
  final String description;

  TypeVariant({
    required this.imageAssetPath,
    required this.description,
  });
}
