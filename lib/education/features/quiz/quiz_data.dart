import 'package:flutter/foundation.dart';

/// Basic quiz entities with immutable models for reliability. [web:63][web:72]
@immutable
class QuizOption {
  final String id;
  final String text;
  final bool isCorrect;

  const QuizOption({
    required this.id,
    required this.text,
    required this.isCorrect,
  });
}

@immutable
class QuizQuestion {
  final String id;
  final String text;
  final List<QuizOption> options;
  final String explanation;

  const QuizQuestion({
    required this.id,
    required this.text,
    required this.options,
    required this.explanation,
  });
}

class QuizRepository {
  const QuizRepository();

  List<QuizQuestion> getQuestions() {
    return const [
      QuizQuestion(
        id: 'q1',
        text: "Which model is primarily used to structure learning objectives from lower- to higher-order thinking?",
        options: [
          QuizOption(id: 'q1_a', text: "Bloom's Taxonomy", isCorrect: true),
          QuizOption(id: 'q1_b', text: 'Constructivism', isCorrect: false),
          QuizOption(id: 'q1_c', text: 'ARCS Model', isCorrect: false),
          QuizOption(id: 'q1_d', text: 'ADDIE Model', isCorrect: false),
        ],
        explanation:
        "Bloom's Taxonomy organizes cognitive objectives from basic recall to complex creation, helping structure outcomes and assessments.",
      ),
      QuizQuestion(
        id: 'q2',
        text: 'Which model best fits a project-based learning course where students build solutions to real engineering problems?',
        options: [
          QuizOption(id: 'q2_a', text: 'Behaviorism', isCorrect: false),
          QuizOption(id: 'q2_b', text: 'Constructivism', isCorrect: true),
          QuizOption(id: 'q2_c', text: 'ARCS Model', isCorrect: false),
          QuizOption(id: 'q2_d', text: 'ADDIE Model', isCorrect: false),
        ],
        explanation:
        'Constructivism emphasizes active knowledge construction through authentic tasks, collaboration, and reflection, which matches project-based learning.',
      ),
      QuizQuestion(
        id: 'q3',
        text: 'You want to keep students motivated in a tough circuits course. Which model focuses directly on learner motivation?',
        options: [
          QuizOption(id: 'q3_a', text: "Bloom's Taxonomy", isCorrect: false),
          QuizOption(id: 'q3_b', text: 'Constructivism', isCorrect: false),
          QuizOption(id: 'q3_c', text: 'ARCS Model', isCorrect: true),
          QuizOption(id: 'q3_d', text: 'ADDIE Model', isCorrect: false),
        ],
        explanation:
        'The ARCS model focuses on Attention, Relevance, Confidence, and Satisfaction to design motivating learning experiences.',
      ),
      QuizQuestion(
        id: 'q4',
        text: 'Which model describes a step-by-step instructional design process from analysis to evaluation?',
        options: [
          QuizOption(id: 'q4_a', text: 'Constructivism', isCorrect: false),
          QuizOption(id: 'q4_b', text: 'ARCS Model', isCorrect: false),
          QuizOption(id: 'q4_c', text: 'ADDIE Model', isCorrect: true),
          QuizOption(id: 'q4_d', text: "Bloom's Taxonomy", isCorrect: false),
        ],
        explanation:
        'The ADDIE model includes Analyze, Design, Develop, Implement, and Evaluate as stages in course and materials design.',
      ),
      QuizQuestion(
        id: 'q5',
        text: 'Drill-and-practice exercises with instant feedback on basic calculations most closely align with which perspective?',
        options: [
          QuizOption(id: 'q5_a', text: 'Behaviorism', isCorrect: true),
          QuizOption(id: 'q5_b', text: 'Constructivism', isCorrect: false),
          QuizOption(id: 'q5_c', text: 'ARCS Model', isCorrect: false),
          QuizOption(id: 'q5_d', text: "Bloom's Taxonomy", isCorrect: false),
        ],
        explanation:
        'Behaviorism focuses on observable behavior changes reinforced through practice, feedback, and rewards.',
      ),
    ];
  }
}
