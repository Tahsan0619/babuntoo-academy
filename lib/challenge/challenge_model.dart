class Problem {
  final String title;
  final String language; // 'C' or 'Python'
  final List<MCQQuestion> questions;

  Problem({required this.title, required this.language, required this.questions});
}

class MCQQuestion {
  final String prompt;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  MCQQuestion({
    required this.prompt,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}
