import 'package:flutter_appbar_datepicker/day_picker.dart';
import 'package:flutter_appbar_datepicker/month_picker.dart';
import 'package:flutter_appbar_datepicker/week_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'appbar_datepicker_ui',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          home: const MyHomePage(
            title: 'appbar_datepicker_ui',
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // day
  DateTime daySelected = DateTime.now();
  String dayFormatted = DateFormat('yyyy/MM/dd').format(DateTime.now());

  // week
  List<DateTime?> _dateRangePickerValue = [
    DateTime.now(),
    DateTime.now().add(const Duration(days: 6)),
  ];

  String formatDate(List<DateTime?> dateRange) {
    final startDate = DateFormat('yyyy/MM/dd').format(dateRange[0]!);
    final endDate = DateFormat('yyyy/MM/dd').format(dateRange[1]!);
    return '$startDate - $endDate';
  }

  // month
  DateTime monthSelected = DateTime.now();
  String monthFormatted = DateFormat('yyyy/MM').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Day：$dayFormatted',
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      size: 24.sp,
                    ),
                    onPressed: () async {
                      CustomDayPickerDialog(
                        context: context,
                        primaryColor: Colors.black,
                        secondaryColor: Colors.white,
                        initialDate: daySelected,
                        onConfirm: (DateTime newSelectedDate) {
                          setState(() {
                            daySelected = newSelectedDate;
                            dayFormatted = DateFormat('yyyy/MM/dd')
                                .format(newSelectedDate);
                          });
                        },
                      ).show();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Week：${formatDate(_dateRangePickerValue)}',
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      size: 24.sp,
                    ),
                    onPressed: () async {
                      CustomWeekPickerDialog(
                        context: context,
                        primaryColor: Colors.black,
                        secondaryColor: Colors.white,
                        startDate: _dateRangePickerValue[0]!,
                        endDate: _dateRangePickerValue[1]!,
                        onConfirm: (DateTime startDate, DateTime endDate) {
                          setState(() {
                            _dateRangePickerValue = [
                              startDate,
                              endDate,
                            ];
                          });
                        },
                      ).show();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Month：$monthFormatted',
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      size: 24.sp,
                    ),
                    onPressed: () async {
                      CustomMonthPickerDialog(
                        context: context,
                        primaryColor: Colors.black,
                        secondaryColor: Colors.white,
                        initialDate: monthSelected,
                        onConfirm: (DateTime newSelectedDate) {
                          setState(() {
                            monthSelected = newSelectedDate;
                            monthFormatted =
                                DateFormat('yyyy/MM').format(newSelectedDate);
                          });
                        },
                      ).show();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
