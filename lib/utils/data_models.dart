import 'package:flutter/material.dart';

// Data model for main menu options
class MenuOption {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget destinationPage;

  MenuOption(
      this.icon,
      this.title,
      this.subtitle,
      this.destinationPage,
      );
}

// Example PC hardware model
class HardwareDevice {
  final String name;
  final String description;
  final String imageAssetPath;
  final String history; // <--- Add this!

  HardwareDevice({
    required this.name,
    required this.description,
    required this.imageAssetPath,
    required this.history,
  });
}

// Example PC software model
class SoftwareItem {
  final String name;
  final String version;
  final String description;
  final String? website;
  final String logoAssetPath;  // New optional field for logo image path or URL

  SoftwareItem({
    required this.name,
    required this.version,
    required this.description,
    this.website,
    required this.logoAssetPath,
  });
}
// Programming language/project model
class ProgrammingProject {
  final String language;
  final String projectTitle;
  final String description;
  final String codeSnippet;

  ProgrammingProject({
    required this.language,
    required this.projectTitle,
    required this.description,
    required this.codeSnippet,
  });
}

// scientist_models.dart

class Scientist {
  final String name;
  final String birthYear;
  final String deathYear;
  final String contribution;
  final String imageAssetPath;
  final String region; // "Asia", "Europe", etc.
  final List<TimelineEvent> timeline;

  Scientist({
    required this.name,
    required this.birthYear,
    required this.deathYear,
    required this.contribution,
    required this.imageAssetPath,
    required this.region,
    required this.timeline,
  });
}

class TimelineEvent {
  final String year;
  final String event;

  TimelineEvent({required this.year, required this.event});
}


// Progress tracking model
class ProgressData {
  final String section;
  final bool completed;
  final double completionPercent;

  ProgressData({
    required this.section,
    required this.completed,
    required this.completionPercent,
  });
}
