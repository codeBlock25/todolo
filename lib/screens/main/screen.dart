import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:animated_list_plus/transitions.dart';
import 'package:extension_helpers/extension_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todolo/logic/logic.dart';
import 'package:todolo/main.dart';
import 'package:todolo/route/route.dart';
import 'package:get/get.dart';
import 'package:todolo/screens/empty/page.dart';
import 'package:todolo/screens/error/page.dart';
import 'package:todolo/screens/main/dialogs/new_project.dart';
import 'package:todolo/screens/screens.dart';

class MainScreen extends RouteFulWidget {
  const MainScreen({super.key});

  static MainScreen get route => const MainScreen();

  @override
  State<MainScreen> createState() => _MainScreenState();

  @override
  String path() => '/main';

  @override
  String title() => 'Main';
}

class _MainScreenState extends State<MainScreen> {
  final ProjectService _projectService = ProjectService.to;
  late Future<void> fetchProjects;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchProjects = _projectService.fetchProjects();
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
      appBar: AppBar(title: Text('Projects'), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final bool? didAdd = await showAdaptiveDialog(
            context: context,
            requestFocus: true,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return NewProjectDialog();
            },
          );
          if (didAdd == true) {
            scrollController.jumpTo(scrollController.offset);
          }
        },
        heroTag: const ValueKey('new-todo'),
        child: Icon(LucideIcons.plus),
      ),
      body: FutureBuilder<void>(
        future: fetchProjects,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator().center;
          }
          if (snapshot.hasError) {
            return ErrorPage(
              refresh: () async {
                setState(() {
                  fetchProjects = _projectService.fetchProjects();
                });
              },
              content: 'Error loading projects, please try again later.',
            );
          }
          return Obx(() {
            if (_projectService.projects.isEmpty) {
              return EmptyPage(type: PageType.project);
            }
            _projectService.projects.sort(
              (a, b) => b.lastOpened.compareTo(a.lastOpened),
            );
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  fetchProjects = _projectService.fetchProjects();
                });
              },
              child:
                  ImplicitlyAnimatedList<ProjectModel>(
                        items: _projectService.projects,
                        controller: scrollController,
                        areItemsTheSame: (a, b) => a.id == b.id,
                        itemBuilder:
                            (BuildContext context, animation, item, index) {
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
                                                  await _confirmDelete(context);
                                              if (confirmed) {
                                                await _projectService.deleteProject(
                                                  item.id,
                                                );
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
                                        titleTextStyle:
                                            context.textTheme.bodyMedium,
                                        subtitleTextStyle: context
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: appTheme
                                                  .palette
                                                  .textColorLight
                                                  .withAlpha(170),
                                            ),
                                        title: Text(
                                          item.name.capitalize ?? '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                        ),
                                        iconColor: context.theme.primaryColor,
                                        onTap: () => ProjectScreen.route.goto(
                                          arguments: {'project': item},
                                        ),
                                        onLongPress: () {
                                          context.toast(
                                            toastMessage: 'Slide to delete',
                                            type: ToastSnackBarType.notify,
                                            duration: 1500.milliseconds,
                                          );
                                        },
                                        contentPadding: 10.cl(10, 20).pdAll,
                                        subtitle: (item.description ?? '')
                                            .isNotEmpty
                                            .whenOnly(
                                              use: Text(
                                                item.description ?? '',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                              ),
                                            ),
                                        leading: Icon(LucideIcons.menu),
                                      ),
                                    ).contain(
                                      margin: 10.cl(10, 20).pdB,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        color: context.theme.primaryColor
                                            .withAlpha(20),
                                        borderRadius: 10.cl(10, 20).brcAll,
                                      ),
                                    ),
                              );
                            },
                        removeItemBuilder: (context, animation, oldItem) {
                          return FadeTransition(
                            opacity: animation,
                            child: ListTile(
                              key: ValueKey(oldItem.id),
                              titleTextStyle:
                              context.textTheme.bodyMedium,
                              subtitleTextStyle: context
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                color: appTheme
                                    .palette
                                    .textColorLight
                                    .withAlpha(170),
                              ),
                              title: Text(
                                oldItem.name.capitalize ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ),
                              iconColor: context.theme.primaryColor,
                              contentPadding: 10.cl(10, 20).pdAll,
                              subtitle: (oldItem.description ?? '')
                                  .isNotEmpty
                                  .whenOnly(
                                use: Text(
                                  oldItem.description ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                ),
                              ),
                              leading: Icon(LucideIcons.menu),
                            ),
                          );
                        },
                      )
                      .contain(
                        width: 100.w,
                        height: 101.h,
                        padding: 10.cl(10, 40).pdX,
                      )
                      .scrollable(),
            );
          });
        },
      ),
    );
  }
}
