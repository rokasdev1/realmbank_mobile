import 'package:flutter/material.dart';

class BigButton extends StatefulWidget {
  const BigButton({
    super.key,
    required this.label,
    required this.onTap,
  });
  final String label;
  final VoidCallback onTap;

  @override
  State<BigButton> createState() => _BigButtonState();
}

class _BigButtonState extends State<BigButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromRGBO(94, 98, 239, 1),
        ),
        child: Center(
          child: Text(
            widget.label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
