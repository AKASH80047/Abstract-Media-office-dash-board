import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/employee.dart';
import '../services/dummy_data_service.dart';

// Theme Mode Provider
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

// Navigation index provider (0 = Home, 1 = Employees, 2 = Attendance, 3 = Summary, 4 = Information, 5 = Settings)
final navigationIndexProvider = StateProvider<int>((ref) => 0);

// Search Query Provider
final searchQueryProvider = StateProvider<String>((ref) => '');

// Employees list provider
class EmployeesNotifier extends StateNotifier<List<Employee>> {
  EmployeesNotifier() : super(DummyDataService.getEmployees());

  void filterEmployees(String query) {
    final all = DummyDataService.getEmployees();
    if (query.isEmpty) {
      state = all;
    } else {
      state = all
          .where((emp) =>
              emp.name.toLowerCase().contains(query.toLowerCase()) ||
              emp.role.toLowerCase().contains(query.toLowerCase()) ||
              emp.department.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void addEmployee(Employee employee) {
    state = [...state, employee];
  }
}

final employeesProvider = StateNotifierProvider<EmployeesNotifier, List<Employee>>((ref) {
  final provider = EmployeesNotifier();
  // Listen to search query and filter list
  ref.listen<String>(searchQueryProvider, (_, query) {
    provider.filterEmployees(query);
  });
  return provider;
});

// Selected Date Provider (for calendar card, defaulted to Oct 27, 2023 as shown in design image)
final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime(2023, 10, 27));

// Highlighted Date Range Providers
final highlightedDatesProvider = Provider<List<DateTime>>((ref) {
  return [
    DateTime(2023, 10, 27),
    DateTime(2023, 10, 28),
    DateTime(2023, 10, 29),
    DateTime(2023, 10, 30),
  ];
});

// Wishing States (bool indicates if wishing process is active)
class WishingNotifier extends StateNotifier<bool> {
  WishingNotifier() : super(false);

  void triggerWishing() {
    state = true;
    Timer(const Duration(seconds: 4), () {
      state = false;
    });
  }
}

final birthdayWishingProvider = StateNotifierProvider<WishingNotifier, bool>((ref) {
  return WishingNotifier();
});

final anniversaryWishingProvider = StateNotifierProvider<WishingNotifier, bool>((ref) {
  return WishingNotifier();
});
