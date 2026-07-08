import 'package:flutter/material.dart';

import 'package:aidm/feature/calendar/presentation/pages/calendar_page.dart';
import 'package:aidm/feature/more/presenation/pages/more_page.dart';
import 'package:aidm/feature/recordings/presentation/pages/recordings_page.dart';
import 'package:aidm/feature/webinar/presentation/pages/webinar_page.dart';

import '../../../../core/constant/app_animations.dart';
import '../../../../core/constant/app_dimensions.dart';

import '../../../../core/theme/app_theme_extension.dart';

import '../../../../core/widgets/button/app_button.dart';
import '../../../../core/widgets/carousel/app_carousel_dots.dart';
import '../../../../core/widgets/input/app_input2.dart';
import '../../../../core/widgets/input/app_input1.dart';
import '../../../../core/widgets/nav/app_navbar.dart';
import '../../../../core/widgets/toggle/app_toggle.dart';
import '../../../../core/widgets/datepicker/app_date_picker.dart';
import '../../../../core/widgets/datepicker/app_time_picker.dart';
import '../../../../core/widgets/datepicker/show_app_date_picker.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = AppNavBarItem.dashboard.index;
  int _carouselIndex = 0;
  late final PageController _carouselController;
  bool _switchValue = false;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  static const int _carouselItemCount = 3;

  @override
  void initState() {
    super.initState();
    _carouselController = PageController();
  }

  @override
  void dispose() {
    _carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final selectedItem = AppNavbar.items[_selectedIndex];

    return Scaffold(
      backgroundColor: theme.backgroundPage,
      appBar: AppBar(
        title: AnimatedSwitcher(
          duration: AppAnimations.contentDuration,
          switchInCurve: AppAnimations.standardCurve,
          switchOutCurve: AppAnimations.exitCurve,
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0, AppAnimations.titleSlideOffset),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: Text(
            selectedItem.label,
            key: ValueKey<String>(selectedItem.label),
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: AppAnimations.contentDuration,
        switchInCurve: AppAnimations.standardCurve,
        switchOutCurve: AppAnimations.exitCurve,
        transitionBuilder: (child, animation) {
          final slideAnimation = CurvedAnimation(
            parent: animation,
            curve: AppAnimations.standardCurve,
          );

          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, AppAnimations.contentSlideOffset),
                end: Offset.zero,
              ).animate(slideAnimation),
              child: child,
            ),
          );
        },
        layoutBuilder: (currentChild, previousChildren) {
          return Stack(
            alignment: Alignment.topCenter,
            children: [...previousChildren, ?currentChild],
          );
        },
        child: KeyedSubtree(
          key: ValueKey<int>(_selectedIndex),
          child: _buildBodyForIndex(_selectedIndex),
        ),
      ),
      bottomNavigationBar: AppNavbar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }

  Widget _buildBodyForIndex(int index) {
    return switch (AppNavbar.items[index]) {
      AppNavBarItem.dashboard => _buildDashboardContent(),
      AppNavBarItem.webinars => const WebinarPage(),
      AppNavBarItem.calendar => const CalendarPage(),
      AppNavBarItem.recordings => const RecordingsPage(),
      AppNavBarItem.more => const MorePage(),
    };
  }

  Widget _buildDashboardContent() {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;

    return SingleChildScrollView(
      padding: EdgeInsets.all(AppDimensions.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Input field',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: theme.textPrimary,
            ),
          ),
          SizedBox(height: AppDimensions.spacingMd),
          const AppInput(),
          SizedBox(height: AppDimensions.spacing3xl),
          Text(
            'Input field 2',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: theme.textPrimary,
            ),
          ),
          SizedBox(height: AppDimensions.spacingMd),
          const AppInput2(),
          SizedBox(height: AppDimensions.spacing3xl),
          Text(
            'Buttons',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: theme.textPrimary,
            ),
          ),
          SizedBox(height: AppDimensions.spacingMd),
          AppButton1(label: 'Button', onPressed: () {}),
          SizedBox(height: AppDimensions.spacingMd),
          AppButton1(label: 'Button', isLoading: true, onPressed: () {}),
          SizedBox(height: AppDimensions.spacingMd),
          const AppButton1(label: 'Button', enabled: false),
          SizedBox(height: AppDimensions.spacingMd),
          const AppButton1(label: 'Button', type: AppButton1Type.secondary),

          SizedBox(height: AppDimensions.spacing3xl),
          Text(
            'Carousel dots',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: theme.textPrimary,
            ),
          ),
          SizedBox(height: AppDimensions.spacingMd),
          SizedBox(
            height: 160,
            child: PageView.builder(
              controller: _carouselController,
              itemCount: _carouselItemCount,
              onPageChanged: (index) => setState(() => _carouselIndex = index),
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: AppDimensions.spacingXs,
                  ),
                  decoration: BoxDecoration(
                    color: theme.backgroundInput,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
                    border: Border.all(color: theme.borderDefault),
                  ),
                  child: Center(
                    child: Text(
                      'Slide ${index + 1}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: theme.textSecondary,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: AppDimensions.spacingMd),
          Center(
            child: AppCarouselDots(
              count: _carouselItemCount,
              currentIndex: _carouselIndex,
              onDotTap: (index) {
                _carouselController.animateToPage(
                  index,
                  duration: AppAnimations.contentDuration,
                  curve: AppAnimations.standardCurve,
                );
              },
            ),
          ),

          SizedBox(height: AppDimensions.spacing3xl),
          Text(
            'Switch',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: theme.textPrimary,
            ),
          ),
          SizedBox(height: AppDimensions.spacingMd),
          AppToggle(
            value: _switchValue,
            onChanged: (value) {
              setState(() {
                _switchValue = value;
              });
            },
          ),
          SizedBox(height: AppDimensions.spacing3xl),
          Text(
            'Date picker',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: theme.textPrimary,
            ),
          ),
          SizedBox(height: AppDimensions.spacingMd),
          AppDatePicker(
            initialDate: _selectedDate,
            onDateChanged: (date) => setState(() => _selectedDate = date),
            onClear: () => setState(() => _selectedDate = DateTime.now()),
            onDone: () {},
          ),
          SizedBox(height: AppDimensions.spacing3xl),
          Text(
            'Time picker',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: theme.textPrimary,
            ),
          ),
          SizedBox(height: AppDimensions.spacingMd),
          AppTimePicker(
            initialTime: _selectedTime,
            onTimeChanged: (time) => setState(() => _selectedTime = time),
            onClear: () => setState(() => _selectedTime = TimeOfDay.now()),
            onDone: () {},
          ),
          SizedBox(height: AppDimensions.spacingMd),
          AppButton1(
            label: 'Open date picker',
            onPressed: () async {
              final date = await showAppDatePicker(
                context,
                initialDate: _selectedDate,
              );
              if (date != null) {
                setState(() => _selectedDate = date);
              }
            },
          ),
          SizedBox(height: AppDimensions.spacingMd),
          AppButton1(
            label: 'Open time picker',
            onPressed: () async {
              final time = await showAppTimePicker(
                context,
                initialTime: _selectedTime,
              );
              if (time != null) {
                setState(() => _selectedTime = time);
              }
            },
          ),
        ],
      ),
    );
  }
}
