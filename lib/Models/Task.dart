class Task {
  final String name;
  bool isChecked;

  Task({required this.name, this.isChecked = false});

  void taskDone() {
    isChecked = !isChecked;
  }
}
