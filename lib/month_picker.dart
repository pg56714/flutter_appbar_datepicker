import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

/// A custom dialog for picking a single month.
class CustomMonthPickerDialog {
  /// The build context of the parent widget.
  final BuildContext context;

  /// The primary color used for text and icons.
  final Color primaryColor;

  /// The secondary color used for backgrounds.
  final Color secondaryColor;

  /// The initially selected date when the dialog is first displayed.
  final DateTime initialDate;

  /// The callback function to be executed when the user confirms their selection.
  final Function(DateTime) onConfirm;

  /// Creates a [CustomMonthPickerDialog] with the provided [context], [primaryColor], [secondaryColor], [initialDate], and [onConfirm] callback.
  CustomMonthPickerDialog({
    required this.context,
    required this.primaryColor,
    required this.secondaryColor,
    required this.initialDate,
    required this.onConfirm,
  });

  /// The year currently being displayed in the picker.
  int _pickerYear = DateTime.now().year;

  /// The temporary selected month during the dialog interaction.
  late DateTime _temporarySelectedMonth;

  /// Displays the month picker dialog.
  void show() {
    _temporarySelectedMonth = initialDate;

    showGeneralDialog(
      barrierLabel: "MonthPicker",
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
                            icon: Icon(Icons.arrow_back, color: primaryColor),
                          ),
                          Text(
                            'Month Picker',
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: primaryColor,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              onConfirm(_temporarySelectedMonth);
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
                  height: 150.h, // 增加這裡的高度以確保所有元素都能顯示
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
                            _navigationRow(dialogSetState),
                            Expanded(
                              // 使用 Expanded 包裹月份生成部分
                              child: Column(
                                children: _generateMonths(dialogSetState),
                              ),
                            ),
                            SizedBox(height: 10.h),
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

  /// Generates a row of month buttons from [from] to [to].
  List<Widget> _generateRowOfMonths(
      int from, int to, StateSetter dialogSetState) {
    List<Widget> months = [];
    for (int i = from; i <= to; i++) {
      DateTime dateTime = DateTime(_pickerYear, i, 1);

      months.add(
        Flexible(
          child: AnimatedSwitcher(
            duration: kThemeChangeDuration,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: TextButton(
              onPressed: () {
                dialogSetState(() {
                  _temporarySelectedMonth = dateTime;
                });
              },
              style: TextButton.styleFrom(
                backgroundColor:
                    _temporarySelectedMonth.month == dateTime.month &&
                            _temporarySelectedMonth.year == dateTime.year
                        ? primaryColor
                        : Colors.transparent,
              ),
              child: Text(
                DateFormat('MM').format(dateTime),
                style: TextStyle(
                  color: _temporarySelectedMonth.month == dateTime.month &&
                          _temporarySelectedMonth.year == dateTime.year
                      ? secondaryColor
                      : primaryColor,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return months;
  }

  /// Generates rows of months for the picker dialog.
  List<Widget> _generateMonths(StateSetter dialogSetState) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _generateRowOfMonths(1, 6, dialogSetState),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _generateRowOfMonths(7, 12, dialogSetState),
      ),
    ];
  }

  /// Generates the navigation row for changing the year.
  Widget _navigationRow(StateSetter setState) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              _pickerYear = _pickerYear -= 1;
            });
          },
          icon: Icon(Icons.navigate_before_rounded, color: primaryColor),
        ),
        Expanded(
          child: Center(
            child: Text(
              _pickerYear.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              _pickerYear = _pickerYear += 1;
            });
          },
          icon: Icon(Icons.navigate_next_rounded, color: primaryColor),
        ),
      ],
    );
  }
}
