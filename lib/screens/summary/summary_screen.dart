import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../widgets/center_dashboard/top_navigation.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

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
              const TopNavigation(title: 'Summary'),
              const SizedBox(height: 20),
              
              // Content Container
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  boxShadow: AppConstants.softShadows,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Executive Summary',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'An automated review of ongoing company milestones, resource allocation, and general health indexes.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[500],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildSummaryItem(context, 'Completed Projects', '24 out of 30 projects delivered this quarter.', 0.8, Colors.green),
                    _buildSummaryItem(context, 'Customer Satisfaction', '4.8 out of 5 average rating from users.', 0.96, AppConstants.primaryColor),
                    _buildSummaryItem(context, 'Budget Allocation', '\$12,450 remaining from marketing budget.', 0.65, Colors.purple),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryItem(BuildContext context, String title, String description, double rate, Color progressColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Theme.of(context).colorScheme.onSurface)),
              Text('${(rate * 100).toInt()}%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: progressColor)),
            ],
          ),
          const SizedBox(height: 6),
          Text(description, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: SizedBox(
              height: 6,
              child: LinearProgressIndicator(
                value: rate,
                backgroundColor: Colors.grey[100],
                valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
