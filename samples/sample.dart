// Dart + Flutter sample: class, mixin, async, widget
import 'dart:async';
import 'package:flutter/material.dart';

const int maxCount = 10;
const String appName = "Sample App";

enum Status { idle, loading, done }

mixin Loggable {
  void log(String message) => print('[LOG] $message');
}

abstract class Shape {
  double area();
}

class Rect extends Shape with Loggable {
  final double width;
  final double height;

  Rect(this.width, this.height);

  @override
  double area() {
    log("Calculating area");
    return width * height;
  }
}

class User {
  final String name;
  int? age;

  User({required this.name, this.age});

  String get label => age == null ? name : '$name (${age!} years old)';
}

Future<List<User>> fetchUsers({int limit = 5}) async {
  await Future.delayed(const Duration(milliseconds: 300));
  final users = <User>[
    User(name: "Alex", age: 21),
    User(name: "Sara"),
  ];
  return users.take(limit).toList();
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _count = 0;

  void _increment() {
    setState(() {
      if (_count < maxCount) _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appName)),
      body: Center(
        child: Text('Count: $_count', style: const TextStyle(fontSize: 24)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}

void main() {
  final rect = Rect(3, 4.5);
  print('Area: ${rect.area()}');
  runApp(const MaterialApp(home: CounterPage()));
}
