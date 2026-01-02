import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/month_utils.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/features/home/presentation/views/widgets/activity_card.dart';
import 'package:move_on/features/home/presentation/views/widgets/month_picker_bottom_sheet.dart';
import 'package:move_on/features/home/presentation/views/widgets/steps_activity_card.dart';
import 'package:move_on/features/home/presentation/views/widgets/steps_bar_chart.dart';
import 'package:move_on/features/profile/presentation/views/widgets/profile_vertical_divider.dart';

class ProgressTrackingViewBody extends StatefulWidget {
  const ProgressTrackingViewBody({super.key});

  @override
  State<ProgressTrackingViewBody> createState() =>
      _ProgressTrackingViewBodyState();
}

class _ProgressTrackingViewBodyState extends State<ProgressTrackingViewBody> {
  int _selectedTab = 0;
  int _selectedDay = 9;
  DateTime _selectedDate = DateTime.now();

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
                // Header of the screen
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

                // Container that contain the information of user (only show in Workout Log tab)
                if (_selectedTab == 0) ...[
                  Container(
                    width: double.infinity,
                    color: kPrimaryColor,
                    padding: EdgeInsets.all(screenWidth * 0.03),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16),
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
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    const Text(
                                      'Age: 21',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'League Spartan',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        ProfileVerticalDivider(
                                          color: const Color.fromARGB(
                                            255,
                                            255,
                                            167,
                                            84,
                                          ),
                                          height: 45,
                                          width: 8,
                                          radius: 6,
                                        ),
                                        const SizedBox(width: 6),
                                        const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '90 Kg',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'League Spartan',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              'Weight',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'League Spartan',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 50),
                                    Row(
                                      children: [
                                        ProfileVerticalDivider(
                                          color: const Color.fromARGB(
                                            255,
                                            255,
                                            167,
                                            84,
                                          ),
                                          height: 45,
                                          width: 8,
                                          radius: 6,
                                        ),
                                        const SizedBox(width: 6),
                                        const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '175 Cm',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'League Spartan',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              'Height',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'League Spartan',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/home3.png',
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
                  SizedBox(height: 20),
                ],

                // Tabs Section
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedTab = 0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.013,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(38),
                            color: _selectedTab == 0
                                ? kPrimaryColor
                                : Colors.white,
                          ),
                          child: Text(
                            'Workout Log',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: _selectedTab == 0
                                  ? Colors.black
                                  : kPrimaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'League Spartan',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedTab = 1),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.013,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(38),
                            color: _selectedTab == 1
                                ? kPrimaryColor
                                : Colors.white,
                          ),
                          child: Text(
                            'Charts',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: _selectedTab == 1
                                  ? Colors.black
                                  : kPrimaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'League Spartan',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Content based on selected tab
                if (_selectedTab == 0) ...[
                  // Workout Log Tab - Calendar Section
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Container(height: 1, color: Colors.white),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              'Choose Date',
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'League Spartan',
                              ),
                            ),
                            GestureDetector(
                              onTap: () => MonthPickerBottomSheet.show(
                                context,
                                _selectedDate,
                                (newDate) {
                                  setState(() {
                                    _selectedDate = newDate;
                                  });
                                },
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    MonthUtils.getMonthName(
                                      _selectedDate.month,
                                    ),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'League Spartan',
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    color: kPrimaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(height: 1, color: Colors.white),
                        const SizedBox(height: 20),

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
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        day,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'League Spartan',
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                        ),
                        const SizedBox(height: 10),

                        // Calendar Grid
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: kPrimaryColor, width: 2),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 7,
                                  mainAxisSpacing: 1,
                                  crossAxisSpacing: 10,
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
                                            ? Colors.black
                                            : kPrimaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'League Spartan',
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
                  const SizedBox(height: 12),

                  // Activities Section
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: const Text(
                      'Activities',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      ActivityCard(
                        icon: Icons.directions_run,
                        icon2: FontAwesomeIcons.fire,
                        calories: '120 Kcal',
                        workoutType: 'Upper Body Workout',
                        date: 'June 09',
                        duration: '25 Mins',
                      ),
                      const SizedBox(height: 20),
                      ActivityCard(
                        icon: Icons.directions_run,
                        icon2: FontAwesomeIcons.fire,
                        calories: '130 Kcal',
                        workoutType: 'Pull Out',
                        date: 'April 15 - 4:00 PM',
                        duration: '30 Mins',
                      ),
                    ],
                  ),
                ] else ...[
                  // Charts Tab
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // My Progress Title
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'My Progress',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Date Display
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: GestureDetector(
                          onTap: () => MonthPickerBottomSheet.show(
                            context,
                            _selectedDate,
                            (newDate) {
                              setState(() {
                                _selectedDate = newDate;
                              });
                            },
                          ),
                          child: Row(
                            children: [
                              Text(
                                '${MonthUtils.getMonthName(_selectedDate.month)} ${_selectedDate.day}${_getDaySuffix(_selectedDate.day)}',
                                style: const TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Steps Chart
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: StepsBarChart(
                          data: [
                            {'label': 'Jan', 'value': 130},
                            {'label': 'Feb', 'value': 140},
                            {'label': 'Mar', 'value': 130},
                            {'label': 'Apr', 'value': 110},
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Steps Activity Cards
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            StepsActivityCard(
                              day: 'Thu',
                              date: '14',
                              steps: '3,679',
                              duration: '1hr40m',
                            ),
                            const SizedBox(height: 12),
                            StepsActivityCard(
                              day: 'Wen',
                              date: '20',
                              steps: '5,789',
                              duration: '1hr20m',
                            ),
                            const SizedBox(height: 12),
                            StepsActivityCard(
                              day: 'Sat',
                              date: '22',
                              steps: '1,859',
                              duration: '1hr10m',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}
