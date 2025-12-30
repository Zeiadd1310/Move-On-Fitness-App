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

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: chartHeight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: data.asMap().entries.map((entry) {
                final value = entry.value['value'] as int;
                final label = entry.value['label'] as String;
                final height = valueRange > 0
                    ? ((value - minValue) / valueRange) * availableHeight
                    : availableHeight * 0.5;

                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: double.infinity,
                        height: height > 10 ? height : 10,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        label,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'League Spartan',
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$minValue',
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                  fontFamily: 'League Spartan',
                ),
              ),
              Text(
                '$maxValue',
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                  fontFamily: 'League Spartan',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
