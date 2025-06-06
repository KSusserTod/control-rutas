import 'package:flutter/material.dart';

class NavDrawerListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget destination;
  const NavDrawerListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
    );
  }
}
