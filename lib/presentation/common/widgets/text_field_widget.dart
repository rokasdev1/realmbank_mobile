import 'package:flutter/material.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';

class TextFieldWidget extends StatefulWidget {
  TextFieldWidget(
      {super.key,
      required this.controller,
      required this.label,
      required this.icon,
      this.isObscure = false,
      this.longerHintText = true,
      this.keyboardType = TextInputType.text,
      this.prefixText,
      this.topText,
      this.canEdit});
  final TextEditingController controller;
  final String label;
  final IconData icon;
  bool isObscure = false;
  bool longerHintText = true;
  TextInputType keyboardType = TextInputType.text;
  final String? prefixText;
  final String? topText;
  final bool? canEdit;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late bool isHidden;

  @override
  void initState() {
    isHidden = widget.isObscure;
    super.initState();
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
                    color: Colors.deepPurple.shade300,
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
                        color: Colors.grey.shade300,
                        thickness: 1,
                        width: 1,
                        indent: 8,
                        endIndent: 8,
                      ),
                      4.widthBox,
                    ],
                  ),
                Expanded(
                  child: TextField(
                    enabled: widget.canEdit ?? true,
                    keyboardType: widget.keyboardType,
                    controller: widget.controller,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    obscureText: isHidden,
                    decoration: InputDecoration(
                      hintText: widget.longerHintText
                          ? 'Your ${widget.label.toLowerCase()}'
                          : widget.label,
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (widget.isObscure)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isHidden = !isHidden;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        isHidden
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.grey,
                        size: 28,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
