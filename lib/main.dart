import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tutorial demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final items = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
  ];

  final colors = [
    Colors.teal,
    Colors.red,
    Colors.blue,
    Colors.brown,
    Colors.deepPurple,
    Colors.pink,
  ];

  final random = Random();
  final GlobalKey _floatingButtonKey = GlobalKey();
  final GlobalKey _editButtonKey = GlobalKey();
  final GlobalKey _settingsButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _createTutorial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo app'),
        actions: [
          IconButton(
            key: _editButtonKey,
            onPressed: () {
              // Do nothing
            },
            icon: const Icon(
              Icons.edit,
            ),
          ),
          IconButton(
            key: _settingsButtonKey,
            onPressed: () {
              // Do nothing
            },
            icon: const Icon(
              Icons.settings,
            ),
          )
        ],
      ),
      body: ListView.separated(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final element = items[index];
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ListTile(
              title: Text('Element $element'),
              leading: SizedBox(
                width: 48.0,
                height: 48.0,
                child: ClipOval(
                  child: ColoredBox(
                    color: colors[random.nextInt(colors.length)],
                    child: Center(
                        child: Text(
                      element,
                      style: const TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )),
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Padding(
          padding: EdgeInsets.only(left: 68.0),
          child: Divider(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: _floatingButtonKey,
        onPressed: () {
          // Do nothing
        },
        tooltip: 'Floating action',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _createTutorial() async {
    final targets = [
      TargetFocus(
        identify: 'floatingButton',
        keyTarget: _floatingButtonKey,
        alignSkip: Alignment.topCenter,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) => Text(
              'Use this button to add new elements to the list',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: 'editButton',
        keyTarget: _editButtonKey,
        alignSkip: Alignment.bottomCenter,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Text(
              'You can edit the entries by pressing on the edit button',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: 'settingsButton',
        keyTarget: _settingsButtonKey,
        alignSkip: Alignment.bottomCenter,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Text(
              'Configure the app in the settings screen',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    ];

    final tutorial = TutorialCoachMark(
      targets: targets,
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      tutorial.show(context: context);
    });
  }
}
