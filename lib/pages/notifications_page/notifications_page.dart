import 'package:flutter/material.dart';

import '../../structure_main_flow/flutter_mada_theme.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: FlutterMadaTheme.of(context).info,
        body: const SafeArea(child: Stack()),
      ),
    );
  }
}
