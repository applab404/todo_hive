import 'package:hive/hive.dart';
import '../models/todo.dart';

class HiveService {
  late final Box<Todo> _todoBox;
  late final Box _settingsBox;

  Future<void> init() async {
    _todoBox = await Hive.openBox<Todo>('todos');
    _settingsBox = await Hive.openBox('settings');
  }

  List<Todo> getTodos() => _todoBox.values.toList();

  Future<void> saveTodos(List<Todo> todos) async {
    await _todoBox.clear();
    for (final todo in todos) {
      await _todoBox.add(todo);
    }
  }

  bool getThemeMode() =>
      _settingsBox.get('isDarkMode', defaultValue: false) as bool;

  Future<void> setThemeMode(bool isDarkMode) async {
    await _settingsBox.put('isDarkMode', isDarkMode);
  }

  Future<void> clearAll() async {
    await _todoBox.clear();
    await _settingsBox.clear();
  }
}
