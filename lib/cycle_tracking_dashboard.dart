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
      routes: {
        '/insights': (context) => const InsightsPage(),
        '/community': (context) => const CommunityPage(),
        '/activity': (context) => const ActivityTrackerPage(),
        '/profile': (context) => const ProfilePage(),

      },
    );
  }
}

class CycleTrackingDashboard extends StatefulWidget {
  const CycleTrackingDashboard({Key? key}) : super(key: key);

  @override
  State<CycleTrackingDashboard> createState() => _CycleTrackingDashboardState();
}

class _CycleTrackingDashboardState extends State<CycleTrackingDashboard> {
  int _selectedIndex = 0;
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
  
  // Symptoms tracking
  List<String> _selectedSymptoms = ['Cramps', 'Bloating'];
  int _painLevel = 3; // Scale of 1-5, 3 is moderate

  String _getPainLevelText() {
    switch (_painLevel) {
      case 1:
        return "Mild";
      case 2:
        return "Moderate";
      case 3:
        return "Severe";
      case 4:
        return "Very Severe";
      case 5:
        return "Extreme";
      default:
        return "Unknown";
    }
  }
  
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
          padding: const EdgeInsets.all(10),
          width: double.maxFinite,
          height: 600,
          child: Column(
            children: [
              const Text(
                "Your Cycle Prediction",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
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
  
  // Health Insights Section
  Widget _buildHealthInsightsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Health Insights",
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                "View All",
                style: TextStyle(
                  color: Colors.pink, 
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildInsightCard(
            icon: Icons.science_outlined,
            iconBackground: Colors.pink.shade50,
            iconColor: Colors.pink,
            title: "Iron Levels",
            description: "Your period starts soon. Consider increasing iron-rich foods to prevent fatigue.",
            time: "2 hours ago",
            actionText: "View Tips",
            actionColor: Colors.pink,
          ),
          const SizedBox(height: 10),
          _buildInsightCard(
            icon: Icons.nightlight_round,
            iconBackground: Colors.purple.shade50,
            iconColor: Colors.purple,
            title: "Sleep Pattern",
            description: "Your sleep quality may decrease during PMS. Try these relaxation techniques.",
            time: "Yesterday",
            actionText: "Learn More",
            actionColor: Colors.pink,
          ),
        ],
      ),
    );
  }
  Widget _buildSymptomCheckerSection() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Symptom Checker",
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              "See All",
              style: TextStyle(
                color: Colors.pink, 
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 24),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Up to 70% of people with polycystic ovary syndrome (PCOS) don’t know for sure that they have it",
                      style: const TextStyle(
                        fontSize: 16, 
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                "Hormonal imbalances can sometimes point to reproductive health conditions like PCOS. Check which symptoms need your attention in 5 minutes, not 2 years — the time it can take to get a diagnosis.",
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.assignment_outlined, color: Colors.teal),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "PCOS self-assessment",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Typically 5 min",
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    // Handle the button press
                  },
                  child: const Text(
                    "Check your symptoms",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
  // Community Section
 Widget _buildCommunitySection() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Community",
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              "Join Now",
              style: TextStyle(
                color: Colors.pink, 
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Connect with others",
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Join supportive communities for PCOS, pregnancy, and more.",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Transform.translate(
                    offset: const Offset(0, 0),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.teal,
                      child: const Icon(Icons.person, color: Colors.white, size: 18),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(-12, 0),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.orange,
                      child: const Icon(Icons.person, color: Colors.white, size: 18),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(-24, 0),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.blue,
                      child: const Icon(Icons.person, color: Colors.white, size: 18),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(-36, 0),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Colors.pink,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          "+426",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}

// Adjusted Today's Symptoms Section
Widget _buildSymptomChip(String symptom) {
  return Chip(
    label: Text(symptom),
    deleteIcon: const Icon(Icons.close, size: 18),
    onDeleted: () {
      setState(() {
        _selectedSymptoms.remove(symptom);
      });
    },
    backgroundColor: Colors.pink.shade50,
    deleteIconColor: Colors.pink,
    labelStyle: const TextStyle(color: Colors.pink),
  );
}

Widget _buildAddSymptomChip() {
  return ActionChip(
    avatar: const Icon(Icons.add, size: 18),
    label: const Text('Add Symptom'),
    backgroundColor: Colors.grey.shade200,
    onPressed: () {
      _showAddSymptomDialog();
      // Handle adding new symptom
      // You can show a dialog or navigate to symptom selection screen
    },
  );
}
void _showAddSymptomDialog() {
  List<String> commonSymptoms = [
    'Headache',
    'Backache',
    'Fatigue',
    'Mood Swings',
    'Breast Tenderness',
    'Acne',
    'Nausea',
    'Food Cravings',
    'Insomnia',
    'Dizziness'
  ];
   commonSymptoms = commonSymptoms.where((s) => !_selectedSymptoms.contains(s)).toList();
    showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Add Symptom"),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView(
          shrinkWrap: true,
          children: [
            ...commonSymptoms.map((symptom) => ListTile(
              title: Text(symptom),
              onTap: () {
                setState(() {
                  _selectedSymptoms.add(symptom);
                });
                Navigator.pop(context);
              },
            )),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text("Custom symptom"),
              onTap: () => _showCustomSymptomDialog(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
      ],
    ),
  );
}
void _showCustomSymptomDialog() {
  final TextEditingController controller = TextEditingController();
  
  Navigator.pop(context); // Close the previous dialog
  
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Add Custom Symptom"),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: "Enter symptom name",
        ),
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            if (controller.text.isNotEmpty) {
              setState(() {
                _selectedSymptoms.add(controller.text.trim());
              });
            }
            Navigator.pop(context);
          },
          child: const Text("Add"),
        ),
      ],
    ),
  );
}
Widget _buildSymptomsSection() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Today's Symptoms",
          style: TextStyle(
            fontSize: 18, 
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 25),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8.0, // Adjust spacing to avoid overflow
                runSpacing: 8.0,
                children: [
                  ..._selectedSymptoms.map((symptom) => _buildSymptomChip(symptom)),
                  _buildAddSymptomChip(),
                ],
              ),
              const SizedBox(height: 20), // Adjusted space
              Row(
                children: [
                  const Text(
                    "Pain level",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Row(
                    children: List.generate(
                      5, 
                      (index) => Container(
                        width: 10,
                        height: 10,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: index < _painLevel ? Colors.redAccent : Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    _getPainLevelText(),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Adjusted padding
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Log",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
  
  
  Widget _buildInsightCard({
    required IconData icon,
    required Color iconBackground,
    required Color iconColor,
    required String title,
    required String description,
    required String time,
    required String actionText,
    required Color actionColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconBackground,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                time,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
              const Spacer(),
              Text(
                actionText,
                style: TextStyle(
                  color: actionColor, 
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          )
        ],
      ),
    );
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                // App header with avatar and calendar button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 110,
                        height: 80,
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
                
                // New sections from images
                _buildSymptomsSection(),
                _buildHealthInsightsSection(),
                _buildSymptomCheckerSection(),
                _buildCommunitySection(),
                
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
  selectedItemColor: Colors.teal,
  unselectedItemColor: Colors.grey,
  showSelectedLabels: true,
  showUnselectedLabels: true,
  type: BottomNavigationBarType.fixed,
  currentIndex: _selectedIndex, // Track which item is selected
  onTap: (index) {
    setState(() {
      _selectedIndex = index;
    });

    // Handle navigation or action when tapped
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/today'); // Example
        break;
      case 1:
        Navigator.pushNamed(context, '/insights');
        break;
      case 2:
        Navigator.pushNamed(context, '/community');
        break;
      case 3:
        Navigator.pushNamed(context, '/activity');
        break;
      case 4:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  },
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
      label: "Community", // Capital C for consistency
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.directions_run),
      label: "Activity",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      label: "Profile",
    ),
  ],
),
    );
  }
}
class InsightsPage extends StatelessWidget {
  const InsightsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Women\'s Health Insights',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 238, 187, 203),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle navigation back
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SectionHeader(title: 'PCOD & PCOS'),
              ArticleScrollView(articles: pcosPcodArticles),
              SizedBox(height: 20),
              
              SectionHeader(title: 'Endometriosis'),
              ArticleScrollView(articles: endometriosisArticles),
              SizedBox(height: 20),
              
              SectionHeader(title: 'Breast Cancer'),
              ArticleScrollView(articles: breastCancerArticles),
              SizedBox(height: 20),
              
              SectionHeader(title: 'Genetic Diseases'),
              ArticleScrollView(articles: geneticDiseasesArticles),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  
  const SectionHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 12.0, bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ArticleScrollView extends StatelessWidget {
  final List<Article> articles;
  
  const ArticleScrollView({Key? key, required this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return ArticleCard(article: articles[index]);
        },
      ),
    );
  }
}

class ArticleCard extends StatelessWidget {
  final Article article;
  
  const ArticleCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailPage(article: article),
          ),
        );
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Article image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.asset(
                article.imageUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // Article title
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                article.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// New class for article detail page
class ArticleDetailPage extends StatelessWidget {
  final Article article;

  const ArticleDetailPage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.category, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 238, 187, 203),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                article.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            
            // Title
            Text(
              article.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Content
            Text(
              article.content,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            
            // Related articles section
            const Text(
              'Related Articles',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            // Related articles list
            RelatedArticlesList(relatedArticles: article.relatedArticles),
          ],
        ),
      ),
    );
  }
}

// Widget for displaying related articles
class RelatedArticlesList extends StatelessWidget {
  final List<String> relatedArticles;

  const RelatedArticlesList({Key? key, required this.relatedArticles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: relatedArticles.length,
      itemBuilder: (context, index) {
        return RelatedArticleItem(title: relatedArticles[index]);
      },
    );
  }
}

// Widget for a single related article item
class RelatedArticleItem extends StatelessWidget {
  final String title;

  const RelatedArticleItem({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          // Find the article with this title
          Article? foundArticle = _findArticleByTitle(title);
          if (foundArticle != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticleDetailPage(article: foundArticle),
              ),
            );
          }
        },
        child: Row(
          children: [
            const Icon(Icons.article, color: Color.fromARGB(255, 238, 188, 204)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // Helper method to find an article by its title
  Article? _findArticleByTitle(String title) {
    // Check in all article lists
    for (var article in [...pcosPcodArticles, ...endometriosisArticles, ...breastCancerArticles, ...geneticDiseasesArticles]) {
      if (article.title == title) {
        return article;
      }
    }
    return null;
  }
}

class Article {
  final String id;
  final String title;
  final String imageUrl;
  final String category;
  final String content;
  final List<String> relatedArticles;

  const Article({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.category,
    required this.content,
    required this.relatedArticles,
  });
}

// PCOD & PCOS Articles
const List<Article> pcosPcodArticles = [
  Article(
    id: 'pcos1',
    title: 'Understanding PCOS: Causes & Symptoms',
    imageUrl: 'assets/images/pcos1.jpg',
    category: 'PCOS',
    content: 'PCOS (Polycystic Ovary Syndrome) is a hormonal disorder affecting women of reproductive age. Learn about its causes, common symptoms, and diagnostic criteria.',
    relatedArticles: [
      'PCOD vs PCOS: What\'s the Difference?',
      'Managing PCOS with Diet Changes',
      'PCOS & Fertility: What You Should Know',
    ],
  ),
  Article(
    id: 'pcos2',
    title: 'PCOD vs PCOS: What\'s the Difference?',
    imageUrl: 'assets/images/pcos2.jpg',
    category: 'PCOS',
    content: 'Though often used interchangeably, PCOD and PCOS are different conditions. Understand the key differences, symptom variations, and treatment approaches for each.',
    relatedArticles: [
      'Understanding PCOS: Causes & Symptoms',
      'Managing PCOS with Diet Changes',
      'PCOS & Fertility: What You Should Know',
    ],
  ),
  Article(
    id: 'pcos3',
    title: 'Managing PCOS with Diet Changes',
    imageUrl: 'assets/images/pcos3.png',
    category: 'PCOS',
    content: 'Dietary modifications play a crucial role in managing PCOS symptoms. Discover the best foods, meal plans, and nutritional strategies to help balance hormones and reduce symptoms.',
    relatedArticles: [
      'Exercise Routines for PCOS Management',
      'Natural Remedies for PCOS Symptoms',
      'Understanding PCOS: Causes & Symptoms',
    ],
  ),
  Article(
    id: 'pcos4',
    title: 'Exercise Routines for PCOS Management',
    imageUrl: 'assets/images/pcos4.jpeg',
    category: 'PCOS',
    content: 'Physical activity is essential for managing PCOS. Learn about the most effective exercise types, recommended routines, and how they help improve insulin sensitivity and hormone balance.',
    relatedArticles: [
      'Managing PCOS with Diet Changes',
      'PCOS & Mental Health: The Connection',
      'Natural Remedies for PCOS Symptoms',
    ],
  ),
  Article(
    id: 'pcos5',
    title: 'PCOS & Fertility: What You Should Know',
    imageUrl: 'assets/images/pcos5.jpg',
    category: 'PCOS',
    content: 'PCOS is a leading cause of infertility, but many women with the condition can still conceive. Understand how PCOS affects fertility and the available treatment options.',
    relatedArticles: [
      'Medications & Treatments for PCOS',
      'Understanding PCOS: Causes & Symptoms',
      'Managing PCOS with Diet Changes',
    ],
  ),
  Article(
    id: 'pcos6',
    title: 'Medications & Treatments for PCOS',
    imageUrl: 'assets/images/pcos6.jpeg',
    category: 'PCOS',
    content: 'Various medications and medical interventions can help manage PCOS symptoms. Learn about hormonal treatments, insulin-sensitizing drugs, and other therapeutic options.',
    relatedArticles: [
      'Natural Remedies for PCOS Symptoms',
      'PCOS & Fertility: What You Should Know',
      'Understanding PCOS: Causes & Symptoms',
    ],
  ),
  Article(
    id: 'pcos7',
    title: 'Natural Remedies for PCOS Symptoms',
    imageUrl: 'assets/images/pcos7.jpg',
    category: 'PCOS',
    content: 'Many women seek natural approaches to manage PCOS. Discover evidence-based supplements, lifestyle changes, and holistic practices that can complement medical treatments.',
    relatedArticles: [
      'Managing PCOS with Diet Changes',
      'Exercise Routines for PCOS Management',
      'Medications & Treatments for PCOS',
    ],
  ),
  Article(
    id: 'pcos8',
    title: 'How PCOS Affects Your Menstrual Cycle',
    imageUrl: 'assets/images/pcos8.jpg',
    category: 'PCOS',
    content: 'Irregular periods are a hallmark of PCOS. Understand the hormonal imbalances that disrupt the menstrual cycle and strategies to regulate your periods.',
    relatedArticles: [
      'Understanding PCOS: Causes & Symptoms',
      'PCOD vs PCOS: What\'s the Difference?',
      'Managing PCOS with Diet Changes',
    ],
  ),
  Article(
    id: 'pcos9',
    title: 'Managing PCOS-Related Skin Issues',
    imageUrl: 'assets/images/pcos9.jpg',
    category: 'PCOS',
    content: 'Acne, hirsutism, and skin tags are common skin concerns with PCOS. Learn about treatments, skincare routines, and procedures that can help address these symptoms.',
    relatedArticles: [
      'Natural Remedies for PCOS Symptoms',
      'Medications & Treatments for PCOS',
      'Understanding PCOS: Causes & Symptoms',
    ],
  ),
  Article(
    id: 'pcos10',
    title: 'PCOS & Mental Health: The Connection',
    imageUrl: 'assets/images/pcos10.png',
    category: 'PCOS',
    content: 'The psychological impact of PCOS is often overlooked. Explore the links between PCOS and mental health conditions, and strategies for emotional wellbeing.',
    relatedArticles: [
      'Natural Remedies for PCOS Symptoms',
      'Exercise Routines for PCOS Management',
      'Managing PCOS with Diet Changes',
    ],
  ),
];

// Endometriosis Articles
const List<Article> endometriosisArticles = [
  Article(
    id: 'endo1',
    title: 'Endometriosis: Signs & Symptoms',
    imageUrl: 'assets/images/endo1.jpg',
    category: 'Endometriosis',
    content: 'Endometriosis occurs when tissue similar to the uterine lining grows outside the uterus. Learn to recognize the common and subtle symptoms of this chronic condition.',
    relatedArticles: [
      'Diagnosing Endometriosis: What to Expect',
      'Managing Endometriosis Pain',
      'Endometriosis & Fertility: Your Options',
    ],
  ),
  Article(
    id: 'endo2',
    title: 'Diagnosing Endometriosis: What to Expect',
    imageUrl: 'assets/images/endo2.jpg',
    category: 'Endometriosis',
    content: 'The path to an endometriosis diagnosis can be complex. Understand the diagnostic procedures, imaging tests, and the gold standard laparoscopic surgery process.',
    relatedArticles: [
      'Endometriosis: Signs & Symptoms',
      'Surgical Treatments for Endometriosis',
      'Living Well with Endometriosis',
    ],
  ),
  Article(
    id: 'endo3',
    title: 'Managing Endometriosis Pain',
    imageUrl: 'assets/images/endo3.png',
    category: 'Endometriosis',
    content: 'Pain management is crucial for endometriosis patients. Discover pharmaceutical options, alternative therapies, and self-care techniques to reduce discomfort.',
    relatedArticles: [
      'Endometriosis: Signs & Symptoms',
      'Hormonal Therapies for Endometriosis',
      'Diet Changes That May Help Endometriosis',
    ],
  ),
  Article(
    id: 'endo4',
    title: 'Endometriosis & Fertility: Your Options',
    imageUrl: 'assets/images/endo4.jpeg',
    category: 'Endometriosis',
    content: 'Endometriosis can impact fertility, but pregnancy is still possible. Learn about your reproductive options, fertility treatments, and success rates.',
    relatedArticles: [
      'Surgical Treatments for Endometriosis',
      'Endometriosis: Signs & Symptoms',
      'Hormonal Therapies for Endometriosis',
    ],
  ),
  Article(
    id: 'endo5',
    title: 'Surgical Treatments for Endometriosis',
    imageUrl: 'assets/images/endo5.jpeg',
    category: 'Endometriosis',
    content: 'Surgery can provide significant relief for endometriosis symptoms. Understand the different surgical approaches, from conservative to definitive procedures.',
    relatedArticles: [
      'Diagnosing Endometriosis: What to Expect',
      'Managing Endometriosis Pain',
      'Endometriosis & Fertility: Your Options',
    ],
  ),
  Article(
    id: 'endo6',
    title: 'Hormonal Therapies for Endometriosis',
    imageUrl: 'assets/images/endo6.jpeg',
    category: 'Endometriosis',
    content: 'Hormonal treatments are a cornerstone of endometriosis management. Learn about the various options, from birth control pills to GnRH agonists, and their effects.',
    relatedArticles: [
      'Managing Endometriosis Pain',
      'Surgical Treatments for Endometriosis',
      'Living Well with Endometriosis',
    ],
  ),
  Article(
    id: 'endo7',
    title: 'Diet Changes That May Help Endometriosis',
    imageUrl: 'assets/images/endo7.png',
    category: 'Endometriosis',
    content: 'Certain dietary modifications may help reduce inflammation and ease endometriosis symptoms. Explore anti-inflammatory diets and nutritional approaches.',
    relatedArticles: [
      'Managing Endometriosis Pain',
      'Endometriosis & Exercise: What Works',
      'Living Well with Endometriosis',
    ],
  ),
  Article(
    id: 'endo8',
    title: 'Endometriosis & Exercise: What Works',
    imageUrl: 'assets/images/endo8.jpg',
    category: 'Endometriosis',
    content: 'Physical activity can both help and hinder endometriosis management. Discover the best types of exercise and how to adapt your fitness routine.',
    relatedArticles: [
      'Managing Endometriosis Pain',
      'Diet Changes That May Help Endometriosis',
      'Living Well with Endometriosis',
    ],
  ),
  Article(
    id: 'endo9',
    title: 'Living Well with Endometriosis',
    imageUrl: 'assets/images/endo9.jpg',
    category: 'Endometriosis',
    content: 'Endometriosis is a chronic condition that requires lifelong management. Learn practical strategies for living a fulfilling life while managing symptoms.',
    relatedArticles: [
      'Managing Endometriosis Pain',
      'Endometriosis Support: Finding Help',
      'Diet Changes That May Help Endometriosis',
    ],
  ),
  Article(
    id: 'endo10',
    title: 'Endometriosis Support: Finding Help',
    imageUrl: 'assets/images/endo10.jpeg',
    category: 'Endometriosis',
    content: 'Support is essential when dealing with endometriosis. Discover resources, support groups, and how to build a reliable healthcare team.',
    relatedArticles: [
      'Living Well with Endometriosis',
      'Managing Endometriosis Pain',
      'Endometriosis: Signs & Symptoms',
    ],
  ),
];

// Breast Cancer Articles
const List<Article> breastCancerArticles = [
  Article(
    id: 'bc1',
    title: 'Breast Cancer Warning Signs',
    imageUrl: 'assets/images/bc1.png',
    category: 'Breast Cancer',
    content: 'Early detection of breast cancer significantly improves outcomes. Learn the warning signs beyond lumps, including skin changes, nipple discharge, and other symptoms to watch for.',
    relatedArticles: [
      'How to Perform a Breast Self-Exam',
      'Understanding Mammograms',
      'Breast Cancer Risk Factors',
    ],
  ),
  Article(
    id: 'bc2',
    title: 'How to Perform a Breast Self-Exam',
    imageUrl: 'assets/images/bc2.png',
    category: 'Breast Cancer',
    content: 'Regular self-examination helps you become familiar with your breasts and notice changes. Learn the proper technique and frequency for effective self-exams.',
    relatedArticles: [
      'Breast Cancer Warning Signs',
      'Understanding Mammograms',
      'Breast Cancer Risk Factors',
    ],
  ),
  Article(
    id: 'bc3',
    title: 'Understanding Mammograms',
    imageUrl: 'assets/images/bc3.jpg',
    category: 'Breast Cancer',
    content: 'Mammography is a crucial screening tool for breast cancer. Learn about when to start, how often to get screened, what to expect during the procedure, and how to interpret results.',
    relatedArticles: [
      'Breast Cancer Warning Signs',
      'How to Perform a Breast Self-Exam',
      'Genetic Testing for Breast Cancer',
    ],
  ),
  Article(
    id: 'bc4',
    title: 'Breast Cancer Risk Factors',
    imageUrl: 'assets/images/bc4.jpeg',
    category: 'Breast Cancer',
    content: 'Understanding your personal risk factors is important for prevention and early detection. Learn about genetic, hormonal, lifestyle, and environmental risk factors for breast cancer.',
    relatedArticles: [
      'Genetic Testing for Breast Cancer',
      'Breast Cancer Warning Signs',
      'How to Perform a Breast Self-Exam',
    ],
  ),
  Article(
    id: 'bc5',
    title: 'Treatment Options for Breast Cancer',
    imageUrl: 'assets/images/bc5.jpeg',
    category: 'Breast Cancer',
    content: 'Breast cancer treatment is highly individualized. Explore the various approaches including surgery, radiation, chemotherapy, hormonal therapy, and targeted treatments.',
    relatedArticles: [
      'Breast Cancer Warning Signs',
      'Life After Breast Cancer Treatment',
      'Nutrition During Breast Cancer Treatment',
    ],
  ),
  Article(
    id: 'bc6',
    title: 'Life After Breast Cancer Treatment',
    imageUrl: 'assets/images/bc6.png',
    category: 'Breast Cancer',
    content: 'Transitioning to life after treatment presents unique challenges. Learn about follow-up care, managing long-term side effects, emotional well-being, and recurrence concerns.',
    relatedArticles: [
      'Treatment Options for Breast Cancer',
      'Supporting Someone with Breast Cancer',
      'Nutrition During Breast Cancer Treatment',
    ],
  ),
  Article(
    id: 'bc7',
    title: 'Genetic Testing for Breast Cancer',
    imageUrl: 'assets/images/bc7.jpeg',
    category: 'Breast Cancer',
    content: 'Genetic mutations like BRCA1 and BRCA2 can significantly increase breast cancer risk. Learn about testing options, who should consider testing, and risk management strategies.',
    relatedArticles: [
      'Breast Cancer Risk Factors',
      'Treatment Options for Breast Cancer',
      'Innovations in Breast Cancer Research',
    ],
  ),
  Article(
    id: 'bc8',
    title: 'Nutrition During Breast Cancer Treatment',
    imageUrl: 'assets/images/bc8.jpeg',
    category: 'Breast Cancer',
    content: 'Proper nutrition can help manage treatment side effects and support recovery. Discover dietary recommendations during different phases of breast cancer treatment.',
    relatedArticles: [
      'Treatment Options for Breast Cancer',
      'Life After Breast Cancer Treatment',
      'Supporting Someone with Breast Cancer',
    ],
  ),
  Article(
    id: 'bc9',
    title: 'Supporting Someone with Breast Cancer',
    imageUrl: 'assets/images/bc9.jpeg',
    category: 'Breast Cancer',
    content: 'Knowing how to support a loved one with breast cancer can make a significant difference. Learn helpful approaches, what to say (and not say), and practical ways to help.',
    relatedArticles: [
      'Life After Breast Cancer Treatment',
      'Treatment Options for Breast Cancer',
      'Breast Cancer Warning Signs',
    ],
  ),
  Article(
    id: 'bc10',
    title: 'Innovations in Breast Cancer Research',
    imageUrl: 'assets/images/bc10.jpeg',
    category: 'Breast Cancer',
    content: 'Breast cancer research continues to advance treatment options and outcomes. Explore recent breakthroughs in detection, treatment approaches, and promising clinical trials.',
    relatedArticles: [
      'Treatment Options for Breast Cancer',
      'Genetic Testing for Breast Cancer',
      'Life After Breast Cancer Treatment',
    ],
  ),
];

// Genetic Diseases Articles
const List<Article> geneticDiseasesArticles = [
  Article(
    id: 'gen1',
    title: 'Understanding Genetic Disorders',
    imageUrl: 'assets/images/gen1.jpg',
    category: 'Genetic',
    content: 'Genetic disorders result from changes in DNA that affect health and development. Learn about the different types, inheritance patterns, and how they\'re diagnosed.',
    relatedArticles: [
      'Common Genetic Disorders in Women',
      'Genetic Testing: What to Know',
      'Family Planning with Genetic Risks',
    ],
  ),
  Article(
    id: 'gen2',
    title: 'Common Genetic Disorders in Women',
    imageUrl: 'assets/images/gen2.png',
    category: 'Genetic',
    content: 'Certain genetic conditions affect women differently or more frequently. Explore conditions like Turner syndrome, fragile X, and hereditary breast and ovarian cancer syndromes.',
    relatedArticles: [
      'Understanding Genetic Disorders',
      'Hereditary Breast & Ovarian Cancer',
      'Understanding BRCA Gene Mutations',
    ],
  ),
  Article(
    id: 'gen3',
    title: 'Genetic Testing: What to Know',
    imageUrl: 'assets/images/gen3.jpeg',
    category: 'Genetic',
    content: 'Genetic testing can provide valuable health information. Learn about the types of tests available, when they\'re recommended, and how to understand results.',
    relatedArticles: [
      'Genetic Counseling: Benefits & Process',
      'Understanding BRCA Gene Mutations',
      'Family Planning with Genetic Risks',
    ],
  ),
  Article(
    id: 'gen4',
    title: 'Family Planning with Genetic Risks',
    imageUrl: 'assets/images/gen4.jpeg',
    category: 'Genetic',
    content: 'Couples with genetic concerns have several reproductive options. Explore preconception testing, prenatal diagnosis, assisted reproductive technologies, and adoption.',
    relatedArticles: [
      'Genetic Testing: What to Know',
      'Genetic Counseling: Benefits & Process',
      'Understanding Genetic Disorders',
    ],
  ),
  Article(
    id: 'gen5',
    title: 'Hereditary Breast & Ovarian Cancer',
    imageUrl: 'assets/images/gen5.png',
    category: 'Genetic',
    content: 'Hereditary breast and ovarian cancer syndromes significantly increase cancer risk. Learn about risk assessment, surveillance recommendations, and risk-reducing strategies.',
    relatedArticles: [
      'Understanding BRCA Gene Mutations',
      'Common Genetic Disorders in Women',
      'Genetic Testing: What to Know',
    ],
  ),
  Article(
    id: 'gen6',
    title: 'Understanding BRCA Gene Mutations',
    imageUrl: 'assets/images/gen6.png',
    category: 'Genetic',
    content: 'BRCA1 and BRCA2 mutations are linked to increased cancer risks. Learn how these genes function, associated cancer risks, testing criteria, and management options.',
    relatedArticles: [
      'Hereditary Breast & Ovarian Cancer',
      'Genetic Testing: What to Know',
      'Family Planning with Genetic Risks',
    ],
  ),
  Article(
    id: 'gen7',
    title: 'Genetic Counseling: Benefits & Process',
    imageUrl: 'assets/images/gen7.jpg',
    category: 'Genetic',
    content: 'Genetic counseling helps individuals understand and adapt to genetic contributions to disease. Learn what happens during consultations and how to prepare.',
    relatedArticles: [
      'Genetic Testing: What to Know',
      'Family Planning with Genetic Risks',
      'Understanding Genetic Disorders',
    ],
  ),
  Article(
    id: 'gen8',
    title: 'Turner Syndrome: Causes & Management',
    imageUrl: 'assets/images/gen8.png',
    category: 'Genetic',
    content: 'Turner syndrome affects females who are missing all or part of an X chromosome. Learn about its features, associated health concerns, and treatment approaches.',
    relatedArticles: [
      'Common Genetic Disorders in Women',
      'Understanding Genetic Disorders',
      'Living with Genetic Conditions',
    ],
  ),
  Article(
    id: 'gen9',
    title: 'Fragile X Syndrome in Women',
    imageUrl: 'assets/images/gen9.jpeg',
    category: 'Genetic',
    content: 'Women can be carriers or affected by Fragile X syndrome. Understand how this condition manifests differently in females, associated health issues, and management strategies.',
    relatedArticles: [
      'Common Genetic Disorders in Women',
      'Understanding Genetic Disorders',
      'Living with Genetic Conditions',
    ],
  ),
  Article(
    id: 'gen10',
    title: 'Living with Genetic Conditions',
    imageUrl: 'assets/images/gen10.jpg',
    category: 'Genetic',
    content: 'Adapting to life with a genetic condition requires support and resources. Discover strategies for managing daily challenges, finding community, and maintaining quality of life.',
    relatedArticles: [
      'Understanding Genetic Disorders',
      'Turner Syndrome: Causes & Management',
      'Fragile X Syndrome in Women',
    ],
  ),
];
class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/profile.jpeg'), // Your Profile pic
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Hi, Susena!', style: TextStyle(color: Colors.black, fontSize: 16)),
            const SizedBox(height: 2),
            Text('120 Wellness Points',
                style: TextStyle(color: Colors.teal, fontSize: 12)),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Community', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('+ New Post', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Posts
              _buildPost(
                context,
                userName: 'Emma Wilson',
                timeAgo: '2h ago',
                content:
                    "Just completed my morning yoga session! It's amazing how much better I feel. Anyone else here practice morning yoga? 🧘‍♀️\n#WellnessJourney #MorningRoutine",
                likes: 248,
                comments: 42,
                replyUser: 'Sarah Chen',
                replyText: 'Yes! Morning yoga is the best way to start the day! 🙌',
              ),
              _buildPost(
                context,
                userName: 'Maya Johnson',
                timeAgo: '5h ago',
                content:
                    "Looking for accountability partners for my fitness journey! Anyone interested in joining me? 💪 #FitnessGoals #WomenSupport",
                likes: 156,
                comments: 28,
              ),
              _buildPost(
                context,
                userName: 'Lisa Parker',
                timeAgo: 'Yesterday',
                content: "Sharing my favorite healthy breakfast recipe! 🥣",
                likes: 324,
                comments: 56,
                imageUrl: 'assets/images/healthy_breakfast.jpg', // Example image
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPost(
    BuildContext context, {
    required String userName,
    required String timeAgo,
    required String content,
    int likes = 0,
    int comments = 0,
    String? replyUser,
    String? replyText,
    String? imageUrl,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info Row
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/profile1.png'), // Dummy user pic
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userName, style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(timeAgo, style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                const Spacer(),
                Icon(Icons.more_horiz),
              ],
            ),
            const SizedBox(height: 12),
            // Content
            Text(content),
            if (imageUrl != null) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(imageUrl),
              ),
            ],
            const SizedBox(height: 12),
            // Like and Comment Row
            Row(
              children: [
                Icon(Icons.favorite_border, color: Colors.grey),
                const SizedBox(width: 6),
                Text(likes.toString()),
                const SizedBox(width: 20),
                Icon(Icons.chat_bubble_outline, color: Colors.grey),
                const SizedBox(width: 6),
                Text(comments.toString()),
                const Spacer(),
                Icon(Icons.bookmark_border, color: Colors.grey),
              ],
            ),
            if (replyUser != null && replyText != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: AssetImage('assets/images/profile2.png'), // Dummy reply user
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            replyUser,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          Text(replyText),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
class ActivityTrackerPage extends StatelessWidget {
  const ActivityTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        backgroundColor: Colors.pink.shade50,
        elevation: 0,
        title: const Text(
          'Activity Tracker',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'This Week',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDailyGoalCard(),
            const SizedBox(height: 20),
            _buildWeeklyProgressCard(),
            const SizedBox(height: 20),
            _buildRecentActivitiesCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyGoalCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Daily Goal',
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  RichText(
                    text: const TextSpan(
                      text: '7,890',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.black),
                      children: [
                        TextSpan(
                          text: ' / 10,000 steps',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildGoalStat(Icons.directions_walk, 'Steps', '7,890'),
                      _buildGoalStat(Icons.nights_stay, 'Sleep', '7h 20m'),
                      _buildGoalStat(Icons.local_fire_department, 'Calories', '1,842'),
                      _buildGoalStat(Icons.favorite, 'Heart Rate', '72 BPM'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Circle Progress
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        value: 0.79,
                        strokeWidth: 6,
                        backgroundColor: Colors.grey.shade200,
                        color: Colors.red,
                      ),
                    ),
                    const Text('79%', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalStat(IconData icon, String label, String value) {
    return Column(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: Colors.pink.shade50,
          child: Icon(icon, size: 18, color: Colors.purple),
        ),
        const SizedBox(height: 6),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey)),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
      ],
    );
  }

  Widget _buildWeeklyProgressCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Weekly Progress',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text('Mon', style: TextStyle(color: Colors.grey)),
                Text('Tue', style: TextStyle(color: Colors.grey)),
                Text('Wed', style: TextStyle(color: Colors.grey)),
                Text('Thu', style: TextStyle(color: Colors.grey)),
                Text('Fri', style: TextStyle(color: Colors.grey)),
                Text('Sat', style: TextStyle(color: Colors.grey)),
                Text('Sun', style: TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 20),
            // You can add a simple progress bar or graph here later
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivitiesCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Recent Activities',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildActivityItem(Icons.directions_walk, 'Morning Walk',
                '07:30 AM - 08:15 AM', '3,240 steps'),
            const Divider(),
            _buildActivityItem(Icons.nights_stay, 'Sleep Duration',
                '10:30 PM - 05:50 AM', '7h 20m'),
            const Divider(),
            _buildActivityItem(Icons.favorite, 'Heart Rate',
                'Last checked 1h ago', '72 BPM'),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(
      IconData icon, String title, String subtitle, String trailing) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: Colors.pink.shade50,
        child: Icon(icon, color: Colors.purple),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: Text(trailing, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.jpeg'), // Add your asset
              radius: 16,
            ),
            const SizedBox(width: 8),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, Susena!',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                Text(
                  '120 Wellness Points',
                  style: TextStyle(fontSize: 10, color: Colors.pink),
                ),
              ],
            ),
          ],
        ),
        actions: const [
          Icon(Icons.notifications_none, color: Colors.black),
          SizedBox(width: 16),
          Icon(Icons.favorite_border, color: Colors.black),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/profile.jpeg'), // Add your asset
                ),
                Positioned(
                  bottom: 0,
                  child: CircleAvatar(
                    backgroundColor: Colors.pink,
                    radius: 16,
                    child: Icon(Icons.camera_alt, size: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Susena Reddy',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              '@SusenaReddy',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 4),
            const Text(
              '120 Wellness Points',
              style: TextStyle(color: Colors.pink),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                ProfileStat(label: 'Posts', count: '28'),
                ProfileStat(label: 'Following', count: '486'),
                ProfileStat(label: 'Followers', count: '942'),
              ],
            ),
            const SizedBox(height: 16),
            const ProfileOption(icon: Icons.edit, label: 'Edit Profile'),
            const ProfileOption(icon: Icons.notifications_none, label: 'Notifications'),
            const ProfileOption(icon: Icons.lock_outline, label: 'Privacy Settings'),
            const ProfileOption(icon: Icons.help_outline, label: 'Help & Support'),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout),
                label: const Text('Log Out'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class ProfileStat extends StatelessWidget {
  final String label;
  final String count;
  const ProfileStat({super.key, required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String label;
  const ProfileOption({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.pink),
        title: Text(label),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}