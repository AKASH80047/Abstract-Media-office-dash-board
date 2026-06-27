import 'package:flutter/material.dart';
import '../../core/responsive/responsive_layout.dart';
import '../../widgets/center_dashboard/top_navigation.dart';
import '../../widgets/center_dashboard/hero_banner.dart';
import '../../widgets/center_dashboard/all_projects_card.dart';
import '../../widgets/center_dashboard/top_creators_card.dart';
import '../../widgets/center_dashboard/performance_chart.dart';
import '../../widgets/right_sidebar/right_sidebar.dart';
import '../../widgets/right_sidebar/calendar_card.dart';
import '../../widgets/right_sidebar/celebration_card.dart';
import '../../services/dummy_data_service.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobile: _buildMobileLayout(context),
        tablet: _buildTabletLayout(context),
        desktop: _buildDesktopLayout(context),
      ),
    );
  }

  // --- DESKTOP LAYOUT (3 Columns: Left Sidebar, Center, Right Sidebar) ---
  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Center main contents
        Expanded(
          flex: 7,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TopNavigation(title: 'Home'),
                const SizedBox(height: 24),
                const HeroBanner(),
                const SizedBox(height: 24),
                // All Projects and Top Creators side by side
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 11,
                      child: AllProjectsCard(),
                    ),
                    SizedBox(width: 24),
                    Expanded(
                      flex: 9,
                      child: TopCreatorsCard(),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const PerformanceChart(),
              ],
            ),
          ),
        ),
        // Right sidebar contents
        const SizedBox(
          width: 340,
          child: RightSidebar(),
        ),
      ],
    );
  }

  // --- TABLET LAYOUT (2 Columns: Left sidebar as Drawer, Center, Right Sidebar) ---
  Widget _buildTabletLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Center main contents
        Expanded(
          flex: 6,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TopNavigation(title: 'Home'),
                const SizedBox(height: 20),
                const HeroBanner(),
                const SizedBox(height: 20),
                // Stack cards vertically on smaller tablet view widths
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 650) {
                      return const Column(
                        children: [
                          AllProjectsCard(),
                          SizedBox(height: 20),
                          TopCreatorsCard(),
                        ],
                      );
                    }
                    return const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: AllProjectsCard()),
                        SizedBox(width: 20),
                        Expanded(child: TopCreatorsCard()),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
                const PerformanceChart(),
              ],
            ),
          ),
        ),
        // Right sidebar (slighter narrower)
        const SizedBox(
          width: 300,
          child: RightSidebar(),
        ),
      ],
    );
  }

  // --- MOBILE LAYOUT (1 Column: Left sidebar as Drawer, Right sidebar items stacked) ---
  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const TopNavigation(title: 'Home'),
          const SizedBox(height: 16),
          const HeroBanner(),
          const SizedBox(height: 16),
          const AllProjectsCard(),
          const SizedBox(height: 16),
          const TopCreatorsCard(),
          const SizedBox(height: 16),
          const PerformanceChart(),
          const SizedBox(height: 16),
          // Stacked right sidebar items on mobile
          const CalendarCard(),
          const SizedBox(height: 16),
          CelebrationCard(
            title: 'Today Birthday',
            people: DummyDataService.getBirthdayPeople(),
            isBirthday: true,
          ),
          const SizedBox(height: 16),
          CelebrationCard(
            title: 'Anniversary',
            people: DummyDataService.getAnniversaryPeople(),
            isBirthday: false,
          ),
        ],
      ),
    );
  }
}
