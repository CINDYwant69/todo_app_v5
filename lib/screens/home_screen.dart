import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/todo.dart';
import '../providers/todo_provider.dart';
import '../widgets/todo_item.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do App'),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          return ListView.builder(
            itemCount: todoProvider.todos.length,
            itemBuilder: (context, index) {
              final todo = todoProvider.todos[index];
              return TodoItem(
                todo: todo,
                onToggle: () => todoProvider.toggleTodoStatus(todo.id!),
                onEdit: () => _editTodo(context, todoProvider, todo),
                onDelete: () => todoProvider.deleteTodo(todo.id!),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTodo(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _addTodo(BuildContext context) {
    final textController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add To-Do'),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(hintText: 'Enter your task'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (textController.text.isNotEmpty) {
                  final todo = Todo(
                    id: DateTime.now().millisecondsSinceEpoch,
                    title: textController.text,
                  );
                  Provider.of<TodoProvider>(context, listen: false).addTodo(todo);
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _editTodo(BuildContext context, TodoProvider todoProvider, Todo todo) {
    final textController = TextEditingController(text: todo.title);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit To-Do'),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(hintText: 'Edit your task'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (textController.text.isNotEmpty) {
                  todoProvider.updateTodo(todo.id!, textController.text);
                  Navigator.pop(context);
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}