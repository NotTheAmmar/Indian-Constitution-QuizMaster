import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:indian_constitution_quizmaster/custom_widgets.dart';
import 'package:indian_constitution_quizmaster/main.dart';

class ExamPage extends StatefulWidget {
  const ExamPage({super.key});

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  bool _examStarted = false;
  int _currQues = 0, _sec = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Exam"),
        actions: (_examStarted)
            ? [
                Text("$_currQues / 40 "),
                const SizedBox(width: 5),
                Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.yellow,
                  ),
                  padding: const EdgeInsets.all(2.5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.timer),
                      Text(" $_sec s"),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
              ]
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.5),
        child: (_examStarted)
            ? Exam(
                quesSecIndicatorSetter: (value) => setState(() {
                  _currQues = value.$1 + 1;
                  _sec = value.$2;
                }),
              )
            : InstructionCard(
                callback: () => setState(() => _examStarted = true),
              ),
      ),
    );
  }
}

class InstructionCard extends StatelessWidget {
  final Function _callback;

  const InstructionCard({
    super.key,
    required Function callback,
  }) : _callback = callback;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Card(
        elevation: 5,
        color: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
        shadowColor: Theme.of(context).colorScheme.shadow,
        shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Instructions", style: TextStyle(fontSize: 40)),
              const SizedBox(height: 10),
              const Text(
                "• All The MCQs in the Question Bank are included in this exam.",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              const Text(
                "• 40 Questions are asked in the exam at random, out of which 16 Questions are required to be answered correctly to pass the exam.",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              const Text(
                "• 90 seconds are allowed to answer each question (total 1 hour).",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              FilledButton(
                style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(BeveledRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  )),
                  fixedSize: MaterialStatePropertyAll(Size.fromWidth(400)),
                ),
                onPressed: () => _callback(),
                child: const Text("Start Exam"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Exam extends StatefulWidget {
  final ValueSetter<(int, int)> quesSecIndicatorSetter;

  const Exam({
    super.key,
    required this.quesSecIndicatorSetter,
  });

  @override
  State<Exam> createState() => _ExamState();
}

class _ExamState extends State<Exam> {
  int _currentIndex = 0, _sec = 90, _score = 0;
  final List<int> _mcqsIndex = [];
  final List<String> _userAns = [];
  Timer _timer = Timer(Duration.zero, () {});

  @override
  void initState() {
    super.initState();

    while (_mcqsIndex.length < 40) {
      int mcqIndex = Random(DateTime.now().millisecondsSinceEpoch)
          .nextInt(mcqs.length - 1);

      if (!_mcqsIndex.contains(mcqIndex)) {
        _mcqsIndex.add(mcqIndex);
      }
    }

    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
      shadowColor: Theme.of(context).colorScheme.shadow,
      shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mcqs[_mcqsIndex[_currentIndex]].question,
              style: const TextStyle(fontSize: 20),
            ),
            Divider(
              color: Theme.of(context).colorScheme.inverseSurface,
              indent: 5,
              endIndent: 5,
              height: 10,
              thickness: 0.625,
            ),
            OptionTile(
              onTap: () => selectOption("A"),
              optionType: "A",
              option: mcqs[_mcqsIndex[_currentIndex]].optionA,
              titleColor: getTitleColor("A"),
            ),
            Divider(
              color: Theme.of(context).colorScheme.inverseSurface,
              indent: 5,
              endIndent: 5,
              height: 10,
              thickness: 0.625,
            ),
            OptionTile(
              onTap: () => selectOption("B"),
              optionType: "B",
              option: mcqs[_mcqsIndex[_currentIndex]].optionB,
              titleColor: getTitleColor("B"),
            ),
            Divider(
              color: Theme.of(context).colorScheme.inverseSurface,
              indent: 5,
              endIndent: 5,
              height: 10,
              thickness: 0.625,
            ),
            OptionTile(
              onTap: () => selectOption("C"),
              optionType: "C",
              option: mcqs[_mcqsIndex[_currentIndex]].optionC,
              titleColor: getTitleColor("C"),
            ),
            Divider(
              color: Theme.of(context).colorScheme.inverseSurface,
              indent: 5,
              endIndent: 5,
              height: 10,
              thickness: 0.625,
            ),
            OptionTile(
              onTap: () => selectOption("D"),
              optionType: "D",
              option: mcqs[_mcqsIndex[_currentIndex]].optionD,
              titleColor: getTitleColor("D"),
            ),
          ],
        ),
      ),
    );
  }

  void startTimer() {
    _sec = 90;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_sec > 0) {
          _sec--;
          widget.quesSecIndicatorSetter((_currentIndex, _sec));
        } else {
          setState(() {
            _userAns.add("");

            if (_currentIndex >= 39) {
              Navigator.of(context).pushReplacementNamed(
                '/resultPage',
                arguments: {
                  "score": _score,
                  "mcqsIndex": _mcqsIndex,
                  "userAns": _userAns,
                },
              );
            } else {
              _currentIndex++;
            }

            _sec = 90;
          });
        }
      },
    );
  }

  void selectOption(String option) {
    if (!_timer.isActive) return;

    _timer.cancel();
    setState(() {
      if (mcqs[_mcqsIndex[_currentIndex]].answer == option) _score++;

      _userAns.add(option);
    });

    Future.delayed(const Duration(milliseconds: 750), () {
      if (_currentIndex >= 39) {
        Navigator.of(context).pushReplacementNamed(
          '/resultPage',
          arguments: {
            "score": _score,
            "mcqsIndex": _mcqsIndex,
            "userAns": _userAns,
          },
        );
      } else {
        setState(() {
          _currentIndex++;
        });
        widget.quesSecIndicatorSetter((_currentIndex, _sec));
      }

      startTimer();
    });
  }

  Color? getTitleColor(String option) {
    if (_userAns.isEmpty) return null;
    if (_currentIndex >= _userAns.length) return null;

    if (_userAns[_currentIndex] == mcqs[_mcqsIndex[_currentIndex]].answer) {
      if (_userAns[_currentIndex] == option) {
        return Colors.green;
      } else {
        return null;
      }
    } else {
      if (_userAns[_currentIndex] == option) {
        return Colors.red;
      } else {
        return null;
      }
    }
  }
}
