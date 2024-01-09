import 'package:flutter/material.dart';

import 'dart:async';

void main() {
  runApp(pomodoro());
}

class pomodoro extends StatelessWidget {
  const pomodoro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: const Color(0xFFE7626C),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color(0xFF232B55),
          ),
        ),
        cardColor: const Color(0xFFF4EDDB),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const TwentyFiveMin = 10;
  int totalSec = TwentyFiveMin;
  bool isRun = true;
  int success = 0;
  late Timer timer;

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2);
  }

  void onTick(Timer timer) {
    if (totalSec == 0) {
      setState(() {
        isRun = !isRun;
        success += 1;
        totalSec = TwentyFiveMin;
      });
      timer.cancel();
    } else {
      setState(
        () {
          totalSec -= 1;
        },
      );
    }
    ;
  }

  void onStartPressed() {
    setState(() {
      isRun = !isRun;
    });
    timer = Timer.periodic(Duration(seconds: 1), onTick);
  }

  void onPausePressed() {
    setState(() {
      isRun = !isRun;
    });
    timer.cancel();
  }

  void replayTimer() {
    setState(() {
      isRun = !isRun;
      totalSec = TwentyFiveMin;
    });
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSec),
                style: TextStyle(
                    color: Theme.of(context).cardColor,
                    fontSize: 89,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (isRun)
                      ? IconButton(
                          onPressed: onStartPressed,
                          icon: Icon(Icons.play_circle_fill_outlined),
                          iconSize: 150,
                          color: Theme.of(context).cardColor,
                        )
                      : IconButton(
                          onPressed: onPausePressed,
                          icon: Icon(Icons.stop_circle_outlined),
                          iconSize: 150,
                          color: Theme.of(context).cardColor,
                        ),
                  (isRun)
                      ? SizedBox()
                      : IconButton(
                          onPressed: replayTimer,
                          icon: Icon(Icons.replay_rounded),
                          iconSize: 150,
                          color: Theme.of(context).cardColor,
                        )
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodoros',
                          style: TextStyle(
                            fontSize: 20,
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                          ),
                        ),
                        Text(
                          '$success',
                          style: TextStyle(
                            fontSize: 60,
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
