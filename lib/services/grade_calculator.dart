class GradeCalculator {
  static double calculateGrade({
    required double vize,
    required double araSinav,
    double? finalExam,
    required double gecmeNotu,

    required double vizePercent,
    required double araSinavPercent,
    required double finalPercent,
  }) {
    double totalPercent = vizePercent + araSinavPercent + finalPercent;
    if (totalPercent == 0) return 0;
    double normalizedVize = vizePercent / totalPercent;
    double normalizedAraSinav = araSinavPercent / totalPercent;
    double normalizedFinal = finalPercent / totalPercent;
    double currentScore =
        (vize * normalizedVize) + (araSinav * normalizedAraSinav);
    if (finalExam != null) {
      return currentScore + (finalExam * normalizedFinal);
    } else {
      double requiredScore = (gecmeNotu - currentScore) / normalizedFinal;
      return requiredScore;
    }
  }
}
