import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../widgets/center_dashboard/top_navigation.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopNavigation(title: 'Attendance'),
              const SizedBox(height: 20),
              
              // Key Stats Header
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 600) {
                    return Column(
                      children: [
                        _buildStatCard(context, 'Present Rate', '95.4%', Colors.green, Icons.check_circle_outline),
                        const SizedBox(height: 12),
                        _buildStatCard(context, 'Remote Active', '12.2%', Colors.blue, Icons.cloud_done_outlined),
                        const SizedBox(height: 12),
                        _buildStatCard(context, 'On Leaves', '2.4%', Colors.orange, Icons.hourglass_empty_outlined),
                      ],
                    );
                  }
                  return Row(
                    children: [
                      _buildStatCard(context, 'Present Rate', '95.4%', Colors.green, Icons.check_circle_outline),
                      const SizedBox(width: 16),
                      _buildStatCard(context, 'Remote Active', '12.2%', Colors.blue, Icons.cloud_done_outlined),
                      const SizedBox(width: 16),
                      _buildStatCard(context, 'On Leaves', '2.4%', Colors.orange, Icons.hourglass_empty_outlined),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),

              // Detail Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  boxShadow: AppConstants.softShadows,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Attendance Analytics Summary',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Review collective corporate check-ins, remote login hours, and leave approvals here.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[500],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Simulated visual chart/graph list
                    _buildLogItem(context, 'Rohan Sharma', 'Check-in: 09:42 AM', 'ON-TIME', Colors.green),
                    _buildLogItem(context, 'Pooja Mishra', 'Check-in: 09:58 AM', 'ON-TIME', Colors.green),
                    _buildLogItem(context, 'Amit Verma', 'Check-in: 10:15 AM', 'LATE', Colors.orange),
                    _buildLogItem(context, 'Kavita Iyer', 'Sick Leave', 'ON LEAVE', Colors.red),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, Color color, IconData icon) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          boxShadow: AppConstants.cardShadow,
          border: Border.all(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.transparent
                : Colors.grey.shade100,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.textLightColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogItem(BuildContext context, String employee, String time, String label, Color statusColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF334155).withOpacity(0.5)
            : const Color(0xFFF4F7FE).withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 12,
                backgroundColor: AppConstants.primaryColor,
                child: Icon(Icons.person, color: Colors.white, size: 12),
              ),
              const SizedBox(width: 12),
              Text(
                employee,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Theme.of(context).colorScheme.onSurface),
              ),
            ],
          ),
          Text(
            time,
            style: TextStyle(fontSize: 12.5, color: Colors.grey[600]),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              label,
              style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
