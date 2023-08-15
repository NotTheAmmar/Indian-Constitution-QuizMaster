import 'package:flutter/material.dart';
import 'package:indian_constitution_quizmaster/custom_widgets.dart';
import 'package:indian_constitution_quizmaster/main.dart';

class PracticePage extends StatefulWidget {
  const PracticePage({super.key});

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  final List<String> _userAns = List.generate(mcqs.length, (index) => '');
  int _currentIndex = 0, _rightAns = 0, _wrongAns = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Practice"),
        actions: [
          InkResponse(
            splashColor: Theme.of(context).colorScheme.secondary,
            splashFactory: InkSparkle.splashFactory,
            onTap: () {
              showDialog(
                context: context,
                builder: (popUpContext) => _QuestionChangePopUp(
                  currIndexGetter: () => _currentIndex,
                  currIndexSetter: (value) => setState(() {
                    _currentIndex = value;
                  }),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text("${_currentIndex + 1} / ${mcqs.length}"),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
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
                Text(
                  mcqs[_currentIndex].question,
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
                  option: mcqs[_currentIndex].optionA,
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
                  option: mcqs[_currentIndex].optionB,
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
                  option: mcqs[_currentIndex].optionC,
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
                  option: mcqs[_currentIndex].optionD,
                  titleColor: getTitleColor("D"),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: ShapeDecoration(
          shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        padding: const EdgeInsets.all(2.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            (_currentIndex > 0)
                ? FilledButton.icon(
                    style: const ButtonStyle(
                      shape: MaterialStatePropertyAll(BeveledRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      )),
                    ),
                    onPressed: () => setState(() {
                      _currentIndex--;
                    }),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text("Previous"),
                  )
                : const SizedBox(width: 125),
            RichText(
              text: TextSpan(
                text: "$_rightAns ✓",
                style: const TextStyle(fontSize: 15, color: Colors.green),
                children: [
                  TextSpan(
                    text: " | ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  TextSpan(
                    text: "$_wrongAns ✕",
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
            (_currentIndex < (mcqs.length - 1))
                ? FilledButton.icon(
                    style: const ButtonStyle(
                      shape: MaterialStatePropertyAll(BeveledRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      )),
                    ),
                    onPressed: () => setState(() {
                      _currentIndex++;
                    }),
                    label: const Icon(Icons.arrow_forward),
                    icon: const Text("Next"),
                  )
                : const SizedBox(width: 125),
          ],
        ),
      ),
    );
  }

  void selectOption(String option) {
    if (_userAns[_currentIndex].isNotEmpty) return;

    setState(() {
      (mcqs[_currentIndex].answer == option) ? _rightAns++ : _wrongAns++;
      _userAns[_currentIndex] = option;
    });
  }

  Color? getTitleColor(String option) {
    if (_userAns[_currentIndex].isEmpty) return null;

    if (_userAns[_currentIndex] == mcqs[_currentIndex].answer) {
      if (_userAns[_currentIndex] == option) {
        return Colors.green;
      } else {
        return null;
      }
    } else {
      if (option == mcqs[_currentIndex].answer) {
        return Colors.green;
      } else if (_userAns[_currentIndex] == option) {
        return Colors.red;
      } else {
        return null;
      }
    }
  }
}

class _QuestionChangePopUp extends StatelessWidget {
  final ValueGetter<int> currIndexGetter;
  final ValueSetter<int> currIndexSetter;

  const _QuestionChangePopUp({
    required this.currIndexGetter,
    required this.currIndexSetter,
  });

  @override
  Widget build(BuildContext context) {
    int newIndex = currIndexGetter();

    return AlertDialog(
      title: const Text("Go to Question Number"),
      content: StatefulBuilder(
        builder: (context, setState) {
          return TextField(
            onChanged: (value) => setState(() {
              int index = int.parse(value);

              if (index <= mcqs.length && !index.isNegative) {
                newIndex = index;
              } else if (index > mcqs.length) {
                newIndex = mcqs.length;
              } else {
                newIndex = -1;
              }
            }),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Question Number"),
          );
        },
      ),
      actions: [
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Back"),
        ),
        FilledButton(
          onPressed: () {
            currIndexSetter(newIndex - 1);
            Navigator.of(context).pop();
          },
          child: const Text("Go"),
        ),
      ],
    );
  }
}
