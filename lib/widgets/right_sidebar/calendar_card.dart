import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/constants/app_constants.dart';
import '../../providers/dashboard_provider.dart';

class CalendarCard extends ConsumerWidget {
  const CalendarCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Weekdays matching mockup header
    final weekdays = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];

    // We hardcode the grid data to match the mockup design exactly for October 2023:
    // Row 1: 29, 30, 31 (Sept) then 1, 2, 3, 4 (Oct)
    // Row 2: 5, 6, 7, 8, 9, 10, 11
    // Row 3: 12, 13, 14, 15, 16, 17, 18
    // Row 4: 19, 20, 21, 22, 23, 24, 25
    // Row 5: 26, 27, 28, 29, 30, 1, 2
    final List<CalendarDay> days = [
      CalendarDay(day: 29, isCurrentMonth: false),
      CalendarDay(day: 30, isCurrentMonth: false),
      CalendarDay(day: 31, isCurrentMonth: false),
      CalendarDay(day: 1, isCurrentMonth: true),
      CalendarDay(day: 2, isCurrentMonth: true),
      CalendarDay(day: 3, isCurrentMonth: true),
      CalendarDay(day: 4, isCurrentMonth: true),
      
      CalendarDay(day: 5, isCurrentMonth: true),
      CalendarDay(day: 6, isCurrentMonth: true),
      CalendarDay(day: 7, isCurrentMonth: true),
      CalendarDay(day: 8, isCurrentMonth: true),
      CalendarDay(day: 9, isCurrentMonth: true),
      CalendarDay(day: 10, isCurrentMonth: true),
      CalendarDay(day: 11, isCurrentMonth: true),
      
      CalendarDay(day: 12, isCurrentMonth: true),
      CalendarDay(day: 13, isCurrentMonth: true),
      CalendarDay(day: 14, isCurrentMonth: true),
      CalendarDay(day: 15, isCurrentMonth: true),
      CalendarDay(day: 16, isCurrentMonth: true),
      CalendarDay(day: 17, isCurrentMonth: true),
      CalendarDay(day: 18, isCurrentMonth: true),
      
      CalendarDay(day: 19, isCurrentMonth: true),
      CalendarDay(day: 20, isCurrentMonth: true),
      CalendarDay(day: 21, isCurrentMonth: true),
      CalendarDay(day: 22, isCurrentMonth: true),
      CalendarDay(day: 23, isCurrentMonth: true),
      CalendarDay(day: 24, isCurrentMonth: true),
      CalendarDay(day: 25, isCurrentMonth: true),
      
      CalendarDay(day: 26, isCurrentMonth: true),
      CalendarDay(day: 27, isCurrentMonth: true),
      CalendarDay(day: 28, isCurrentMonth: true),
      CalendarDay(day: 29, isCurrentMonth: true),
      CalendarDay(day: 30, isCurrentMonth: true),
      CalendarDay(day: 1, isCurrentMonth: false),
      CalendarDay(day: 2, isCurrentMonth: false),
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        boxShadow: AppConstants.cardShadow,
      ),
      child: Column(
        children: [
          // Month & Year Selector Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Dropdowns
              Row(
                children: [
                  _buildDropdownButton(context, 'OCT', () {}),
                  const SizedBox(width: 8),
                  _buildDropdownButton(context, '2023', () {}),
                ],
              ),
              // Navigation Arrows
              Row(
                children: [
                  IconButton(
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.all(4),
                    icon: const Icon(Iconsax.arrow_left_2, size: 14, color: AppConstants.iconColor),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.all(4),
                    icon: const Icon(Iconsax.arrow_right_3, size: 14, color: AppConstants.iconColor),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Weekdays header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: weekdays
                .map((day) => Expanded(
                      child: Text(
                        day,
                        style: TextStyle(
                          color: Colors.grey[650],
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 10),

          // Days Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: days.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 4,
            ),
            itemBuilder: (context, index) {
              final calendarDay = days[index];
              final isHighlighted = calendarDay.isCurrentMonth && 
                  (calendarDay.day == 27 || 
                   calendarDay.day == 28 || 
                   calendarDay.day == 29 || 
                   calendarDay.day == 30);
              
              final isFirstOrLast = calendarDay.day == 27 || calendarDay.day == 30;

              return Center(
                child: GestureDetector(
                  onTap: () {
                    if (calendarDay.isCurrentMonth) {
                      ref.read(selectedDateProvider.notifier).state = DateTime(2023, 10, calendarDay.day);
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    alignment: Alignment.center,
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isHighlighted
                          ? AppConstants.primaryColor
                          : Colors.transparent,
                      shape: BoxShape.circle,
                      boxShadow: isHighlighted && isFirstOrLast
                          ? [
                              BoxShadow(
                                color: AppConstants.primaryColor.withOpacity(0.3),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              )
                            ]
                          : null,
                    ),
                    child: Text(
                      '${calendarDay.day}',
                      style: TextStyle(
                        color: isHighlighted
                            ? Colors.white
                            : (calendarDay.isCurrentMonth
                                ? Theme.of(context).colorScheme.onSurface
                                : Colors.grey[400]),
                        fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownButton(BuildContext context, String text, VoidCallback onTap) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF334155)
            : const Color(0xFFF4F7FE),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: AppConstants.textLightColor,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down, size: 14, color: AppConstants.textLightColor),
        ],
      ),
    );
  }
}

class CalendarDay {
  final int day;
  final bool isCurrentMonth;

  CalendarDay({required this.day, required this.isCurrentMonth});
}
