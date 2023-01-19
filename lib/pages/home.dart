import 'package:flutter/material.dart';
import 'journal.dart';
import 'habits.dart';
import 'meditation_timer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textController = TextEditingController();
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _navigateBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    JournalPage(title: "Journal"),
    HabitTrackerPage(title: "Habit Tracker"),
    MeditationTimerPage(title: "Meditation Timer")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 219, 181, 226),
        centerTitle: true,
        foregroundColor: Colors.black,
        title: const Text(
          'R E F L E C T',
          textAlign: TextAlign.center,
        ),
      ),
      bottomNavigationBar: NavigationBar(
          backgroundColor: Color.fromARGB(255, 219, 181, 226),
          onDestinationSelected: _navigateBar,
          selectedIndex: _selectedIndex,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.article_rounded),
              label: 'Journal',
            ),
            NavigationDestination(
              icon: Icon(Icons.add_task_rounded),
              label: 'Habits',
            ),
            NavigationDestination(
                icon: Icon(Icons.access_time_filled), label: 'Meditate'),
          ]),
      body: _pages[_selectedIndex],
    );
  }
}
