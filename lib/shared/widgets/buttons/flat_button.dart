import 'package:flutter/material.dart';

class FlatButton extends StatefulWidget {
  final String title;
  final void Function()? onPressed;
  final Color color;
  const FlatButton({
    super.key,
    required this.title,
    this.onPressed,
    required this.color,
  });

  @override
  State<FlatButton> createState() => _FlatButtonState();
}

class _FlatButtonState extends State<FlatButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.color,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          minimumSize: const Size(167, 56),
          maximumSize: const Size(282, 56),
        ),
        child: Text(widget.title, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
