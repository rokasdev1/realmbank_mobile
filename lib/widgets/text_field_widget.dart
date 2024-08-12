import 'package:flutter/material.dart';
import 'package:realmbank_mobile/utils/extensions.dart';

class TextFieldwidget extends StatefulWidget {
  TextFieldwidget({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.isObscure = false,
  });
  final TextEditingController controller;
  final String label;
  final IconData icon;
  bool isObscure = false;

  @override
  State<TextFieldwidget> createState() => _TextFieldwidgetState();
}

class _TextFieldwidgetState extends State<TextFieldwidget> {
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
          widget.label,
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
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  obscureText: isHidden,
                  decoration: InputDecoration(
                    hintText: 'Your ${widget.label.toLowerCase()}',
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
      ],
    );
  }
}
