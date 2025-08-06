part of 'projects.dart';

class ProjectService extends GetxController {
  static ProjectService get to => Get.find();

  static ProjectService get put => Get.put(ProjectService());

  static String get key => 'projects';

  final Uuid uuid = Uuid();

  final GetStorage storage = GetStorage();
  final RxList<ProjectModel> projects = <ProjectModel>[].obs;

  Future<void> fetchProjects() async {
    await 2.seconds.delay();
    final rawProjects = storage.read<List<dynamic>>(key);
    if (rawProjects != null) {
      projects.value = rawProjects
          .map((e) => ProjectModel.fromJson(e))
          .toList();
    }
  }

  Future<void> addProject({required String name, String? description}) async {
    await 2.seconds.delay();
    projects.add(
      ProjectModel(
        id: uuid.v4(),
        name: name,
        description: description,
        createdAt: DateTime.now(),
        lastOpened: DateTime.now(),
        tasks: [],
      ),
    );
    await storage.write(key, projects.map((e) => e.toJson()).toList());
  }

  Future<void> deleteProject(String id) async {
    await 1.seconds.delay();
    projects.removeWhere((element) => element.id == id);
    await storage.write(key, projects.map((e) => e.toJson()).toList());
  }

  Future<void> updateProject(
    String id, {
    String? name,
    String? description,
  }) async {
    await 2.seconds.delay();
    final project = projects.firstWhereOrNull((element) => element.id == id);
    final index = projects.indexWhere((element) => element.id == id);
    if (project == null || index == -1) {
      throw ErrorResponse(message: 'Project not found');
    }
    projects[index] = project.copyWith(
      name: name ?? project.name,
      description: description ?? project.description,
    );
    await storage.write(key, projects.map((e) => e.toJson()).toList());
  }

  Future<(ProjectModel, List<Task>)> openProject(String id) async {
    await 2.seconds.delay();
    final project = projects.firstWhereOrNull((element) => element.id == id);
    if (project == null) {
      throw ErrorResponse(message: 'Project not found');
    }
    project.lastOpened = DateTime.now();
    await storage.write(key, projects.map((e) => e.toJson()).toList());
    List<Task> tasks = await TaskService.to.fetchProjectTasks(id);
    return (project, tasks);
  }
}
