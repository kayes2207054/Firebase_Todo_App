import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_integrated_todo_app/models/todo_task.dart';

void main() {
  test('TodoTask model unit test', () {
    final now = DateTime.now();
    final task = TodoTask(
      id: 'test-id-1',
      title: 'Lab Assignment',
      description: 'Complete Android and Firebase app',
      isCompleted: false,
      userId: 'user-123',
      createdAt: now,
      updatedAt: now,
    );

    expect(task.title, 'Lab Assignment');
    expect(task.description, 'Complete Android and Firebase app');
    expect(task.isCompleted, false);
    expect(task.userId, 'user-123');

    final updated = task.copyWith(isCompleted: true);
    expect(updated.isCompleted, true);
    expect(updated.title, 'Lab Assignment');
  });
}
