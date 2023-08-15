import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map routeData = ModalRoute.of(context)?.settings.arguments as Map;

    int score = routeData["score"];
    List<int> mcqsIndex = routeData['mcqsIndex'];
    List<String> userAns = routeData["userAns"];

    bool pass = score >= 16;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Result"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Card(
          elevation: 5,
          color: Theme.of(context).colorScheme.surface,
          surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
          shadowColor: Theme.of(context).colorScheme.shadow,
          shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
          child: Padding(
            padding: const EdgeInsets.all(2.5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  (pass) ? "Passed" : "Failed",
                  style: TextStyle(
                    fontSize: 40,
                    color: (pass) ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(height: 10),
                Text("Score: $score out of 40",
                    style: const TextStyle(fontSize: 30)),
                const SizedBox(height: 10),
                Text(
                  (pass)
                      ? "Congratulations you have passed the exam, feel to try again to test your knowledge"
                      : "Unfortunately you have failed the exam but do not worry try again, use Question Bank and practice to improve yourself further",
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FilledButton.icon(
                      style: const ButtonStyle(
                        fixedSize:
                            MaterialStatePropertyAll(Size.fromWidth(150)),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.home),
                      label: const Text("Home"),
                    ),
                    const SizedBox(width: 5),
                    FilledButton.icon(
                      onPressed: () =>
                          Navigator.of(context).pushReplacementNamed(
                        '/answerSheet',
                        arguments: {"mcqsIndex": mcqsIndex, "userAns": userAns},
                      ),
                      icon: const Icon(Icons.book),
                      label: const Text("Answer Sheet"),
                    ),
                  ],
                ),
                FilledButton.icon(
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed('/examPage'),
                  icon: const Icon(Icons.replay),
                  label: const Text("Retry"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
