import 'package:flutter/material.dart';
import 'calendar_card.dart';
import 'celebration_card.dart';
import '../../core/constants/app_constants.dart';
import '../../services/dummy_data_service.dart';

class RightSidebar extends StatelessWidget {
  const RightSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppConstants.darkSidebarColor, // Dark navy background
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // General header timing
          const Text(
            'GENERAL 10:00 AM TO 7:00 PM',
            style: TextStyle(
              color: Color(0xFF8F9BBA),
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // Scrollable content area for cards
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const CalendarCard(),
                  const SizedBox(height: 20),
                  CelebrationCard(
                    title: 'Today Birthday',
                    people: DummyDataService.getBirthdayPeople(),
                    isBirthday: true,
                  ),
                  const SizedBox(height: 20),
                  CelebrationCard(
                    title: 'Anniversary',
                    people: DummyDataService.getAnniversaryPeople(),
                    isBirthday: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
