class Employee {
  final String id;
  final String name;
  final String role;
  final String department;
  final String status; // Active, Remote, On Leave
  final double attendanceRate;
  final String avatarUrl;

  Employee({
    required this.id,
    required this.name,
    required this.role,
    required this.department,
    required this.status,
    required this.attendanceRate,
    required this.avatarUrl,
  });
}
