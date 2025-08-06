import 'package:extension_helpers/extension_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todolo/components/form_field/form_field.dart';
import 'package:todolo/logic/logic.dart';
import 'package:validatorless/validatorless.dart';

class EditProjectDialog extends StatefulWidget {
  const EditProjectDialog({super.key, required this.project});

  final ProjectModel project;

  @override
  State<EditProjectDialog> createState() => _NewProjectDialogState();
}

class _NewProjectDialogState extends State<EditProjectDialog> {
  final ProjectService _projectService = ProjectService.to;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final RxBool _apiLoading = false.obs;

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.project.name;
    descriptionController.text = widget.project.description ?? '';
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
                Text('New Project', style: context.textTheme.headlineMedium),
                20.cl(10, 40).hSpacer,
                AppTextFormField(
                  controller: nameController,
                  label: 'Project Name',
                  hint: 'Enter a name for your project',
                  validator: Validatorless.required('Project name is required'),
                ),
                10.cl(10, 20).hSpacer,
                AppTextFormField(
                  controller: descriptionController,
                  maxLines: 6,
                  minLines: 4,
                  maxLength: 2000,
                  label: 'Project Description (optional)',
                  hint: 'Enter a description for your project',
                ),
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
                    label: Text('Create'),
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
        await _projectService.updateProject(
          widget.project.id,
          name: nameController.text,
          description: descriptionController.text,
        );
        Get.back(result: true);
        if (mounted) {
          context.toast(
            toastMessage: 'Project updated successfully',
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
