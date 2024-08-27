import 'package:flutter/material.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';

// ignore: must_be_immutable
class BigButton extends StatefulWidget {
  BigButton({
    super.key,
    required this.label,
    required this.onTap,
    this.disabled = false,
    this.inverted = false,
  });
  final String label;
  final VoidCallback onTap;
  bool disabled = false;
  bool inverted = false;

  @override
  State<BigButton> createState() => _BigButtonState();
}

class _BigButtonState extends State<BigButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.disabled ? null : widget.onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: widget.inverted
              ? Border.all(color: context.colorScheme.primary, width: 2)
              : null,
          color: widget.disabled
              ? Colors.grey
              : widget.inverted
                  ? Colors.white
                  : context.colorScheme.primary,
        ),
        child: Center(
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color:
                  widget.inverted ? context.colorScheme.primary : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
