import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class CustomDayPickerDialog {
  final BuildContext context;
  final Color primaryColor;
  final Color secondaryColor;
  final DateTime initialDate;
  final Function(DateTime) onConfirm;

  CustomDayPickerDialog({
    required this.context,
    required this.primaryColor,
    required this.secondaryColor,
    required this.initialDate,
    required this.onConfirm,
  });

  late DateTime _temporarySelectedDate;

  void show() {
    _temporarySelectedDate = initialDate;

    final textStyle =
        TextStyle(color: primaryColor, fontWeight: FontWeight.w700);
    final config = CalendarDatePicker2WithActionButtonsConfig(
      dayTextStyle: textStyle,
      calendarType: CalendarDatePicker2Type.single,
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
      barrierLabel: "DayPicker",
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
                            'Day Picker',
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: primaryColor,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              onConfirm(_temporarySelectedDate);
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
                              value: [_temporarySelectedDate],
                              onValueChanged: (value) {
                                _temporarySelectedDate = value.first!;
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
