import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:indian_constitution_quizmaster/answer_sheet.dart';
import 'package:indian_constitution_quizmaster/exampage.dart';
import 'package:indian_constitution_quizmaster/homepage.dart';
import 'package:indian_constitution_quizmaster/mcq.dart';
import 'package:indian_constitution_quizmaster/practicepage.dart';
import 'package:indian_constitution_quizmaster/question-bank.dart';
import 'package:indian_constitution_quizmaster/resultpage.dart';
import 'package:indian_constitution_quizmaster/splashscreen.dart';

final List<MCQ> mcqs = [];

class IndianConstitutionQuizMaster extends StatelessWidget {
  const IndianConstitutionQuizMaster({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Indian Constitution QuizMaster',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/splashScreen',
      routes: {
        "/splashScreen": (context) => const SplashScreen(),
        "/homePage": (context) => const HomePage(),
        '/questionBank': (context) => const QuestionBank(),
        '/practicePage': (context) => const PracticePage(),
        '/examPage': (context) => const ExamPage(),
        '/resultPage': (context) => const ResultPage(),
        '/answerSheet': (context) => const AnswerSheet(),
      },
    );
  }
}

void main() {
  runApp(const IndianConstitutionQuizMaster());
  loadQuestion();
}

Future<void> loadQuestion() async {
  mcqs.clear();

  Excel excel = Excel.decodeBytes(
    (await rootBundle.load('assets/questions/Indian Constitution.xlsx'))
        .buffer
        .asUint8List(),
  );

  for (var sheet in excel.tables.keys) {
    for (var row in excel.tables[sheet]!.rows) {
      mcqs.add(
        MCQ(
          row[0]?.value.toString() ?? "Question",
          row[1]?.value.toString() ?? "Option A",
          row[2]?.value.toString() ?? "Option B",
          row[3]?.value.toString() ?? "Option C",
          row[4]?.value.toString() ?? "Option D",
          row[5]?.value.toString() ?? "Answer",
        ),
      );
    }
  }

  // Sorting the MCQ alphabetically based on question
  mcqs.sort((a, b) => a.question.compareTo(b.question));
}
