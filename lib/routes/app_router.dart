import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/employees/employees_screen.dart';
import '../screens/attendance/attendance_screen.dart';
import '../screens/summary/summary_screen.dart';
import '../screens/information/info_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../widgets/main_shell.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return MainShell(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/employees',
          builder: (context, state) => const EmployeesScreen(),
        ),
        GoRoute(
          path: '/attendance',
          builder: (context, state) => const AttendanceScreen(),
        ),
        GoRoute(
          path: '/summary',
          builder: (context, state) => const SummaryScreen(),
        ),
        GoRoute(
          path: '/information',
          builder: (context, state) => const InfoScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
);
