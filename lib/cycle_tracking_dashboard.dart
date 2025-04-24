import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Period Tracker',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const CycleTrackingDashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CycleTrackingDashboard extends StatefulWidget {
  const CycleTrackingDashboard({Key? key}) : super(key: key);

  @override
  State<CycleTrackingDashboard> createState() => _CycleTrackingDashboardState();
}

class _CycleTrackingDashboardState extends State<CycleTrackingDashboard> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  
  // Cycle configuration
  DateTime _lastPeriodDate = DateTime.now().subtract(const Duration(days: 5));
  int _cycleLength = 28;
  int _periodLength = 5;
  
  // Calculated phases
  Map<DateTime, String> _cycleDays = {};
  
  // List of PMS quotes
  final List<String> _pmsQuotes = [
    "Take a deep breath. This too shall pass.",
    "Be gentle with yourself today.",
    "You're stronger than your hormones.",
    "It's okay to rest when you need it.",
    "Treat yourself with extra kindness today.",
    "Listen to what your body needs right now.",
    "Your feelings are valid, even if they're intense.",
    "Stay hydrated and take care of yourself.",
  ];
  
  @override
  void initState() {
    super.initState();
    _calculateCycleDays();
  }
  
  void _calculateCycleDays() {
    _cycleDays = {};
    
    // Calculate for next 12 months
    final DateTime startDate = _lastPeriodDate.subtract(Duration(days: _cycleLength * 2));
    final DateTime endDate = _lastPeriodDate.add(Duration(days: _cycleLength * 12));
    
    for (DateTime date = startDate; date.isBefore(endDate); date = date.add(const Duration(days: 1))) {
      // Calculate days since last period and then determine which cycle day it is
      int totalDayDifference = date.difference(_lastPeriodDate).inDays;
      int cycleDayPosition = totalDayDifference % _cycleLength;
      
      // Fix for negative days (dates before last period)
      if (cycleDayPosition < 0) {
        cycleDayPosition = _cycleLength + cycleDayPosition;
      }
      
      if (cycleDayPosition >= 0 && cycleDayPosition < _periodLength) {
        // Period days - correctly display all period days
        _cycleDays[DateTime(date.year, date.month, date.day)] = 'period';
      } else if (cycleDayPosition >= _cycleLength - 14 - 2 && cycleDayPosition <= _cycleLength - 14 + 2) {
        // Ovulation window (typically around 14 days before next period, +/- 2 days)
        _cycleDays[DateTime(date.year, date.month, date.day)] = 'ovulation';
      } else if (cycleDayPosition >= _cycleLength - 7 && cycleDayPosition < _cycleLength) {
        // PMS days (7 days before next period)
        _cycleDays[DateTime(date.year, date.month, date.day)] = 'pms';
      } else if (cycleDayPosition >= _cycleLength - 14 - 3 && cycleDayPosition <= _cycleLength - 14 + 3) {
        // Fertile window (typically around ovulation, +/- 3 days)
        _cycleDays[DateTime(date.year, date.month, date.day)] = 'fertile';
      } else {
        _cycleDays[DateTime(date.year, date.month, date.day)] = 'regular';
      }
    }
  }
  
  Color _getPhaseColor(DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    final phase = _cycleDays[normalizedDate] ?? 'regular';
    
    switch (phase) {
      case 'period':
        return Colors.pink;
      case 'ovulation':
        return Colors.purple;
      case 'pms':
        return Colors.orange;
      case 'fertile':
        return Colors.purple.shade200;
      default:
        return Colors.grey.shade200;
    }
  }
  
  void _showEditPeriodDialog() {
    DateTime tempLastPeriodDate = _lastPeriodDate;
    int tempCycleLength = _cycleLength;
    int tempPeriodLength = _periodLength;
    
    // Lists for dropdown options
    final List<int> cycleLengthOptions = List.generate(15, (i) => i + 21); // 21-35 days
    final List<int> periodLengthOptions = List.generate(9, (i) => i + 2);  // 2-10 days
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Period Settings"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("Last Period Start Date"),
              subtitle: Text(DateFormat('yyyy-MM-dd').format(tempLastPeriodDate)),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: tempLastPeriodDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  setState(() {
                    tempLastPeriodDate = picked;
                  });
                }
              },
            ),
            ListTile(
              title: const Text("Cycle Length"),
              subtitle: DropdownButton<int>(
                value: tempCycleLength,
                onChanged: (int? value) {
                  if (value != null) {
                    setState(() {
                      tempCycleLength = value;
                    });
                  }
                },
                items: cycleLengthOptions.map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text('$value days'),
                  );
                }).toList(),
              ),
            ),
            ListTile(
              title: const Text("Period Length"),
              subtitle: DropdownButton<int>(
                value: tempPeriodLength,
                onChanged: (int? value) {
                  if (value != null) {
                    setState(() {
                      tempPeriodLength = value;
                    });
                  }
                },
                items: periodLengthOptions.map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text('$value days'),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _lastPeriodDate = tempLastPeriodDate;
                _cycleLength = tempCycleLength;
                _periodLength = tempPeriodLength;
                _calculateCycleDays();
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _showYearlyCalendarView() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: const EdgeInsets.all(16),
          width: double.maxFinite,
          height: 500,
          child: Column(
            children: [
              const Text(
                "Your Cycle Prediction",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: TableCalendar(
                  firstDay: DateTime.now().subtract(const Duration(days: 365)),
                  lastDay: DateTime.now().add(const Duration(days: 365)),
                  focusedDay: _focusedDay,
                  calendarFormat: CalendarFormat.month,
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month',
                    CalendarFormat.twoWeeks: '2 weeks',
                  },
                  selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                    Navigator.pop(context);
                  },
                  calendarStyle: CalendarStyle(
                    markersMaxCount: 1,
                    markerDecoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                  ),
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, date, events) {
                      return Container(
                        margin: const EdgeInsets.all(4),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _getPhaseColor(date),
                        ),
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(
                            color: _getPhaseColor(date) == Colors.grey.shade200 ? Colors.black : Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildLegendItem("Period", Colors.pink),
                  _buildLegendItem("Ovulation", Colors.purple),
                  _buildLegendItem("PMS", Colors.orange),
                  _buildLegendItem("Fertile", Colors.purple.shade200),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  // Helper method to get phase display information
  Map<String, dynamic> _getPhaseSummary(DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    final phase = _cycleDays[normalizedDate] ?? 'regular';
    
    switch (phase) {
      case 'period':
        // Calculate which day of period it is (1st, 2nd, etc.)
        int totalDayDifference = normalizedDate.difference(_lastPeriodDate).inDays;
        int cycleDayPosition = totalDayDifference % _cycleLength;
        if (cycleDayPosition < 0) {
          cycleDayPosition = _cycleLength + cycleDayPosition;
        }
        
        int periodDay = cycleDayPosition + 1;
        String ordinal;
        if (periodDay == 1) {
          ordinal = "1st";
        } else if (periodDay == 2) {
          ordinal = "2nd";
        } else if (periodDay == 3) {
          ordinal = "3rd";
        } else {
          ordinal = "${periodDay}th";
        }
        
        return {
          'title': 'Period',
          'subtitle': '$ordinal day',
          'color': Colors.pink,
          'icon': Icons.water_drop,
        };
      case 'ovulation':
        return {
          'title': 'Ovulation',
          'subtitle': 'you are ovulating',
          'color': Colors.purple,
          'icon': Icons.egg_alt,
        };
      case 'pms':
        // Get a random PMS quote
        final quoteIndex = DateTime.now().millisecond % _pmsQuotes.length;
        return {
          'title': 'PMS',
          'subtitle': _pmsQuotes[quoteIndex],
          'color': Colors.orange,
          'icon': Icons.mood,
        };
      case 'fertile':
        return {
          'title': 'Fertile',
          'subtitle': 'High chance',
          'color': Colors.purple.shade200,
          'icon': Icons.favorite,
          
        };
      default:
        // Calculate cycle day
        int totalDayDifference = normalizedDate.difference(_lastPeriodDate).inDays;
        int cycleDayPosition = totalDayDifference % _cycleLength;
        if (cycleDayPosition < 0) {
          cycleDayPosition = _cycleLength + cycleDayPosition;
        }
        
        return {
          'title': 'Regular',
          'subtitle': 'Day ${cycleDayPosition + 1}',
          'color': Colors.teal,
          'icon': Icons.calendar_today,
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> phaseSummary = _getPhaseSummary(_selectedDay);
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFC0CB), Color(0xFFFFE0E5), Colors.white],
          ),
        ),
        child: SafeArea(
          
          child: Column(
            children: [
              
              // App header with avatar and calendar button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.purple.shade300,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(Icons.pets, color: Colors.white),
                      ),
                    ),
                    Text(
                      "${DateFormat('d').format(_selectedDay)} ${DateFormat('MMMM').format(_selectedDay)}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_month),
                      onPressed: _showYearlyCalendarView,
                    ),
                  ],
                ),
              ),
              
              // Scrollable calendar
              TableCalendar(
                firstDay: DateTime.now().subtract(const Duration(days: 365)),
                lastDay: DateTime.now().add(const Duration(days: 365)),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                availableCalendarFormats: const {
                  CalendarFormat.week: 'Week',
                  CalendarFormat.twoWeeks: '2 Weeks',
                },
                selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                headerVisible: false,
                daysOfWeekHeight: 20,
                rowHeight: 60,
                calendarStyle: CalendarStyle(
                  markersMaxCount: 1,
                  markerDecoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  todayDecoration: BoxDecoration(
                    color: _getPhaseColor(_selectedDay),
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: _getPhaseColor(_selectedDay),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.pink, width: 2),
                  ),
                ),
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, date, events) {
                    return Container(
                      margin: const EdgeInsets.all(4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _getPhaseColor(date),
                      ),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(
                          color: _getPhaseColor(date) == Colors.grey.shade200 ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Period phase indicator
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(phaseSummary['icon'], color: phaseSummary['color']),
                        const SizedBox(width: 8),
                        Text(
                          "${phaseSummary['title']}:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: phaseSummary['color'],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      phaseSummary['subtitle'],
                      style: TextStyle(
                        fontSize: phaseSummary['title'] == 'PMS' ? 20 : 40,
                        fontWeight: FontWeight.bold,
                        color: phaseSummary['color'],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              
              // Edit period dates button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: _showEditPeriodDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.pink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text(
                    "Edit period dates",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              
              const Spacer(), // This will push the content up and fill the empty space
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Today",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: "Insights",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: "Secret Chats",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            label: "Messages",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: "Partner",
          ),
        ],
      ),
    );
  }
}
