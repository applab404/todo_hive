import 'package:flutter/material.dart';
import 'package:todo_hive/services/hive_service.dart';
import '../../models/todo.dart';
import 'home_view.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const HomePage({super.key, required this.onToggleTheme});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final HiveService _hiveService = HiveService();
  final List<Todo> todos = List.empty(growable: true);
  final TextEditingController controller = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _hiveService.init();
    final storedTodos = _hiveService.getTodos();
    setState(() {
      todos.addAll(storedTodos);
      isLoading = false;
    });
  }

  void addTodo() {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      todos.add(Todo(title: text));
      controller.clear();
    });

    _hiveService.saveTodos(todos);
  }

  void toggleTodo(int index) {
    setState(() {
      todos[index] = todos[index].copyWith(isDone: !todos[index].isDone);
    });

    _hiveService.saveTodos(todos);
  }

  void deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });

    _hiveService.saveTodos(todos);
  }

  @override
  Widget build(BuildContext context) {
    return HomeView(state: this);
  }
}
