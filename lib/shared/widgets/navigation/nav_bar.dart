import 'package:control_de_rutas/shared/widgets/responsiveness/responsive_widget.dart';
import 'package:flutter/material.dart';

class NavBar extends ResponsiveWidget {
  const NavBar({super.key});

  @override
  Widget buildDesktop(BuildContext context) {
    // TODO: implement buildDesktop
    throw UnimplementedError();
  }

  @override
  Widget buildMobile(BuildContext context) {
    // TODO: implement buildMobile
    throw UnimplementedError();
  }
}

class DesktopNavBar extends StatelessWidget {
  const DesktopNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(children: []),
      ),
    );
  }
}
