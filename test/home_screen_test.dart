import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import '../lib/models/task.dart';

void main() {
  test('Task serialization and deserialization', () {
    Task task = Task(title: 'Test Task', isCompleted: false);

    String json = jsonEncode(task.toMap());
    expect(json, '{"title":"Test Task","isCompleted":false}');

    Task deserializedTask = Task.fromMap(jsonDecode(json));
    expect(deserializedTask.title, 'Test Task');
    expect(deserializedTask.isCompleted, false);
  });
}
