part of './form_field.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.controller,
    this.label,
    this.hint,
    this.startWidget,
    this.endWidget,
    this.isHidden,
    this.validator,
    this.autofillHints,
    this.inputFormatters,
    this.onChanged,
    this.keyboardType,
    this.focus,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.textCapitalization,
    this.addSeparator = false,
    this.isPhoneNumber = false,
    this.isDate = false,
    this.initialDate,
    this.dateFormat,
  });

  final String? label;
  final String? hint;
  final TextEditingController controller;
  final Widget? startWidget;
  final Widget? endWidget;
  final bool? isHidden;
  final void Function(String)? onChanged;
  final List<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final FocusNode? focus;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final TextCapitalization? textCapitalization;
  final bool addSeparator;
  final bool isPhoneNumber;
  final bool isDate;
  final DateTime? initialDate;
  final String Function(DateTime)? dateFormat;

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter>? formatters = inputFormatters;
    if (addSeparator) {
      final formatter = isPhoneNumber
          ? _PhoneNumberSeparatorFormatter()
          : _NumberSeparatorFormatter();
      formatters = (inputFormatters ?? []) + [formatter];
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) Text(label!, style: context.textTheme.headlineMedium),
        if (label != null) 10.cl(10, 25).hSpacer,
        GestureDetector(
          onTap: isDate
              ? () async {
                  FocusScope.of(context).unfocus();
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: initialDate ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    final formatted = dateFormat != null
                        ? dateFormat!(picked)
                        : "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                    controller.text = formatted;
                    if (onChanged != null) onChanged!(formatted);
                  }
                }
              : null,
          child: AbsorbPointer(
            absorbing: isDate,
            child: TextFormField(
              focusNode: focus,
              controller: controller,
              obscureText: isHidden ?? false,
              style: context.textTheme.bodyMedium,
              validator: validator,
              autofillHints: autofillHints,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              inputFormatters: formatters,
              onChanged: onChanged,
              keyboardType: keyboardType,
              maxLines: maxLines ?? 1,
              textCapitalization: textCapitalization ?? TextCapitalization.none,
              minLines: minLines,
              maxLength: maxLength,
              decoration: InputDecoration(
                prefixIcon: startWidget,
                suffixIcon: endWidget,
                alignLabelWithHint: true,
                hintText: hint,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _NumberSeparatorFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    String formatted = _formatNumber(digits);
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  String _formatNumber(String input) {
    if (input.isEmpty) return '';
    final buffer = StringBuffer();
    for (int i = 0; i < input.length; i++) {
      if (i != 0 && (input.length - i) % 3 == 0) buffer.write(',');
      buffer.write(input[i]);
    }
    return buffer.toString();
  }
}

class _PhoneNumberSeparatorFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    String formatted = _formatPhone(digits);
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  String _formatPhone(String input) {
    // Example: 0800-123-4567 (Nigeria typical mobile)
    if (input.length <= 4) return input;
    if (input.length <= 7) {
      return '${input.substring(0, 4)}-${input.substring(4)}';
    }
    if (input.length <= 11) {
      return '${input.substring(0, 4)}-${input.substring(4, 7)}-${input.substring(7)}';
    }
    return '${input.substring(0, 4)}-${input.substring(4, 7)}-${input.substring(7, 11)}';
  }
}
