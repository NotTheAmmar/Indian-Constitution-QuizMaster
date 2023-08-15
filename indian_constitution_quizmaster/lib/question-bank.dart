import 'package:flutter/material.dart';
import 'package:indian_constitution_quizmaster/main.dart';

class QuestionBank extends StatelessWidget {
  const QuestionBank({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Question Bank"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.5),
        child: ListView.separated(
          itemCount: mcqs.length,
          itemBuilder: (context, index) {
            String answer;

            switch (mcqs[index].answer) {
              case "A":
                answer = mcqs[index].optionA;
                break;
              case "B":
                answer = mcqs[index].optionB;
                break;
              case "C":
                answer = mcqs[index].optionC;
                break;
              case "D":
                answer = mcqs[index].optionD;
                break;
              default:
                answer = "Unknown";
            }

            return Card(
              elevation: 2.5,
              shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              shadowColor: Theme.of(context).colorScheme.shadow,
              surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Q${index + 1}. ${mcqs[index].question}",
                      style: const TextStyle(fontSize: 20),
                    ),
                    Divider(
                      color: Theme.of(context).colorScheme.inverseSurface,
                      endIndent: 250,
                      height: 5,
                      thickness: 0.625,
                    ),
                  ],
                ),
                subtitle: Text(
                  "Ans. $answer",
                  style: const TextStyle(color: Colors.black54, fontSize: 15),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 2.5),
        ),
      ),
    );
  }
}
