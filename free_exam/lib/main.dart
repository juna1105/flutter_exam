import 'package:flutter/material.dart';

import 'package:flip_widget/flip_widget.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

const double _MinNumber = 0.008;
double _clampMin(double v) {
  if (v < _MinNumber && v > -_MinNumber) {
    if (v >= 0) {
      v = _MinNumber;
    } else {
      v = -_MinNumber;
    }
  }
  return v;
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<FlipWidgetState> _flipKey = GlobalKey();

  Offset _oldPosition = Offset.zero;
  bool _visible = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = const Size(256, 256);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: _visible,
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: GestureDetector(
                  child: FlipWidget(
                    key: _flipKey,
                    textureSize: size * 2,
                    child: Container(
                      color: Colors.blue,
                      child: const Center(
                        child: Text("hello"),
                      ),
                    ),
                    // leftToRight: true,
                  ),
                  onHorizontalDragStart: (details) {
                    _oldPosition = details.globalPosition;
                    _flipKey.currentState?.startFlip();
                  },
                  onHorizontalDragUpdate: (details) {
                    Offset off = details.globalPosition - _oldPosition;
                    double tilt = 1 / _clampMin((-off.dy + 20) / 100);
                    double percent = math.max(0, -off.dx / size.width * 1.4);
                    percent = percent - percent / 2 * (1 - 1 / tilt);
                    _flipKey.currentState?.flip(percent, tilt);
                  },
                  onHorizontalDragEnd: (details) {
                    _flipKey.currentState?.stopFlip();
                  },
                  onHorizontalDragCancel: () {
                    _flipKey.currentState?.stopFlip();
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const NextPage();
                      },
                    ));
                  },
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    _visible = !_visible;
                  });
                },
                child: const Text("Toggle"))
          ],
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: const Center(
        child: Text("hello"),
      ),
    );
  }
}
