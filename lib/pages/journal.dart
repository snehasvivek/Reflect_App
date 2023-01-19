import 'package:flutter/material.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({super.key, required this.title});

  final String title;

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      // display prompt of the day
      Expanded(
          child: Container(
        margin: const EdgeInsets.only(left: 25, top: 20, bottom: 20, right: 25),
        child: Center(
          child: Text(
            "what is the best thing that happened today?",
            style: TextStyle(
              fontSize: 40,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      )),
      Center(
        child: SizedBox(
          width: 400,
          child: TextField(
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                hintText: 'reflect on today',
                hintStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.grey)),
                suffixIcon: IconButton(
                  onPressed: () {
                    // clear text box
                    _textController.clear();
                  },
                  icon: const Icon(Icons.clear),
                )),
            maxLines: null,
          ),
        ),
      )
    ]));
  }
}
