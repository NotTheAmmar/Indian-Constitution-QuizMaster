import 'package:flutter/material.dart';
import 'package:indian_constitution_quizmaster/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final List<Widget> _cardList = [];

  @override
  void initState() {
    super.initState();

    _cardList.addAll([
      _CardListTile(
        onTap: () => Navigator.of(context).pushNamed('/questionBank'),
        imageAsset: "assets/icons/question-bank.png",
        title: "Question Bank",
        subtitle: "List of ${mcqs.length} Questions and Answers",
      ),
      _CardListTile(
        onTap: () => Navigator.of(context).pushNamed('/practicePage'),
        imageAsset: "assets/icons/practice.png",
        title: "Practice",
        subtitle: "Test your Knowledge without worrying about time",
      ),
      _CardListTile(
        onTap: () => Navigator.of(context).pushNamed('/examPage'),
        imageAsset: "assets/icons/exam.png",
        title: "Exam",
        subtitle: "Time and question bound test",
      ),
    ]);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _listKey.currentState?.insertItem(
        0,
        duration: const Duration(seconds: 1),
      );

      _listKey.currentState?.insertItem(
        1,
        duration: const Duration(seconds: 1, milliseconds: 500),
      );

      _listKey.currentState?.insertItem(
        2,
        duration: const Duration(seconds: 2),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: Image.asset("assets/icons/logo.png"),
        title: const Text(
          "Indian Constitution QuizMaster",
          style: TextStyle(fontSize: 17.5),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.5),
        child: AnimatedList(
          key: _listKey,
          itemBuilder: (context, index, animation) {
            return SizeTransition(
              sizeFactor: animation,
              child: _cardList[index],
            );
          },
        ),
      ),
    );
  }
}

class _CircularAssetImage extends StatelessWidget {
  final String asset;

  const _CircularAssetImage({required this.asset});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: AssetImage(asset), fit: BoxFit.contain),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      width: 50,
      height: 75,
    );
  }
}

class _CardListTile extends StatelessWidget {
  final Function onTap;
  final String imageAsset, title, subtitle;

  const _CardListTile({
    required this.onTap,
    required this.imageAsset,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.5,
      color: Theme.of(context).colorScheme.surface,
      shadowColor: Theme.of(context).colorScheme.shadow,
      surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: ListTile(
        onTap: () => onTap(),
        leading: _CircularAssetImage(asset: imageAsset),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 30)),
            Divider(
              color: Theme.of(context).colorScheme.inverseSurface,
              endIndent: 200,
              height: 10,
              thickness: 1.25,
            ),
          ],
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.black45, fontSize: 15),
        ),
      ),
    );
  }
}
