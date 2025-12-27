// ignore_for_file: public_member_api_docs, sort_constructors_first
class GradeModel {
  final double vize;
  final double araSinav;
  final double finalExam;
  final double gecmeNotu;
  final double vizePercent;
  final double araSinavPercent;
  final double finalPercent;

  GradeModel(
    this.vizePercent,
    this.araSinavPercent,
    this.finalPercent, {
    required this.vize,
    required this.araSinav,
    required this.finalExam,
    required this.gecmeNotu,
  });
}
