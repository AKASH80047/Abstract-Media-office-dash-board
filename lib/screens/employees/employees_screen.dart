import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/constants/app_constants.dart';
import '../../widgets/center_dashboard/top_navigation.dart';
import '../../providers/dashboard_provider.dart';
import '../../models/employee.dart';

class EmployeesScreen extends ConsumerWidget {
  const EmployeesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employees = ref.watch(employeesProvider);

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopNavigation(title: 'Employees'),
              const SizedBox(height: 20),
              
              // Employee table container
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                    boxShadow: AppConstants.softShadows,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Employee Directory',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Manage all corporate team members and attendance rates',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppConstants.textLightColor,
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton.icon(
                            onPressed: () => _showAddEmployeeDialog(context, ref),
                            icon: const Icon(Icons.add, size: 16, color: Colors.white),
                            label: const Text('Add Employee', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppConstants.primaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              elevation: 0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(color: Color(0xFFF4F7FE), height: 1),
                      const SizedBox(height: 16),

                      // DataTable2
                      Expanded(
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.grey.withOpacity(0.08),
                          ),
                          child: DataTable2(
                            columnSpacing: 16,
                            horizontalMargin: 12,
                            minWidth: 800,
                            dataRowHeight: 52,
                            headingRowColor: WidgetStateProperty.all(
                              Theme.of(context).brightness == Brightness.dark
                                  ? const Color(0xFF1E293B)
                                  : const Color(0xFFF4F7FE),
                            ),
                            headingRowHeight: 40,
                            columns: const [
                              DataColumn2(
                                label: Text('Photo', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                                size: ColumnSize.S,
                              ),
                              DataColumn2(
                                label: Text('ID', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                                size: ColumnSize.S,
                              ),
                              DataColumn2(
                                label: Text('Name', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                                size: ColumnSize.M,
                              ),
                              DataColumn2(
                                label: Text('Role', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                                size: ColumnSize.M,
                              ),
                              DataColumn2(
                                label: Text('Department', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                                size: ColumnSize.M,
                              ),
                              DataColumn2(
                                label: Text('Status', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                                size: ColumnSize.S,
                              ),
                              DataColumn2(
                                label: Text('Attendance', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                                size: ColumnSize.S,
                                numeric: true,
                              ),
                            ],
                            rows: employees.map((employee) {
                              return DataRow2(
                                cells: [
                                  // Photo
                                  DataCell(
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundImage: CachedNetworkImageProvider(employee.avatarUrl),
                                      backgroundColor: Colors.grey[200],
                                    ),
                                  ),
                                  // ID
                                  DataCell(Text(
                                    employee.id,
                                    style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w500, color: AppConstants.textLightColor),
                                  )),
                                  // Name
                                  DataCell(Text(
                                    employee.name,
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                  )),
                                  // Role
                                  DataCell(Text(
                                    employee.role,
                                    style: const TextStyle(fontSize: 13),
                                  )),
                                  // Department
                                  DataCell(Text(
                                    employee.department,
                                    style: const TextStyle(fontSize: 13),
                                  )),
                                  // Status Badge
                                  DataCell(_buildStatusBadge(employee.status)),
                                  // Attendance rate progress
                                  DataCell(
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          '${(employee.attendanceRate * 100).toInt()}%',
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5),
                                        ),
                                        const SizedBox(width: 8),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(4),
                                          child: SizedBox(
                                            width: 40,
                                            height: 5,
                                            child: LinearProgressIndicator(
                                              value: employee.attendanceRate,
                                              backgroundColor: Colors.grey[100],
                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                employee.attendanceRate > 0.90 
                                                    ? Colors.green 
                                                    : (employee.attendanceRate > 0.85 ? Colors.orange : Colors.red),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bg;
    Color fg;

    switch (status.toLowerCase()) {
      case 'active':
        bg = const Color(0xFFE2F9EB);
        fg = const Color(0xFF1F8B4C);
        break;
      case 'remote':
        bg = const Color(0xFFE2F0FF);
        fg = const Color(0xFF1B6AE3);
        break;
      case 'on leave':
      default:
        bg = const Color(0xFFFFF3E5);
        fg = const Color(0xFFE3861B);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: fg,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }

  void _showAddEmployeeDialog(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    String name = '';
    String role = '';
    String department = 'Engineering';
    String status = 'Active';
    double attendance = 0.90;

    final departments = ['Engineering', 'Human Resources', 'Design', 'Product Management', 'Marketing', 'Business Intelligence'];
    final statuses = ['Active', 'Remote', 'On Leave'];

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Add New Employee', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Full Name'),
                    validator: (val) => val == null || val.isEmpty ? 'Please enter a name' : null,
                    onSaved: (val) => name = val ?? '',
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Job Title / Role'),
                    validator: (val) => val == null || val.isEmpty ? 'Please enter a role' : null,
                    onSaved: (val) => role = val ?? '',
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: department,
                    decoration: const InputDecoration(labelText: 'Department'),
                    items: departments.map((dept) => DropdownMenuItem(value: dept, child: Text(dept))).toList(),
                    onChanged: (val) => setState(() => department = val ?? 'Engineering'),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: status,
                    decoration: const InputDecoration(labelText: 'Work Status'),
                    items: statuses.map((st) => DropdownMenuItem(value: st, child: Text(st))).toList(),
                    onChanged: (val) => setState(() => status = val ?? 'Active'),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text('Attendance Rate: ', style: TextStyle(fontSize: 13)),
                      Expanded(
                        child: Slider(
                          value: attendance,
                          min: 0.50,
                          max: 1.00,
                          divisions: 50,
                          label: '${(attendance * 100).toInt()}%',
                          onChanged: (val) => setState(() => attendance = val),
                        ),
                      ),
                      Text('${(attendance * 100).toInt()}%', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  formKey.currentState?.save();
                  final newEmp = Employee(
                    id: 'EMP${Random().nextInt(900) + 100}',
                    name: name,
                    role: role,
                    department: department,
                    status: status,
                    attendanceRate: attendance,
                    // Pull randomly from one of the Unsplash default avatars
                    avatarUrl: [
                      AppConstants.avatar1,
                      AppConstants.avatar2,
                      AppConstants.avatar3,
                      AppConstants.avatar4,
                      AppConstants.avatar5,
                      AppConstants.avatar6
                    ][Random().nextInt(6)],
                  );
                  ref.read(employeesProvider.notifier).addEmployee(newEmp);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Employee "$name" added successfully!'),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: AppConstants.primaryColor,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppConstants.primaryColor, foregroundColor: Colors.white),
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
