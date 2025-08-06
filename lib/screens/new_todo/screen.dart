import 'package:flutter/material.dart';
import 'package:todolo/route/route.dart';

class NewTodoScreen extends RouteFulWidget {
  const NewTodoScreen({super.key});

  static NewTodoScreen get route => const NewTodoScreen();

  @override
  State<NewTodoScreen> createState() => _NewTodoScreenState();

  @override
  String path() => '/new-todo';

  @override
  String title() => 'New Todo';
}

class _NewTodoScreenState extends State<NewTodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Hero(
          tag: const ValueKey('new-todo'),
          child: CloseButton(key: const ValueKey('new-todo')),
        ),
        title: Text('Add Todo'),
      ),
    );
  }
}
