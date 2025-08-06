import 'package:extension_helpers/extension_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todolo/components/form_field/form_field.dart';
import 'package:todolo/logic/logic.dart';
import 'package:todolo/main.dart';
import 'package:validatorless/validatorless.dart';

class EditTaskDialog extends StatefulWidget {
  const EditTaskDialog({super.key, required this.project, required this.task});

  final ProjectModel project;
  final Task task;

  @override
  State<EditTaskDialog> createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends State<EditTaskDialog> {
  final TaskService _taskService = TaskService.to;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final Rx<Priority> _priority = Priority.low.obs;

  final RxBool _apiLoading = false.obs;

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.task.title;
    contentController.text = widget.task.content;
    dateController.text = Jiffy.parseFromDateTime(
      widget.task.dueDate,
    ).format(pattern: 'yyyy-MM-dd');
    _priority.value = widget.task.priority;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: 10.brcAll,
      type: MaterialType.card,
      child:
          Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('New Task', style: context.textTheme.headlineMedium),
                20.cl(10, 40).hSpacer,
                AppTextFormField(
                  controller: nameController,
                  label: 'Title',
                  hint: 'Enter a title for your task',
                  validator: Validatorless.required('Project name is required'),
                ),
                10.cl(10, 20).hSpacer,
                AppTextFormField(
                  controller: contentController,
                  maxLines: 8,
                  minLines: 6,
                  maxLength: 5000,
                  label: 'Content',
                  hint: 'Enter a content for your task',
                ),
                AppTextFormField(
                  controller: dateController,
                  label: 'Due Date',
                  hint: 'DD-MM-YYYY',
                  isDate: true,
                  initialDate: DateTime.now().add(1.days),
                  validator: Validatorless.multiple([
                    Validatorless.required('This can\'t be empty.'),
                    Validatorless.regex(
                      RegExp(r'^\d{4}-\d{2}-\d{2}$'),
                      'Please enter date in YYYY-MM-DD format',
                    ),
                  ]),
                ),
                10.cl(10, 20).hSpacer,
                Text(
                  'Priority',
                  style: context.textTheme.headlineMedium,
                ).align(alignment: Alignment.centerLeft),
                10.cl(10, 20).hSpacer,
                Obx(() {
                  return DropdownButton<Priority>(
                    value: _priority.value,
                    onChanged: (value) {
                      _priority.value = value ?? _priority.value;
                    },
                    items: Priority.values
                        .map(
                          (d) => DropdownMenuItem<Priority>(
                            value: d,
                            child: Text(
                              d.value.capitalize ?? '',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: Priority.low == d
                                    ? appTheme.palette.warning
                                    : Priority.medium == d
                                    ? appTheme.palette.info
                                    : appTheme.palette.error,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  );
                }).sized(width: 100.w),
                20.cl(10, 40).hSpacer,
                Obx(
                  () => ElevatedButton.icon(
                    onPressed: onSubmit,
                    icon: _apiLoading.isTrue.whenOnly(
                      use: CircularProgressIndicator(
                        color: Colors.white.withValues(alpha: 0.6),
                        strokeWidth: 2.cl(2, 4),
                      ).sized(width: 16.cl(16, 28), height: 16.cl(16, 28)),
                    ),
                    style: ButtonStyle(
                      minimumSize: Size(100.w, 28.cl(40, 70)).all,
                    ),
                    label: Text('Add'),
                  ),
                ),
              ],
            ),
          ).contain(
            width: 90.w,
            padding: 20.cl(20, 50).pdAll,
            decoration: BoxDecoration(
              color: context.theme.scaffoldBackgroundColor,
              borderRadius: 10.brcAll,
            ),
          ),
    ).center;
  }

  Future<void> onSubmit() async {
    try {
      _apiLoading.value = true;
      if (_formKey.currentState?.validate() ?? false) {
        await _taskService.updateTask(
          widget.task.id,
          title: nameController.text,
          content: contentController.text,
          dueDate: DateTime.tryParse(dateController.text) ?? DateTime.now(),
          priority: _priority.value,
          projectId: widget.project.id,
        );
        Get.back(result: true);
        if (mounted) {
          context.toast(
            toastMessage: 'Task Edited',
            type: ToastSnackBarType.success,
          );
        }
      }
    } catch (e) {
      if (mounted) {
        context.toast(
          toastMessage: 'Ops, Something went wrong',
          type: ToastSnackBarType.danger,
        );
      }
    } finally {
      _apiLoading.value = false;
    }
  }
}
