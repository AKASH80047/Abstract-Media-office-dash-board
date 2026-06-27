import 'package:flutter/material.dart';
import '../models/project.dart';
import '../models/creator.dart';
import '../models/employee.dart';
import '../models/birthday_person.dart';
import '../core/constants/app_constants.dart';

class DummyDataService {
  static List<Project> getProjects() {
    return [
      Project(
        title: 'Technology behind the Blockchain',
        description: 'Project #1 • See project details',
        imageUrl:
            'https://images.unsplash.com/photo-1639762681485-074b7f938ba0?q=80&w=200&auto=format&fit=crop',
        backgroundColor: const Color(
          0xFFC23A4A,
        ), // Rich red/burgundy color as in mockup
      ),
      Project(
        title: 'Technology behind the Blockchain',
        description: 'Project #2 • See project details',
        imageUrl:
            'https://images.unsplash.com/photo-1620712943543-bcc4688e7485?q=80&w=200&auto=format&fit=crop',
        backgroundColor: const Color(0xFF1B2347), // Dark navy blue as in mockup
      ),
      Project(
        title: 'Technology behind the Blockchain',
        description: 'Project #3 • See project details',
        imageUrl:
            'https://images.unsplash.com/photo-1639322537228-f710d846310a?q=80&w=200&auto=format&fit=crop',
        backgroundColor: const Color(0xFF1B2347), // Dark navy blue
      ),
    ];
  }

  static List<Creator> getCreators() {
    return [
      Creator(
        name: '@maddison_c21',
        avatarUrl: AppConstants.avatar1,
        artworksCount: 9821,
        ratingProgress: 0.85,
      ),
      Creator(
        name: '@karl.will02',
        avatarUrl: AppConstants.avatar2,
        artworksCount: 7032,
        ratingProgress: 0.65,
      ),
      Creator(
        name: '@maddison_c21',
        avatarUrl: AppConstants.avatar3,
        artworksCount: 9821,
        ratingProgress: 0.75,
      ),
      Creator(
        name: '@maddison_c21',
        avatarUrl: AppConstants.avatar4,
        artworksCount: 9821,
        ratingProgress: 0.55,
      ),
    ];
  }

  static List<BirthdayPerson> getBirthdayPeople() {
    return [
      BirthdayPerson(
        name: 'Rohan Sharma',
        avatarUrl: AppConstants.avatar1,
        type: CelebrationType.birthday,
        dateText: 'Today',
      ),
      BirthdayPerson(
        name: 'Priya Patel',
        avatarUrl: AppConstants.avatar2,
        type: CelebrationType.birthday,
        dateText: 'Today',
      ),
    ];
  }

  static List<BirthdayPerson> getAnniversaryPeople() {
    return [
      BirthdayPerson(
        name: 'Amit Verma',
        avatarUrl: AppConstants.avatar3,
        type: CelebrationType.anniversary,
        dateText: '2 Years',
      ),
      BirthdayPerson(
        name: 'Sneha Reddy',
        avatarUrl: AppConstants.avatar4,
        type: CelebrationType.anniversary,
        dateText: '1 Year',
      ),
      BirthdayPerson(
        name: 'Vikram Singh',
        avatarUrl: AppConstants.avatar5,
        type: CelebrationType.anniversary,
        dateText: '3 Years',
      ),
    ];
  }

  static List<Employee> getEmployees() {
    return [
      Employee(
        id: 'EMP001',
        name: 'Rohan Sharma',
        role: 'Software Engineer',
        department: 'Engineering',
        status: 'Active',
        attendanceRate: 0.98,
        avatarUrl: AppConstants.avatar1,
      ),
      Employee(
        id: 'EMP002',
        name: 'Vishal Maurya',
        role: 'HR Manager',
        department: 'Human Resources',
        status: 'Active',
        attendanceRate: 0.95,
        avatarUrl: AppConstants.poojaAvatar,
      ),
      Employee(
        id: 'EMP003',
        name: 'Priya Patel',
        role: 'Product Designer',
        department: 'Design',
        status: 'Remote',
        attendanceRate: 0.92,
        avatarUrl: AppConstants.avatar2,
      ),
      Employee(
        id: 'EMP004',
        name: 'Amit Verma',
        role: 'Product Manager',
        department: 'Product Management',
        status: 'Active',
        attendanceRate: 0.89,
        avatarUrl: AppConstants.avatar3,
      ),
      Employee(
        id: 'EMP005',
        name: 'Sneha Reddy',
        role: 'QA Engineer',
        department: 'Engineering',
        status: 'Active',
        attendanceRate: 0.97,
        avatarUrl: AppConstants.avatar4,
      ),
      Employee(
        id: 'EMP006',
        name: 'Vikram Singh',
        role: 'DevOps Engineer',
        department: 'Infrastructure',
        status: 'Active',
        attendanceRate: 0.96,
        avatarUrl: AppConstants.avatar5,
      ),
      Employee(
        id: 'EMP007',
        name: 'Kavita Iyer',
        role: 'Marketing Lead',
        department: 'Marketing',
        status: 'On Leave',
        attendanceRate: 0.85,
        avatarUrl: AppConstants.avatar6,
      ),
      Employee(
        id: 'EMP008',
        name: 'Rahul Gupta',
        role: 'Data Analyst',
        department: 'Business Intelligence',
        status: 'Active',
        attendanceRate: 0.93,
        avatarUrl: AppConstants.avatar1,
      ),
    ];
  }
}
