import 'package:cloud_firestore/cloud_firestore.dart';

class TodoTask {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  TodoTask({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TodoTask.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return TodoTask(
      id: doc.id,
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      isCompleted: data['isCompleted'] as bool? ?? false,
      userId: data['userId'] as String? ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'userId': userId,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  TodoTask copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TodoTask(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
