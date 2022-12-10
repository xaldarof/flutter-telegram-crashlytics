import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exception_handler/di/lib_di.dart';
import 'package:flutter_exception_handler/tcrash_reporter.dart';
import 'package:flutter_exception_handler/telegram_bot_sender.dart';

import 'cache/lib_database.dart';

void main() async {
  initDependencies();
  var reporter = TCrashReporter();
  reporter.init('5790685024:AAHvA1nscE5-85-6N9nlWHDfl36DiS4GeUA', "827790539");
  reporter.scope(() {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final LibDatabase database = injector.get<LibDatabase>();

  void _throwTestException() async {
    throw Exception("error");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: _throwTestException,
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
