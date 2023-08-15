import 'package:flutter/material.dart';
import 'package:indian_constitution_quizmaster/main.dart';

class AnswerSheet extends StatelessWidget {
  const AnswerSheet({super.key});

  @override
  Widget build(BuildContext context) {
    Map routeData = ModalRoute.of(context)?.settings.arguments as Map;

    List<int> mcqsIndex = routeData['mcqsIndex'];
    List<String> userAns = routeData["userAns"];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Answer Sheet"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: mcqsIndex.length,
                itemBuilder: (context, index) {
                  bool rightAns =
                      userAns[index] == mcqs[mcqsIndex[index]].answer;

                  return ListTile(
                    leading: Icon(
                      (rightAns) ? Icons.check : Icons.cancel_outlined,
                      color: (rightAns) ? Colors.green : Colors.red,
                    ),
                    title: Text("Q ${index + 1}. ${mcqs[mcqsIndex[index]].question}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!rightAns)
                          Text(
                            "Your Ans. ${getAnswer(mcqsIndex[index], userAns[index])}",
                            style: const TextStyle(color: Colors.red),
                          ),
                        Text(
                          "Ans. ${getAnswer(mcqsIndex[index], mcqs[mcqsIndex[index]].answer)}",
                          style: const TextStyle(color: Colors.green),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Theme.of(context).colorScheme.inverseSurface,
                    indent: 5,
                    endIndent: 5,
                    height: 10,
                    thickness: 0.625,
                  );
                },
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              layoutBehavior: ButtonBarLayoutBehavior.constrained,
              children: [
                FilledButton.icon(
                  style: const ButtonStyle(
                    shape: MaterialStatePropertyAll(BeveledRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    )),
                    fixedSize: MaterialStatePropertyAll(Size.fromWidth(160)),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.home),
                  label: const Text("Home"),
                ),
                FilledButton.icon(
                  style: const ButtonStyle(
                    shape: MaterialStatePropertyAll(BeveledRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    )),
                    fixedSize: MaterialStatePropertyAll(Size.fromWidth(160)),
                  ),
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed('/examPage'),
                  icon: const Icon(Icons.replay),
                  label: const Text("Retry"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getAnswer(int index, String option) {
    switch (option) {
      case "A":
        return mcqs[index].optionA;
      case "B":
        return mcqs[index].optionB;
      case "C":
        return mcqs[index].optionC;
      case "D":
        return mcqs[index].optionD;
      default:
        return "Not Found";
    }
  }
}
