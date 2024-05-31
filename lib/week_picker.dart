import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

/// A custom dialog for picking a week range.
class CustomWeekPickerDialog {
  /// The build context of the parent widget.
  final BuildContext context;

  /// The primary color used for text and icons.
  final Color primaryColor;

  /// The secondary color used for backgrounds.
  final Color secondaryColor;

  /// The start date of the initial selected range.
  final DateTime startDate;

  /// The end date of the initial selected range.
  final DateTime endDate;

  /// The callback function to be executed when the user confirms their selection.
  final Function(DateTime, DateTime) onConfirm;

  /// Creates a [CustomWeekPickerDialog] with the provided [context], [primaryColor], [secondaryColor], [startDate], [endDate], and [onConfirm] callback.
  CustomWeekPickerDialog({
    required this.context,
    required this.primaryColor,
    required this.secondaryColor,
    required this.startDate,
    required this.endDate,
    required this.onConfirm,
  });

  /// The temporary selected date range during the dialog interaction.
  late List<DateTime?> _dateRangePickerValue;

  /// Displays the week picker dialog.
  void show() {
    _dateRangePickerValue = [startDate, endDate];

    final textStyle =
        TextStyle(color: primaryColor, fontWeight: FontWeight.w700);
    final config = CalendarDatePicker2WithActionButtonsConfig(
      dayTextStyle: textStyle,
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: primaryColor,
      closeDialogOnCancelTapped: true,
      firstDayOfWeek: 1,
      weekdayLabelTextStyle: TextStyle(
        color: primaryColor,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: TextStyle(
        color: primaryColor,
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
      ),
      lastMonthIcon: Icon(
        Icons.arrow_back_ios,
        color: primaryColor,
        size: 16.sp,
      ),
      nextMonthIcon: Icon(
        Icons.arrow_forward_ios,
        color: primaryColor,
        size: 16.sp,
      ),
      centerAlignModePicker: true,
      customModePickerIcon: const SizedBox(),
      selectedDayTextStyle: textStyle.copyWith(
        color: secondaryColor,
      ),
      selectedMonthTextStyle: textStyle.copyWith(
        color: secondaryColor,
      ),
      selectedYearTextStyle: textStyle.copyWith(
        color: secondaryColor,
      ),
    );

    showGeneralDialog(
      barrierLabel: "WeekPicker",
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: secondaryColor,
                  height: 86.h,
                  child: Column(
                    children: [
                      SizedBox(height: 40.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            'Week Picker',
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: primaryColor,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (_dateRangePickerValue[0] != null &&
                                  _dateRangePickerValue[1] != null) {
                                onConfirm(
                                  _dateRangePickerValue[0]!,
                                  _dateRangePickerValue[1]!,
                                );
                              }
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.check, color: primaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1.h,
                  decoration: BoxDecoration(
                    color: primaryColor,
                  ),
                ),
                SizedBox(
                  height: 290.h,
                  child: Material(
                    color: secondaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.sp),
                      bottomRight: Radius.circular(10.sp),
                    ),
                    child: StatefulBuilder(
                      builder:
                          (BuildContext context, StateSetter dialogSetState) {
                        return Column(
                          children: [
                            CalendarDatePicker2(
                              config: config,
                              value: _dateRangePickerValue,
                              onValueChanged: (value) {
                                dialogSetState(() {
                                  _dateRangePickerValue = value;
                                });
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
