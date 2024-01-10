import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'node.js api server test',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final dio = Dio();
            Response response = await dio.post("http://172.20.10.2:80", data: {
              'key0': 'i am',
              'key1': 'flutter',
            });
            print(response);
          },
          child: const Text('node.js api test'),
        ),
      ),
    );
  }
}
