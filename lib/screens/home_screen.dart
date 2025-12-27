import 'package:flutter/material.dart';
import 'package:not_hesapla/components/point_percent_widget.dart';
import 'package:not_hesapla/services/grade_calculator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController vize = TextEditingController();
  TextEditingController araSinav = TextEditingController();
  TextEditingController finalExam = TextEditingController();
  TextEditingController gecmeNotu = TextEditingController(text: "50");
  TextEditingController vizePercent = TextEditingController(text: "30");
  TextEditingController araSinavPercent = TextEditingController(text: "30");
  TextEditingController finalPercent = TextEditingController(text: "40");

  @override
  void dispose() {
    vize.dispose();
    araSinav.dispose();
    finalExam.dispose();
    gecmeNotu.dispose();
    vizePercent.dispose();
    araSinavPercent.dispose();
    finalPercent.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _clearInputs();
  }

  void _handleCalculation() {
    double vizeNotu = double.tryParse(vize.text) ?? 0;
    double araSinavNotu = double.tryParse(araSinav.text) ?? 0;
    double gecme = double.tryParse(gecmeNotu.text) ?? 50;

    double vizeYuzde = double.tryParse(vizePercent.text) ?? 0;
    double araSinavYuzde = double.tryParse(araSinavPercent.text) ?? 0;
    double finalYuzde = double.tryParse(finalPercent.text) ?? 0;

    double? finalNotu = finalExam.text.isEmpty
        ? null
        : double.tryParse(finalExam.text);
    double sonuc = GradeCalculator.calculateGrade(
      vize: vizeNotu,
      araSinav: araSinavNotu,
      gecmeNotu: gecme,
      vizePercent: vizeYuzde,
      araSinavPercent: araSinavYuzde,
      finalPercent: finalYuzde,
    );
    _showResultDialog(sonuc);
    _clearInputs();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Not Hesaplama",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade700, Colors.blue.shade50],
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isWideScreen ? 500 : double.infinity,
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(isWideScreen ? 20.0 : 16.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.all(isWideScreen ? 24.0 : 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Sınav Notlarınız",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Notlarınızı ve yüzdelerini girin",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),

                      PointPercentWidget(
                        label: "Vize",
                        controller: vize,
                        percentController: vizePercent,
                      ),

                      const SizedBox(height: 16),
                      PointPercentWidget(
                        label: "Ara Sınav",
                        controller: araSinav,
                        percentController: araSinavPercent,
                      ),

                      const SizedBox(height: 16),
                      PointPercentWidget(
                        label: "Final",
                        controller: finalExam,
                        percentController: finalPercent,
                      ),

                      const Divider(height: 30, thickness: 2),

                      Text(
                        "Geçme Koşulu",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),

                      PointPercentWidget(
                        label: "Geçme Notu",
                        controller: gecmeNotu,
                      ),

                      const SizedBox(height: 24),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                        ),
                        onPressed: _handleCalculation,
                        child: const Text(
                          "Hesapla",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),
                      Text(
                        "* Yüzdeler toplamı 100 olmalıdır",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showResultDialog(double sonuc) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final passed = sonuc <= 0;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(
                passed ? Icons.check_circle : Icons.school,
                color: passed ? Colors.green : Colors.blue.shade700,
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  passed ? "Tebrikler!" : "Hedef Notunuz",
                  style: TextStyle(
                    color: passed ? Colors.green : Colors.blue.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              passed
                  ? "Dersten başarıyla geçtiniz! "
                  : "Finalden en az ${sonuc.toStringAsFixed(1)} almanız gerekiyor.",
              style: const TextStyle(fontSize: 16),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Tamam",
                style: TextStyle(fontSize: 16, color: Colors.blue.shade700),
              ),
            ),
          ],
        );
      },
    );
  }

  void _clearInputs() {
    vize.clear();
    araSinav.clear();
    finalExam.clear();
    gecmeNotu.clear();
    vizePercent.clear();
    araSinavPercent.clear();
    finalPercent.clear();
  }
}
