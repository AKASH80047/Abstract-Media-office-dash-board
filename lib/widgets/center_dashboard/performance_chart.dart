import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/constants/app_constants.dart';

class PerformanceChart extends StatelessWidget {
  const PerformanceChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        boxShadow: AppConstants.softShadows,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Over All Performance',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'The Years',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
              // Legends
              Row(
                children: [
                  _buildLegendItem('Pending Done', const Color(0xFFFF528E)),
                  const SizedBox(width: 16),
                  _buildLegendItem('Project Done', AppConstants.primaryColor),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(
                  handleBuiltInTouches: true,
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (touchedSpot) => AppConstants.primaryColor,
                    tooltipRoundedRadius: 8,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        return LineTooltipItem(
                          'Value: ${spot.y.toInt()}',
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 10,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(0.08),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 10,
                      reservedSize: 32,
                      getTitlesWidget: (value, meta) {
                        if (value >= 0 && value <= 50) {
                          return Text(
                            '${value.toInt()}',
                            style: TextStyle(
                              color: Colors.grey[450],
                              fontWeight: FontWeight.w500,
                              fontSize: 11,
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        String text = '';
                        switch (value.toInt()) {
                          case 0:
                            text = '2015';
                            break;
                          case 1:
                            text = '2016';
                            break;
                          case 2:
                            text = '2017';
                            break;
                          case 3:
                            text = '2018';
                            break;
                          case 4:
                            text = '2019';
                            break;
                          case 5:
                            text = '2020';
                            break;
                        }
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          space: 8,
                          child: Text(
                            text,
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w500,
                              fontSize: 11,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                minX: 0,
                maxX: 5,
                minY: 0,
                maxY: 50,
                lineBarsData: [
                  // Pending Done (Pink Curve)
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 18),
                      FlSpot(1, 28),
                      FlSpot(2, 16),
                      FlSpot(3, 38),
                      FlSpot(4, 20),
                      FlSpot(5, 34),
                    ],
                    isCurved: true,
                    color: const Color(0xFFFF528E),
                    barWidth: 3.5,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFFF528E).withOpacity(0.12),
                          const Color(0xFFFF528E).withOpacity(0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  // Project Done (Purple Curve)
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 26),
                      FlSpot(1, 38),
                      FlSpot(2, 22),
                      FlSpot(3, 46),
                      FlSpot(4, 28),
                      FlSpot(5, 42),
                    ],
                    isCurved: true,
                    color: AppConstants.primaryColor,
                    barWidth: 3.5,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    showingIndicators: [3], // Highlights 2018 showing point
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          AppConstants.primaryColor.withOpacity(0.15),
                          AppConstants.primaryColor.withOpacity(0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String name, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          name,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
