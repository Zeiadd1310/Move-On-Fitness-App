import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/services/local_storage_service.dart';
import 'package:move_on/core/utils/functions/api_service.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/helpers/month_utils.dart';
import 'package:move_on/core/utils/helpers/responsive_helper.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/features/home/data/models/progress_entry_model.dart';
import 'package:move_on/features/home/presentation/cubits/progress_cubit/progress_cubit.dart';
import 'package:move_on/features/home/presentation/cubits/progress_cubit/progress_state.dart';
import 'package:move_on/features/home/presentation/views/widgets/activity_card.dart';
import 'package:move_on/features/home/presentation/views/widgets/month_picker_bottom_sheet.dart';
import 'package:move_on/features/home/presentation/views/widgets/steps_activity_card.dart';
import 'package:move_on/features/home/presentation/views/widgets/steps_bar_chart.dart';
import 'package:move_on/features/profile/data/models/user_profile_model.dart';
import 'package:move_on/features/profile/data/repos/profile_repo_impl.dart';
import 'package:move_on/features/profile/presentation/views/widgets/profile_vertical_divider.dart';

class ProgressTrackingViewBody extends StatefulWidget {
  const ProgressTrackingViewBody({super.key});

  @override
  State<ProgressTrackingViewBody> createState() =>
      _ProgressTrackingViewBodyState();
}

class _ProgressTrackingViewBodyState extends State<ProgressTrackingViewBody> {
  int _selectedTab = 0;
  int _selectedDay = DateTime.now().day;
  DateTime _selectedDate = DateTime.now();
  UserProfileModel? _profile;
  String _pendingGender = '';
  String? _token;
  List<Map<String, dynamic>> _workoutHistory = [];

  @override
  void initState() {
    super.initState();
    _loadProfile();
    _loadToken();
    _loadWorkoutHistory();
  }

  Future<void> _loadWorkoutHistory() async {
    final localStorage = LocalStorageService();
    final history = await localStorage.loadWorkoutHistory();
    if (mounted) {
      setState(() => _workoutHistory = history);
    }
  }

  Future<void> _loadToken() async {
    final localStorage = LocalStorageService();
    final token = await localStorage.getToken(); // adjust to your actual method
    setState(() => _token = token);
    if (mounted) {
      context.read<ProgressCubit>().loadProgress(token ?? '');
    }
  }

  Future<void> _loadProfile() async {
    final localStorage = LocalStorageService();
    final cached = await localStorage.loadCachedUserProfile();
    final pending = await localStorage.getPendingProfileData();
    if (cached != null && mounted) {
      setState(() {
        _profile = UserProfileModel.fromJson(cached);
        _pendingGender = pending['gender'] ?? '';
      });
    } else if (mounted) {
      setState(() {
        _pendingGender = pending['gender'] ?? '';
      });
    }

    final repo = ProfileRepoImpl(
      apiService: ApiService(),
      localStorageService: localStorage,
    );
    try {
      final remote = await repo.getMyProfile();
      if (!mounted) return;
      setState(() => _profile = remote);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    final horizontalPadding = responsive.horizontalPadding();
    final verticalPadding = responsive.verticalPadding();
    final iconSize = responsive.iconSize(25);
    final headerIconSize = responsive.iconSize(30);
    final titleFontSize = responsive.fontSize(24);
    final tabFontSize = responsive.fontSize(18);
    final screenWidth = responsive.width;
    final screenHeight = responsive.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ──────────────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: iconSize,
                      ),
                    ),
                    Text(
                      'Progress Tracking',
                      style: Styles.textStyle24.copyWith(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: titleFontSize,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => GoRouter.of(
                            context,
                          ).push(AppRouter.kNotificationSettingsView),
                          icon: Icon(
                            Icons.notifications,
                            color: kPrimaryColor,
                            size: headerIconSize,
                          ),
                        ),
                        IconButton(
                          onPressed: () =>
                              GoRouter.of(context).push(AppRouter.kProfileView),
                          icon: Icon(
                            Icons.person,
                            color: kPrimaryColor,
                            size: headerIconSize,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // ── Profile card (Workout Log tab only) ─────────────────
                if (_selectedTab == 0) ...[
                  BlocBuilder<ProgressCubit, ProgressState>(
                    builder: (context, state) {
                      // Pick latest values from API if available
                      String weight = _profile?.weight.isNotEmpty == true
                          ? '${_profile!.weight} Kg'
                          : '-- Kg';
                      String height = _profile?.height.isNotEmpty == true
                          ? '${_profile!.height} Cm'
                          : '-- Cm';

                      if (state is ProgressLoaded) {
                        if (state.latest?.weight != null) {
                          weight =
                              '${state.latest!.weight!.toStringAsFixed(1)} Kg';
                        }
                      }

                      return Container(
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
                                        Expanded(
                                          child: Text(
                                            _profile?.fullName.isNotEmpty ==
                                                    true
                                                ? _profile!.fullName
                                                : 'Athlete',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Icon(_genderIconData, size: 30),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Age: ${_profile?.ageInYearsText ?? '--'}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'League Spartan',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        _buildStatTile(
                                          value: weight,
                                          label: 'Weight',
                                        ),
                                        _buildStatTile(
                                          value: height,
                                          label: 'Height',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              width: screenWidth < 370 ? 90 : 110,
                              height: screenWidth < 370 ? 90 : 110,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(child: _buildProfileImage()),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],

                // ── Tabs ─────────────────────────────────────────────────
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
                              fontSize: tabFontSize,
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
                              fontSize: tabFontSize,
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

                // ── Tab Content ───────────────────────────────────────────
                BlocBuilder<ProgressCubit, ProgressState>(
                  builder: (context, state) {
                    if (state is ProgressLoading) {
                      return const SizedBox(
                        height: 300,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: kPrimaryColor,
                          ),
                        ),
                      );
                    }

                    if (state is ProgressError) {
                      return SizedBox(
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.message,
                                style: const TextStyle(color: Colors.red),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: () => context
                                    .read<ProgressCubit>()
                                    .loadProgress(_token ?? ''),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kPrimaryColor,
                                ),
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    if (_selectedTab == 0) {
                      return _buildWorkoutLogTab(state, screenWidth);
                    } else {
                      return _buildChartsTab(state);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Workout Log Tab ────────────────────────────────────────────────────
  Widget _buildWorkoutLogTab(ProgressState state, double screenWidth) {
    // Filter history for selected day in selected month (progress entries)
    List<ProgressEntryModel> activitiesForDay = [];
    if (state is ProgressLoaded) {
      activitiesForDay = state.history.where((entry) {
        if (entry.date == null) return false;
        final entryDate = DateTime.tryParse(entry.date!);
        if (entryDate == null) return false;
        return entryDate.day == _selectedDay &&
            entryDate.month == _selectedDate.month &&
            entryDate.year == _selectedDate.year;
      }).toList();
    }

    // Filter workout history for selected day
    List<Map<String, dynamic>> workoutsForDay = _workoutHistory.where((
      workout,
    ) {
      final dateStr = workout['date'] as String?;
      if (dateStr == null) return false;
      final workoutDate = DateTime.tryParse(dateStr);
      if (workoutDate == null) return false;
      return workoutDate.day == _selectedDay &&
          workoutDate.month == _selectedDate.month &&
          workoutDate.year == _selectedDate.year;
    }).toList();

    // Days that have progress entries OR workout entries this month (for highlighting)
    final Set<int> activeDays = {};
    if (state is ProgressLoaded) {
      for (final entry in state.history) {
        if (entry.date == null) continue;
        final d = DateTime.tryParse(entry.date!);
        if (d != null &&
            d.month == _selectedDate.month &&
            d.year == _selectedDate.year) {
          activeDays.add(d.day);
        }
      }
    }
    // Add workout days to active days
    for (final workout in _workoutHistory) {
      final dateStr = workout['date'] as String?;
      if (dateStr == null) continue;
      final d = DateTime.tryParse(dateStr);
      if (d != null &&
          d.month == _selectedDate.month &&
          d.year == _selectedDate.year) {
        activeDays.add(d.day);
      }
    }

    // Calculate days in month and first day offset
    final daysInMonth = DateTime(
      _selectedDate.year,
      _selectedDate.month + 1,
      0,
    ).day;
    final firstDayOfMonth = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      1,
    );
    // Monday = 0, Sunday = 6 (adjust for 1-indexed days)
    int firstDayWeekday = firstDayOfMonth.weekday - 1;
    if (firstDayWeekday < 0) firstDayWeekday = 6;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Calendar
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
                      (newDate) => setState(() {
                        _selectedDate = newDate;
                        _selectedDay = 1;
                      }),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '${MonthUtils.getMonthName(_selectedDate.month)} ${_selectedDate.year}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'League Spartan',
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.arrow_drop_down, color: kPrimaryColor),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(height: 1, color: Colors.white),
              const SizedBox(height: 20),

              // Day-of-week headers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN']
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

              // Calendar grid
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: firstDayWeekday + daysInMonth,
                  itemBuilder: (context, index) {
                    // Empty cells for days before the first of the month
                    if (index < firstDayWeekday) {
                      return const SizedBox.shrink();
                    }
                    final day = index - firstDayWeekday + 1;
                    final isSelected = day == _selectedDay;
                    final hasActivity = activeDays.contains(day);

                    return GestureDetector(
                      onTap: () => setState(() => _selectedDay = day),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
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
                          // Small dot for days with progress entries
                          if (hasActivity && !isSelected)
                            Positioned(
                              bottom: 2,
                              child: Container(
                                width: 4,
                                height: 4,
                                decoration: const BoxDecoration(
                                  color: kPrimaryColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Activities section
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'Activities',
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 22,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Show both progress entries and workout entries for selected day
        if ((state is ProgressLoaded && activitiesForDay.isNotEmpty) ||
            workoutsForDay.isNotEmpty) ...[
          // Progress entries
          if (state is ProgressLoaded) ...[
            ...activitiesForDay.map((entry) {
              final dateLabel = entry.date != null
                  ? _formatEntryDate(entry.date!)
                  : '--';
              final weightLabel = entry.weight != null
                  ? '${entry.weight!.toStringAsFixed(1)} Kg'
                  : '--';
              final bmiLabel = entry.bmi != null
                  ? 'BMI ${entry.bmi!.toStringAsFixed(1)}'
                  : '--';

              return Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ActivityCard(
                  icon: Icons.monitor_weight_outlined,
                  icon2: FontAwesomeIcons.chartLine,
                  calories: bmiLabel,
                  workoutType: 'Weight: $weightLabel',
                  date: dateLabel,
                  duration: entry.fatPercentage != null
                      ? 'Fat ${entry.fatPercentage!.toStringAsFixed(1)}%'
                      : '--',
                ),
              );
            }),
          ],
          // Workout entries
          ...workoutsForDay.map((workout) {
            final dateStr = workout['date'] as String? ?? '--';
            final workoutType = workout['workoutType'] as String? ?? 'Workout';
            final calories = workout['calories'] as String? ?? '--';
            final duration = workout['duration'] as String? ?? '--';

            return Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ActivityCard(
                icon: Icons.directions_run,
                icon2: FontAwesomeIcons.fire,
                calories: calories,
                workoutType: workoutType,
                date: _formatEntryDate(dateStr),
                duration: duration,
              ),
            );
          }),
        ] else if (state is ProgressLoaded) ...[
          // No entries for this day
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 32),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Icon(Icons.event_busy, color: kPrimaryColor, size: 40),
                const SizedBox(height: 8),
                Text(
                  'No activity logged for ${MonthUtils.getMonthName(_selectedDate.month)} $_selectedDay',
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ] else ...[
          // Fallback hardcoded while loading
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
      ],
    );
  }

  // ── Charts Tab ──────────────────────────────────────────────────────────
  Widget _buildChartsTab(ProgressState state) {
    // Build chart data from API
    List<Map<String, dynamic>> chartData = [
      {'label': 'Jan', 'value': 130},
      {'label': 'Feb', 'value': 140},
      {'label': 'Mar', 'value': 130},
      {'label': 'Apr', 'value': 110},
    ];

    List<ProgressEntryModel> historyItems = [];

    if (state is ProgressLoaded) {
      // Use chartData from API (weight by month)
      if (state.chartData.isNotEmpty) {
        final Map<String, double> monthWeights = {};
        for (final entry in state.chartData) {
          if (entry.date == null) continue;
          final d = DateTime.tryParse(entry.date!);
          if (d == null) continue;
          final monthLabel = MonthUtils.getMonthName(d.month).substring(0, 3);
          // Average if multiple entries same month
          if (!monthWeights.containsKey(monthLabel)) {
            monthWeights[monthLabel] = entry.weight ?? 0;
          }
        }
        if (monthWeights.isNotEmpty) {
          chartData = monthWeights.entries
              .map((e) => {'label': e.key, 'value': e.value.toInt()})
              .toList();
        }
      }

      // History for the steps cards — show last 3 entries
      historyItems = state.history.take(3).toList();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: GestureDetector(
            onTap: () => MonthPickerBottomSheet.show(
              context,
              _selectedDate,
              (newDate) => setState(() => _selectedDate = newDate),
            ),
            child: Text(
              '${MonthUtils.getMonthName(_selectedDate.month)} ${_selectedDate.day}${_getDaySuffix(_selectedDate.day)}',
              style: const TextStyle(
                color: kPrimaryColor,
                fontSize: 24,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Bar chart
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: StepsBarChart(data: chartData),
        ),
        const SizedBox(height: 24),

        // History cards
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: state is ProgressLoaded && historyItems.isNotEmpty
                ? historyItems.asMap().entries.map((entry) {
                    final item = entry.value;
                    final d = item.date != null
                        ? DateTime.tryParse(item.date!)
                        : null;
                    final dayName = d != null ? _weekdayShort(d.weekday) : '--';
                    final dayNum = d != null ? '${d.day}' : '--';
                    final stepsVal = item.weight != null
                        ? '${item.weight!.toStringAsFixed(1)} kg'
                        : '--';
                    final fatVal = item.fatPercentage != null
                        ? '${item.fatPercentage!.toStringAsFixed(1)}%'
                        : '--';

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: StepsActivityCard(
                        day: dayName,
                        date: dayNum,
                        steps: stepsVal,
                        duration: fatVal,
                      ),
                    );
                  }).toList()
                : [
                    // Fallback hardcoded
                    const StepsActivityCard(
                      day: 'Thu',
                      date: '14',
                      steps: '3,679',
                      duration: '1hr40m',
                    ),
                    const SizedBox(height: 12),
                    const StepsActivityCard(
                      day: 'Wen',
                      date: '20',
                      steps: '5,789',
                      duration: '1hr20m',
                    ),
                    const SizedBox(height: 12),
                    const StepsActivityCard(
                      day: 'Sat',
                      date: '22',
                      steps: '1,859',
                      duration: '1hr10m',
                    ),
                  ],
          ),
        ),

        // Analysis insight (if available)
        if (state is ProgressLoaded && state.analysis?.insight != null) ...[
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: kPrimaryColor, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'AI Insight',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  state.analysis!.insight!,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                  ),
                ),
                if (state.analysis!.weightStatus != null) ...[
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildBadge('Weight: ${state.analysis!.weightStatus}'),
                      if (state.analysis!.fatStatus != null)
                        _buildBadge('Fat: ${state.analysis!.fatStatus}'),
                      if (state.analysis!.muscleStatus != null)
                        _buildBadge('Muscle: ${state.analysis!.muscleStatus}'),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }

  // ── Helpers ────────────────────────────────────────────────────────────
  Widget _buildBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: kPrimaryColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kPrimaryColor),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: kPrimaryColor,
          fontSize: 12,
          fontFamily: 'League Spartan',
        ),
      ),
    );
  }

  String _formatEntryDate(String isoDate) {
    final d = DateTime.tryParse(isoDate);
    if (d == null) return isoDate;
    return '${MonthUtils.getMonthName(d.month)} ${d.day}';
  }

  String _weekdayShort(int weekday) {
    const names = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return names[(weekday - 1).clamp(0, 6)];
  }

  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
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

  Widget _buildProfileImage() {
    final imageUrl = _profile?.profilePictureUrl.trim() ?? '';
    final parsed = Uri.tryParse(imageUrl);
    final isValid =
        parsed != null &&
        (parsed.scheme == 'http' || parsed.scheme == 'https') &&
        parsed.host.isNotEmpty;
    if (isValid) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _fallbackAvatar(),
      );
    }
    return _fallbackAvatar();
  }

  Widget _fallbackAvatar() => Container(
    color: Colors.grey[800],
    child: const Icon(Icons.person, color: Colors.white, size: 40),
  );

  Widget _buildStatTile({required String value, required String label}) {
    return Row(
      children: [
        ProfileVerticalDivider(
          color: const Color.fromARGB(255, 255, 167, 84),
          height: 45,
          width: 8,
          radius: 6,
        ),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'League Spartan',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'League Spartan',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  IconData get _genderIconData {
    final gender =
        (_profile?.gender.trim().isNotEmpty == true
                ? _profile!.gender
                : _pendingGender)
            .trim()
            .toLowerCase();
    if (gender == 'female' ||
        gender == 'f' ||
        gender == '0' ||
        gender == 'false') {
      return Icons.female;
    }
    if (gender == 'male' ||
        gender == 'm' ||
        gender == '1' ||
        gender == 'true') {
      return Icons.male;
    }
    return Icons.person;
  }
}
