import 'package:flutter/material.dart';

class NavDrawerHeader extends StatelessWidget {
  const NavDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.blue,
      child: Center(child: Text("Drawer Header")),
    );
  }
}
