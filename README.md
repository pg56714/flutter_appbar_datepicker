# flutter_appbar_datepicker

A new Flutter package includes a day picker, week picker, and month picker.

<!-- ![main](/assets/main.png) -->

<img src="./assets/main.png" width=50% />

## Getting started

Include short and useful examples for package users. For longer examples, please see the `/example` folder.

### Day Picker

<!-- ![main](/assets/day.png) -->

<img src="./assets/day.png" width=50% />

```dart
DateTime daySelected = DateTime.now();
String dayFormatted = DateFormat('yyyy/MM/dd').format(DateTime.now());

Text(
  'Day：$dayFormatted',
  style: TextStyle(
    fontSize: 16.sp,
  ),
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
```

### Week Picker

<!-- ![main](/assets/week.png) -->

<img src="./assets/week.png" width=50% />

```dart
List<DateTime?> _dateRangePickerValue = [
  DateTime.now(),
  DateTime.now().add(const Duration(days: 6)),
];
String formatDate(List<DateTime?> dateRange) {
  final startDate = DateFormat('yyyy/MM/dd').format(dateRange[0]!);
  final endDate = DateFormat('yyyy/MM/dd').format(dateRange[1]!);
  return '$startDate - $endDate';
}

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
```

### Month Picker

<!-- ![main](/assets/month.png) -->

<img src="./assets/month.png" width=50% />

```dart
DateTime monthSelected = DateTime.now();
String monthFormatted = DateFormat('yyyy/MM').format(DateTime.now());

Text(
  'Month：$monthFormatted',
  style: TextStyle(
    fontSize: 16.sp,
  ),
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
        monthFormatted = DateFormat('yyyy/MM').format(newSelectedDate);
      });
    },
  ).show();
},
```
