import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:animated_list_plus/transitions.dart';
import 'package:extension_helpers/extension_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tinycolor2/tinycolor2.dart';
import 'package:todolo/logic/logic.dart';
import 'package:todolo/main.dart';
import 'package:todolo/route/route.dart';
import 'package:todolo/screens/empty/page.dart';
import 'package:todolo/screens/error/page.dart';
import 'package:todolo/screens/project/dialogs/edit_project.dart';
import 'package:todolo/screens/project/dialogs/edit_task.dart';
import 'package:todolo/screens/project/dialogs/new_task.dart';
import 'package:jiffy/jiffy.dart';

class ProjectScreen extends RouteFulWidget {
  const ProjectScreen({super.key});

  static ProjectScreen get route => const ProjectScreen();

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();

  @override
  String path() => '/project';

  @override
  String title() => 'Project';
}

class _ProjectScreenState extends State<ProjectScreen> {
  late final ProjectModel project;
  final _projectService = ProjectService.to;
  final _taskService = TaskService.to;
  late Future<(ProjectModel, List<Task>)> fetchProjectAndTask;
  final ScrollController scrollController = ScrollController();

  bool _showCompleted = false;

  @override
  void initState() {
    super.initState();
    final raw = Get.arguments['project'];
    if (raw is ProjectModel) {
      project = raw;
    } else {
      Get.back();
    }
    fetchProjectAndTask = _projectService.openProject(project.id);
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirm Deletion'),
            content: const Text('Are you sure you want to delete this item?'),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Get.back(result: false),
              ),
              ElevatedButton(
                child: const Text('Delete'),
                onPressed: () => Get.back(result: true),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Tasks'),
        centerTitle: true,
        actions: [
          Row(
            children: [
              Text('Show Completed', style: context.textTheme.bodySmall),
              Switch(
                value: _showCompleted,
                onChanged: (val) {
                  setState(() {
                    _showCompleted = val;
                  });
                },
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final bool? didAdd = await showAdaptiveDialog(
            context: context,
            requestFocus: true,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return NewTaskDialog(project: project);
            },
          );
          if (didAdd == true) {
            try {
              scrollController.jumpTo(scrollController.offset);
            } catch (_) {}
            setState(() {
              fetchProjectAndTask = _projectService.openProject(project.id);
            });
          }
        },
        heroTag: const ValueKey('new-todo'),
        child: Icon(LucideIcons.plus),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Project Name: ${project.name.capitalize}',
            style: context.textTheme.headlineMedium,
          ),
          10.cl(10, 20).hSpacer,
          if ((project.description ?? '').isNotEmpty)
            Text(
              project.description ?? '',
              style: context.textTheme.bodySmall,
            ).contain(
              padding: 10.cl(10, 20).pdAll,
              decoration: BoxDecoration(
                color: context.theme.scaffoldBackgroundColor.darken(10),
                borderRadius: 10.cl(10, 20).brcAll,
              ),
            ),
          20.cl(20, 40).hSpacer,
          Text('Tasks', style: context.textTheme.headlineMedium),
          10.cl(10, 20).hSpacer,
          FutureBuilder(
            future: fetchProjectAndTask,
            builder:
                (
                  BuildContext context,
                  AsyncSnapshot<(ProjectModel, List<Task>)> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator().center;
                  } else if (snapshot.hasError) {
                    return ErrorPage(
                      refresh: () async {
                        setState(() {
                          fetchProjectAndTask = _projectService.openProject(
                            project.id,
                          );
                        });
                      },
                      content: 'Error fetching project tasks',
                    );
                  } else {
                    final data = snapshot.data!;
                    List<Task> filteredTasks = _showCompleted
                        ? data.$2.where((t) => t.completedAt != null).toList()
                        : data.$2.where((t) => t.completedAt == null).toList();
                    if (filteredTasks.isEmpty) {
                      return EmptyPage(type: PageType.task);
                    }
                    filteredTasks.sort(
                      (a, b) => b.createdAt.compareTo(a.createdAt),
                    );
                    return RefreshIndicator(
                      onRefresh: () async {
                        setState(() {
                          fetchProjectAndTask = _projectService.openProject(
                            project.id,
                          );
                        });
                      },
                      child: ImplicitlyAnimatedList<Task>(
                        items: filteredTasks,
                        controller: scrollController,
                        areItemsTheSame: (a, b) => a.id == b.id,
                        itemBuilder: (BuildContext context, animation, item, index) {
                          return SizeFadeTransition(
                            sizeFraction: 0.7,
                            curve: Curves.easeInOut,
                            animation: animation,
                            child:
                                Slidable(
                                  key: ValueKey(item.id),
                                  endActionPane: ActionPane(
                                    motion: const BehindMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) async {
                                          final confirmed =
                                              await showAdaptiveDialog(
                                                context: context,
                                                requestFocus: true,
                                                barrierDismissible: true,
                                                builder:
                                                    (BuildContext context) {
                                                      return EditTaskDialog(
                                                        project: project,
                                                        task: item,
                                                      );
                                                    },
                                              );
                                          if (confirmed) {
                                            setState(() {
                                              fetchProjectAndTask =
                                                  _projectService.openProject(
                                                    project.id,
                                                  );
                                            });
                                          }
                                        },
                                        backgroundColor: Colors.green,
                                        foregroundColor: Colors.white,
                                        icon: Icons.edit,
                                        label: 'Edit',
                                      ),
                                      SlidableAction(
                                        onPressed: (context) async {
                                          final confirmed =
                                              await _confirmDelete(context);
                                          if (confirmed) {
                                            _taskService.deleteTask(item.id);
                                            setState(() {
                                              fetchProjectAndTask =
                                                  _projectService.openProject(
                                                    project.id,
                                                  );
                                            });
                                          }
                                        },
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    key: ValueKey(item.id),
                                    titleTextStyle: context.textTheme.bodySmall,
                                    subtitleTextStyle: context
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: appTheme.palette.textColorLight
                                              .withAlpha(170),
                                        ),
                                    title: Text(
                                      item.title.capitalize ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                    ),
                                    iconColor: context.theme.primaryColor,
                                    trailing: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (item.dueDate.compareTo(
                                              DateTime.now(),
                                            ) >
                                            0)
                                          Text(
                                            'Due In',
                                            style: context.textTheme.bodySmall,
                                          )
                                        else
                                          Text(
                                            'Overdue',
                                            style: context.textTheme.bodySmall,
                                          ),
                                        Text(
                                          Jiffy.parseFromDateTime(
                                            item.dueDate,
                                          ).fromNow(withPrefixAndSuffix: false),
                                          style: context.textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                    onLongPress: () {
                                      context.toast(
                                        toastMessage: 'Slide to edit or delete',
                                        type: ToastSnackBarType.notify,
                                        duration: 1500.milliseconds,
                                      );
                                    },
                                    onTap: () async {
                                      final isCompleted =
                                          item.completedAt != null;
                                      final confirm = await showDialog<bool>(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(
                                            isCompleted
                                                ? 'Mark as Incomplete?'
                                                : 'Mark as Complete?',
                                          ),
                                          content: Text(
                                            isCompleted
                                                ? 'Do you want to mark this task as incomplete?'
                                                : 'Do you want to mark this task as complete?',
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.of(
                                                context,
                                              ).pop(false),
                                              child: const Text('Cancel'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () => Navigator.of(
                                                context,
                                              ).pop(true),
                                              child: Text(
                                                isCompleted
                                                    ? 'Mark Incomplete'
                                                    : 'Mark Complete',
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                      if (confirm == true) {
                                        await _taskService.toggleTaskCompleted(
                                          item.id,
                                        );
                                        setState(() {
                                          fetchProjectAndTask = _projectService
                                              .openProject(project.id);
                                        });
                                      }
                                    },
                                    contentPadding: 10.cl(10, 20).pdAll,
                                    subtitle: item.content.isNotEmpty.whenOnly(
                                      use: Text(
                                        item.content,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                    ),
                                    leading: Text(
                                      item.priority.value.toUpperCase(),
                                      style: context.textTheme.bodySmall
                                          ?.copyWith(
                                            color: Priority.low == item.priority
                                                ? appTheme.palette.warning
                                                : Priority.medium ==
                                                      item.priority
                                                ? appTheme.palette.info
                                                : appTheme.palette.error,
                                          ),
                                    ),
                                  ),
                                ).contain(
                                  margin: 10.cl(10, 20).pdB,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    color: context.theme.primaryColor.withAlpha(
                                      20,
                                    ),
                                    borderRadius: 10.cl(10, 20).brcAll,
                                  ),
                                ),
                          );
                        },
                        removeItemBuilder: (context, animation, oldItem) {
                          return FadeTransition(
                            opacity: animation,
                            child: Text(oldItem.title),
                          );
                        },
                      ).contain(width: 100.w, height: 101.h, padding: 10.cl(10, 40).pdX).scrollable(),
                    );
                  }
                },
          ).expand,
        ],
      ).contain(width: 100.w, height: 100.h, padding: 15.cl(10, 30).pdAll),
      bottomNavigationBar:
          Row(
            children: [
              TextButton(
                onPressed: () {
                  showAdaptiveDialog(
                    context: context,
                    requestFocus: true,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return EditProjectDialog(project: project);
                    },
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith((val) {
                    if (val.contains(WidgetState.disabled)) {
                      if (context.isDarkMode) {
                        return appTheme.palette.success
                            .lighten(55)
                            .withAlpha(40);
                      }
                      return appTheme.palette.success.lighten(55);
                    }
                    if (val.contains(WidgetState.hovered)) {
                      if (context.isDarkMode) {
                        return appTheme.palette.success
                            .lighten(45)
                            .withAlpha(40);
                      }
                      return appTheme.palette.success.lighten(45);
                    }
                    if (val.contains(WidgetState.focused) ||
                        val.contains(WidgetState.pressed)) {
                      if (context.isDarkMode) {
                        return appTheme.palette.success
                            .lighten(40)
                            .withAlpha(40);
                      }
                      return appTheme.palette.success.lighten(40);
                    }
                    if (context.isDarkMode) {
                      return appTheme.palette.success.lighten(50).withAlpha(40);
                    }
                    return appTheme.palette.success.lighten(50);
                  }),
                  overlayColor: appTheme.palette.success
                      .darken(10)
                      .withValues(alpha: 0.2)
                      .all,
                  foregroundColor: appTheme.palette.success.all,
                  surfaceTintColor: appTheme.palette.success
                      .withValues(alpha: 0.2)
                      .all,
                  iconColor: Colors.white.all,
                ),
                child: Text('Edit'),
              ).expand,
              15.cl(10, 30).wSpacer,
              TextButton(
                onPressed: () async {
                  final confirmed = await _confirmDelete(context);
                  if (confirmed) {
                    _projectService.deleteProject(project.id);
                    Get.back(result: true);
                    if (context.mounted) {
                      context.toast(
                        toastMessage: 'Project deleted successfully',
                        type: ToastSnackBarType.success,
                      );
                    }
                  }
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith((val) {
                    if (val.contains(WidgetState.disabled)) {
                      if (context.isDarkMode) {
                        return appTheme.palette.error.lighten(45).withAlpha(40);
                      }
                      return appTheme.palette.error.lighten(45);
                    }
                    if (val.contains(WidgetState.hovered)) {
                      if (context.isDarkMode) {
                        return appTheme.palette.error.lighten(35).withAlpha(40);
                      }
                      return appTheme.palette.error.lighten(35);
                    }
                    if (val.contains(WidgetState.focused) ||
                        val.contains(WidgetState.pressed)) {
                      if (context.isDarkMode) {
                        return appTheme.palette.error.lighten(30).withAlpha(40);
                      }
                      return appTheme.palette.error.lighten(30);
                    }
                    if (context.isDarkMode) {
                      return appTheme.palette.error.lighten(40).withAlpha(40);
                    }
                    return appTheme.palette.error.lighten(40);
                  }),
                  overlayColor: appTheme.palette.error
                      .darken(10)
                      .withValues(alpha: 0.2)
                      .all,
                  foregroundColor: appTheme.palette.error.all,
                  surfaceTintColor: appTheme.palette.error
                      .withValues(alpha: 0.2)
                      .all,
                  iconColor: Colors.white.all,
                ),
                child: Text('Delete'),
              ).expand,
            ],
          ).contain(
            margin: context.mediaQueryPadding.bottom.pdB,
            padding: 15.cl(10, 30).pdX,
          ),
    );
  }
}
