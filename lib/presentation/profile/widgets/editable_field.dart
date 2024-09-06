import 'package:flutter/material.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';
import 'package:realmbank_mobile/presentation/common/widgets/text_field_widget.dart';

// ignore: must_be_immutable
class EditableField extends StatefulWidget {
  EditableField({
    super.key,
    this.controller,
    required this.label,
    required this.icon,
    this.topText,
    this.prefixText,
    this.text,
    this.hintText,
    this.initialText,
    this.editable = true,
  });
  final TextEditingController? controller;
  final String? initialText;
  final String label;
  final String? topText;
  final IconData icon;
  final String? prefixText;
  final String? text;
  final String? hintText;
  bool editable = true;

  @override
  State<EditableField> createState() => _EditableFieldState();
}

class _EditableFieldState extends State<EditableField> {
  bool isEditable = false;

  @override
  void initState() {
    if (widget.controller != null) {
      widget.controller!.text = widget.initialText ?? '';
    }

    super.initState();
  }

  @override
  void dispose() {
    widget.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.topText ?? widget.label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        8.heightBox,
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: isEditable
                ? context.colorScheme.surface
                : context.colorScheme.surfaceContainer,
            border: Border.all(
              color: const Color.fromARGB(49, 158, 158, 158),
              width: 2,
            ),
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(
                    widget.icon,
                    color: context.colorScheme.primary,
                    size: 28,
                  ),
                ),
                if (widget.prefixText != null)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.prefixText!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      4.widthBox,
                      VerticalDivider(
                        color: context.colorScheme.surfaceContainerHigh,
                        thickness: 1,
                        width: 1,
                        indent: 8,
                        endIndent: 8,
                      ),
                      4.widthBox,
                    ],
                  ),
                Expanded(
                  child: widget.text == null
                      ? TextField(
                          enabled: isEditable,
                          controller: widget.controller,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            hintText: widget.hintText ??
                                'Your ${widget.label.toLowerCase()}',
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: Text(
                            widget.text!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.grey),
                          ),
                        ),
                ),
                if (widget.editable)
                  GestureDetector(
                    onTap: () => setState(() => isEditable = !isEditable),
                    child: Icon(
                      isEditable ? Icons.check_rounded : Icons.edit_outlined,
                      color: Colors.grey.shade600,
                    ),
                  ),
                8.widthBox,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
