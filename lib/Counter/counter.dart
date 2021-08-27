import 'package:flutter/material.dart';

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("StatelessWidget");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Center(
        child: Container(
          child: Counter(),
        ),
      ),
    );
  }
}

class Counter extends StatefulWidget {
  _CounterState createState() => _CounterState();
}

class _CounterState extends State {
  late double val;

  void initState() {
    print("initState");
    super.initState();
    val = 0;
  }

  void change() {
    print("setState");
    setState(() {
      val += 1;
    });
  }

  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text('$val'))),
            MaterialButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => change(),
            ),
          ],
        ),
      ),
    );
  }
}