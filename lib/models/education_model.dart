class EducationModelSection {
  final String title;
  final List<String> points;

  EducationModelSection({
    required this.title,
    required this.points,
  });
}

class EducationModel {
  final String inventorName;
  final String yearPublished;
  final List<EducationModelSection> sections;

  EducationModel({
    required this.inventorName,
    required this.yearPublished,
    required this.sections,
  });
}
