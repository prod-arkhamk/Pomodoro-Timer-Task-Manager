import 'dart:io';

void loadTasksFromFile(List<String> tasks, String filename) {
  try {
    var file = File(filename);
    if (file.existsSync()) {
      tasks.addAll(file.readAsLinesSync());
    }
  } catch (e) {
    print('Error loading tasks from file: $e');
  }
}

void saveTasksToFile(List<String> tasks, String filename) {
  try {
    var file = File(filename);
    file.writeAsStringSync(tasks.join('\n'));
  } catch (e) {
    print('Error saving tasks to file: $e');
  }
}
