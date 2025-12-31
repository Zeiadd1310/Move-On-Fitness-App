import 'package:flutter/material.dart';
import 'package:move_on/constants.dart';

class StepsBarChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const StepsBarChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final values = data.map((e) => e['value'] as int).toList();
    final maxValue = values.reduce((a, b) => a > b ? a : b);
    final minValue = values.reduce((a, b) => a < b ? a : b);
    final chartHeight = 200.0;
    final availableHeight = chartHeight - 50; // Space for labels
    final valueRange = maxValue - minValue;

    // Generate Y-axis labels
    final yAxisLabels = <int>[];
    final step = ((maxValue - minValue) / 3).ceil();
    for (int i = 0; i <= 3; i++) {
      yAxisLabels.add(minValue + (step * i));
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white, width: 1),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Steps',
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Y-axis labels on the left
              SizedBox(
                height: chartHeight * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: yAxisLabels.reversed.map((label) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        '$label',
                        style: const TextStyle(
                          color: kPrimaryColor,
                          fontSize: 12,
                          fontFamily: 'League Spartan',
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              // Chart bars
              Expanded(
                child: SizedBox(
                  height: chartHeight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: data.asMap().entries.map((entry) {
                      final value = entry.value['value'] as int;
                      final label = entry.value['label'] as String;
                      final barHeight = valueRange > 0
                          ? ((value - minValue) / valueRange) * availableHeight
                          : availableHeight * 0.5;

                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Stack with two colors: white on top, primary color on bottom
                            Container(
                              height: availableHeight,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 25,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    // White portion (top) - fills entire container
                                    Positioned.fill(
                                      child: Container(color: Colors.white),
                                    ),
                                    // Primary color portion (bottom) - overlays white
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      height: barHeight > 10 ? barHeight : 10,
                                      child: Container(color: kPrimaryColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(height: 2, color: Colors.white),
                            const SizedBox(height: 10),
                            Text(
                              label,
                              style: const TextStyle(
                                color: kPrimaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
