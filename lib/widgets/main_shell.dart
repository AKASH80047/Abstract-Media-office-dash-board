import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/responsive/responsive_layout.dart';
import 'sidebar/left_sidebar.dart';

class MainShell extends ConsumerWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Scaffold(
      drawer: !isDesktop
          ? const Drawer(
              width: 260,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              child: LeftSidebar(isDrawer: true),
            )
          : null,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isDesktop)
              const SizedBox(
                width: 260,
                child: LeftSidebar(isDrawer: false),
              ),
            Expanded(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
