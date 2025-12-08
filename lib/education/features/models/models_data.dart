import 'package:flutter/foundation.dart';

/// Core entity for an education/learning model.
/// Immutable and simple so it’s safe to reuse across the app. [web:47][web:51]
@immutable
class LearningModel {
  final String id;
  final String name;
  final String shortName;
  final String description;
  final List<String> keyPrinciples;
  final List<String> typicalUses;
  final List<String> strengths;
  final List<String> limitations;
  final String category; // e.g. "Cognitive", "Constructivist", "Behaviorist"
  final String levelFocus; // e.g. "Higher-order thinking", "Motivation"

  const LearningModel({
    required this.id,
    required this.name,
    required this.shortName,
    required this.description,
    required this.keyPrinciples,
    required this.typicalUses,
    required this.strengths,
    required this.limitations,
    required this.category,
    required this.levelFocus,
  });
}

/// In a later version you can replace this with local JSON or an API. [web:45][web:57]
class ModelsRepository {
  const ModelsRepository();

  /// Returns all available learning models.
  List<LearningModel> getAllModels() {
    // For now this is hardcoded mock data.
    // Keep the data clean and small so it’s fast in production. [web:45][web:55]
    return const [
      LearningModel(
        id: 'blooms_taxonomy',
        name: "Bloom's Taxonomy",
        shortName: 'Bloom',
        description:
        'A hierarchical classification of learning objectives used to design outcomes, activities, and assessments.',
        keyPrinciples: [
          'Organize objectives from lower- to higher-order thinking',
          'Align teaching activities and assessments with levels',
          'Support gradual progression in cognitive complexity',
        ],
        typicalUses: [
          'Writing measurable learning outcomes',
          'Designing exam questions with different difficulty levels',
          'Structuring engineering lab tasks from basic to advanced',
        ],
        strengths: [
          'Gives clear language for learning outcomes',
          'Helps balance easy and challenging tasks',
          'Widely recognized in education and accreditation contexts',
        ],
        limitations: [
          'Can be applied mechanically without deep thinking',
          'Not a complete theory of how students actually learn',
        ],
        category: 'Cognitive',
        levelFocus: 'Cognitive levels of learning',
      ),
      LearningModel(
        id: 'constructivism',
        name: 'Constructivism',
        shortName: 'Constructivism',
        description:
        'An approach where learners actively construct knowledge through experience, reflection, and collaboration.',
        keyPrinciples: [
          'Learners build on prior knowledge',
          'Active engagement and problem-solving are central',
          'Social interaction and discussion support understanding',
        ],
        typicalUses: [
          'Project-based learning in engineering courses',
          'Open-ended lab investigations',
          'Team design challenges and hackathons',
        ],
        strengths: [
          'Promotes deep understanding instead of rote memorization',
          'Develops problem-solving and collaboration skills',
        ],
        limitations: [
          'Planning and facilitation can be time-consuming',
          'Students may feel lost without enough structure',
        ],
        category: 'Constructivist',
        levelFocus: 'Active knowledge construction',
      ),
      LearningModel(
        id: 'behaviorism',
        name: 'Behaviorism',
        shortName: 'Behaviorism',
        description:
        'A view of learning focused on observable behavior change through reinforcement and practice.',
        keyPrinciples: [
          'Learning is shaped by rewards and feedback',
          'Clear, measurable behaviors define success',
          'Frequent practice strengthens desired behaviors',
        ],
        typicalUses: [
          'Drill-and-practice for calculations or formulas',
          'Automated quizzes with instant feedback',
          'Skill checklists in lab safety training',
        ],
        strengths: [
          'Works well for basic skills and procedures',
          'Easy to track progress using observable behaviors',
        ],
        limitations: [
          'Less suited for creativity or complex problem-solving',
          'Does not directly address internal thinking processes',
        ],
        category: 'Behaviorist',
        levelFocus: 'Observable skill and behavior change',
      ),
      LearningModel(
        id: 'addie',
        name: 'ADDIE Model',
        shortName: 'ADDIE',
        description:
        'A systematic instructional design process with phases: Analyze, Design, Develop, Implement, Evaluate.',
        keyPrinciples: [
          'Start with needs and learner analysis',
          'Iteratively design, develop, and test learning materials',
          'Use evaluation data to improve instruction',
        ],
        typicalUses: [
          'Designing an entire engineering course or module',
          'Planning an online lab or simulation',
          'Structuring curriculum development projects',
        ],
        strengths: [
          'Gives a clear step-by-step design workflow',
          'Helps manage complex course design projects',
        ],
        limitations: [
          'Can feel rigid if followed without iteration',
          'May be slow if used very formally for small tasks',
        ],
        category: 'Instructional design',
        levelFocus: 'Systematic course design process',
      ),
      LearningModel(
        id: 'arcs',
        name: 'ARCS Motivation Model',
        shortName: 'ARCS',
        description:
        'A model for designing instruction that keeps learners motivated using Attention, Relevance, Confidence, and Satisfaction.',
        keyPrinciples: [
          'Capture and sustain learner attention',
          'Connect content to learner goals and context',
          'Build confidence with achievable challenges',
          'Give satisfying feedback and recognition',
        ],
        typicalUses: [
          'Designing engaging introductions to engineering topics',
          'Structuring feedback in online learning platforms',
          'Improving motivation in large lecture courses',
        ],
        strengths: [
          'Focuses directly on learner motivation',
          'Works well with other models like Bloom or ADDIE',
        ],
        limitations: [
          'Requires thoughtful design of activities and feedback',
          'Motivation depends on many external factors too',
        ],
        category: 'Motivational',
        levelFocus: 'Learner motivation and engagement',
      ),
    ];
  }

  /// Get a model by id, or null if not found.
  LearningModel? getModelById(String id) {
    try {
      return getAllModels().firstWhere((m) => m.id == id);
    } catch (_) {
      return null;
    }
  }
}
