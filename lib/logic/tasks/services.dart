part of 'tasks.dart';

class TaskService extends GetxController {
  static TaskService get to => Get.find<TaskService>();

  static TaskService get put => Get.put(TaskService());

  static String get key => 'tasks';

  final GetStorage storage = GetStorage();
  final Uuid uuid = Uuid();

  final RxList<Task> tasks = <Task>[].obs;

  Future<void> addTask({
    required String title,
    required String content,
    required String projectId,
    required DateTime dueDate,
    required Priority priority,
  }) async {
    await 2.seconds.delay();
    tasks.add(
      Task(
        id: uuid.v4(),
        title: title,
        content: content,
        projectId: projectId,
        createdAt: DateTime.now(),
        lastUpdated: DateTime.now(),
        priority: priority,
        dueDate: dueDate,
        status: 'pending',
      ),
    );
    await storage.write(key, tasks.map((e) => e.toJson()).toList());
  }

  Future<void> deleteTask(String id) async {
    tasks.removeWhere((element) => element.id == id);
    await storage.write(key, tasks.map((e) => e.toJson()).toList());
  }

  Future<void> toggleTaskCompleted(String id) async {
    await 2.seconds.delay();
    final task = tasks.firstWhereOrNull((element) => element.id == id);
    final index = tasks.indexWhere((element) => element.id == id);
    if (task == null || index == -1) {
      throw ErrorResponse(message: 'Task not found');
    }
    tasks[index] = task.copyWith(
      completedAt: task.completedAt == null ? DateTime.now() : null,
    );
    await storage.write(key, tasks.map((e) => e.toJson()).toList());
  }

  Future<void> updateTask(
    String id, {
    String? title,
    String? content,
    String? projectId,
    DateTime? dueDate,
    Priority? priority,
  }) async {
    await 2.seconds.delay();
    final task = tasks.firstWhereOrNull((element) => element.id == id);
    final index = tasks.indexWhere((element) => element.id == id);
    if (task == null || index == -1) {
      throw ErrorResponse(message: 'Task not found');
    }
    tasks[index] = task.copyWith(
      title: title ?? task.title,
      content: content ?? task.content,
      projectId: projectId ?? task.projectId,
      dueDate: dueDate ?? task.dueDate,
      priority: priority ?? task.priority,
    );
    await storage.write(key, tasks.map((e) => e.toJson()).toList());
  }

  Future<void> updateTaskStatus(String id, String status) async {
    await 2.seconds.delay();
    final task = tasks.firstWhereOrNull((element) => element.id == id);
    final index = tasks.indexWhere((element) => element.id == id);
    if (task == null || index == -1) {
      throw ErrorResponse(message: 'Task not found');
    }
    tasks[index] = task.copyWith(status: status);
    await storage.write(key, tasks.map((e) => e.toJson()).toList());
  }

  Future<void> updateTaskPriority(String id, Priority priority) async {
    await 2.seconds.delay();
    final task = tasks.firstWhereOrNull((element) => element.id == id);
    final index = tasks.indexWhere((element) => element.id == id);
    if (task == null || index == -1) {
      throw ErrorResponse(message: 'Task not found');
    }
    tasks[index] = task.copyWith(priority: priority);
    await storage.write(key, tasks.map((e) => e.toJson()).toList());
  }

  Future<List<Task>> fetchProjectTasks(String projectId) async {
    final projectTasks = tasks
        .where((task) => task.projectId == projectId)
        .toList();
    return projectTasks;
  }
}
