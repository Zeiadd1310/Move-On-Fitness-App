import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/styles.dart';

class ProgressTrackingViewBody extends StatefulWidget {
  const ProgressTrackingViewBody({super.key});

  @override
  State<ProgressTrackingViewBody> createState() =>
      _ProgressTrackingViewBodyState();
}

class _ProgressTrackingViewBodyState extends State<ProgressTrackingViewBody> {
  int _selectedTab = 0;
  int _selectedDay = 9;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.045,
              vertical: screenHeight * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: Icon(Icons.arrow_back_ios_new_rounded, size: 25),
                    ),
                    Text(
                      'Progess Tracking',
                      style: Styles.textStyle24.copyWith(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                            color: kPrimaryColor,
                            size: 30,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            GoRouter.of(
                              context,
                            ).push(AppRouter.kNotificationSettingsView);
                          },
                          icon: const Icon(
                            Icons.notifications,
                            color: kPrimaryColor,
                            size: 30,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            GoRouter.of(context).push(AppRouter.kProfileView);
                          },
                          icon: const Icon(
                            Icons.person,
                            color: kPrimaryColor,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  color: kPrimaryColor,
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Zeiad',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.male, size: 30),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Text(
                                  'Age: 21',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  Icons.female,
                                  color: kPrimaryColor.withOpacity(0.5),
                                  size: 16,
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Container(
                                  width: 1,
                                  height: 30,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 12),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '90 Kg',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '1.77 CM',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  width: 1,
                                  height: 30,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/profile.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[800],
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Tabs Section
                Container(
                  color: Colors.black,
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedTab = 0),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.02,
                            ),
                            decoration: BoxDecoration(
                              color: _selectedTab == 0
                                  ? kPrimaryColor
                                  : Colors.transparent,
                            ),
                            child: Text(
                              'Workout Log',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _selectedTab == 0
                                    ? Colors.white
                                    : kPrimaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedTab = 1),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.02,
                            ),
                            decoration: BoxDecoration(
                              color: _selectedTab == 1
                                  ? kPrimaryColor
                                  : Colors.transparent,
                            ),
                            child: Text(
                              'Charts',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _selectedTab == 1
                                    ? Colors.white
                                    : kPrimaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Divider
                Container(height: 1, color: Colors.white),

                // Calendar Section
                Container(
                  color: Colors.black,
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Choose Date',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Row(
                            children: [
                              const Text(
                                'Month',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(height: 1, color: Colors.white),
                      const SizedBox(height: 16),

                      // Days of week
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:
                            ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN']
                                .map(
                                  (day) => Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      day,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                      const SizedBox(height: 16),

                      // Calendar Grid
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 7,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                              ),
                          itemCount: 31,
                          itemBuilder: (context, index) {
                            final day = index + 1;
                            final isSelected = day == _selectedDay;
                            return GestureDetector(
                              onTap: () => setState(() => _selectedDay = day),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? kPrimaryColor
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '$day',
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : kPrimaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Activities Section
                Container(
                  color: Colors.black,
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Activities',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 16),
                      _ActivityCard(
                        icon: Icons.directions_run,
                        calories: '120 Kcal',
                        workoutType: 'Upper Body Workout',
                        date: 'June 09',
                        duration: '25 Mins',
                      ),
                      const SizedBox(height: 12),
                      _ActivityCard(
                        icon: Icons.directions_run,
                        calories: '130 Kcal',
                        workoutType: 'Pull Out',
                        date: 'April 15 - 4:00 PM',
                        duration: '30 Mins',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final IconData icon;
  final String calories;
  final String workoutType;
  final String date;
  final String duration;

  const _ActivityCard({
    required this.icon,
    required this.calories,
    required this.workoutType,
    required this.date,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white, width: 1),
      ),
      padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
      child: Row(
        children: [
          Container(
            width: isSmallScreen ? 50 : 60,
            height: isSmallScreen ? 50 : 60,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: isSmallScreen ? 30 : 40,
            ),
          ),
          SizedBox(width: isSmallScreen ? 12 : 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  calories,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: isSmallScreen ? 16 : 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'League Spartan',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  workoutType,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isSmallScreen ? 14 : 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isSmallScreen ? 12 : 14,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Duration',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.access_time, color: kPrimaryColor, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    duration,
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: isSmallScreen ? 14 : 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'League Spartan',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
