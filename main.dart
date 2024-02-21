import 'dart:io';
import 'fileOperations.dart';

void main() {
  var tasks = <String>[];
  var completedTasks = <String>[];
  var pomodoroTime = 25;
  var breakTime = 5;
  DateTime _now = DateTime.now();

  loadTasksFromFile(tasks, 'tasks.csv');
  loadTasksFromFile(completedTasks, 'completed_tasks.csv');

  while (true) {
    print('Time right now: ${_now.hour}:${_now.minute}:${_now.second}');
    print('\n--- ToDo List with Pomodoro Timer ---');
    print('1. Add Task');
    print('2. View Tasks');
    print('3. Start Pomodoro Timer');
    print('4. View Completed Tasks');
    print('5. Delete Task');
    print('6. Exit');

    stdout.write('Enter your choice (1-6): ');
    var choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write('Enter a new task: ');
        var newTask = stdin.readLineSync();
        tasks.add(newTask!);
        saveTasksToFile(tasks, 'tasks.csv');
        print('Task added: $newTask');
        break;

      case '2':
        if (tasks.isEmpty) {
          print('No tasks added yet.');
        } else {
          print('\n--- Tasks ---');
          for (var i = 0; i < tasks.length; i++) {
            print('${i + 1}. ${tasks[i]}');
          }
        }
        break;

      case '3':
        if (tasks.isEmpty) {
          print('No tasks to work on.');
        } else {
          print('\n--- Pomodoro Timer ---');
          for (var i = 0; i < tasks.length; i++) {
            print('Task $i: ${tasks[i]}');
            startPomodoroTimer(pomodoroTime);
            completedTasks.add(tasks[i]);
            tasks.removeAt(i);
            saveTasksToFile(tasks, 'tasks.csv');
            saveTasksToFile(completedTasks, 'completed_tasks.csv');
          }
          print('\n--- Pomodoro Session Completed! ---');
        }
        break;

      case '4':
        if (completedTasks.isEmpty) {
          print('No tasks completed yet.');
        } else {
          print('\n--- Completed Tasks ---');
          for (var i = 0; i < completedTasks.length; i++) {
            print('$i. ${completedTasks[i]}');
          }
        }
        break;

      case '5':
        if (tasks.isEmpty) {
          print('No tasks to delete.');
        } else {
          print('\n--- Delete Task ---');
          for (var i = 0; i < tasks.length; i++) {
            print('${i + 1}. ${tasks[i]}');
          }
          stdout.write('Enter the task number to delete: ');
          var taskIndex = int.parse(stdin.readLineSync()!);
          if (taskIndex >= 1 && taskIndex <= tasks.length) {
            print('Task deleted: ${tasks[taskIndex - 1]}');
            tasks.removeAt(taskIndex - 1);
            saveTasksToFile(tasks, 'tasks.csv');
          } else {
            print('Invalid task number.');
          }
        }
        break;

      case '6':
        print('Exiting ToDo List with Pomodoro Timer. Goodbye!');
        exit(0);

      default:
        print('Invalid choice. Please enter a number between 1 and 6.');
        break;
    }
  }
}

void startPomodoroTimer(int minutes) {
  print('\nStarting Pomodoro Timer for $minutes minutes...');
  for (var i = minutes; i > 0; i--) {
    print('$i minutes remaining...');
    sleep(Duration(minutes: 1));
  }
  print('Pomodoro Timer completed!');
}
