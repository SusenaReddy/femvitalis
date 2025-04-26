import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Color primaryPink = Color(0xFFDC52AE); // Pink accent color
  final Color secondaryPink = Color(0xFFFFC0CB); // Pastel pink

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BabyBump Care',
      theme: ThemeData(
        primaryColor: primaryPink,
        scaffoldBackgroundColor: Colors.white,
        cardColor: Color(0xFFFFD1DC),
        textTheme: TextTheme(
          titleLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(color: Colors.black87),
        ),
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

enum SelectedCard { today, bump, tools }

class Appointment {
  final String title;
  final String hospital;
  final String doctor;
  final DateTime date;
  final TimeOfDay time;
  final String notes;
  final bool reminder;

  Appointment({
    required this.title,
    required this.hospital,
    required this.doctor,
    required this.date,
    required this.time,
    required this.notes,
    required this.reminder,
  });
}

class _HomeScreenState extends State<HomeScreen> {
  SelectedCard selectedCard = SelectedCard.tools;
  DateTime _selectedDay = DateTime.now();
  List<Appointment> appointments = [];
  int _selectedIndex = 2; // Default to Tools tab
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  int selectedToolIndex = 0;

  List<Map<String, dynamic>> pregnancyData = [
  {
    'week': '<1',
    'bumpSize': 'Not visible',
    'fact': 'Fertilization just occurred. No physical bump yet.',
    'babyLength': '0 cm',
    'image': 'assets/images/bump/week_0.jpg',
  },
  {
    'week': '1',
    'bumpSize': 'Not visible',
    'fact': 'Implantation may be happening, but there’s no bump at all.',
    'babyLength': '0.1 cm',
    'image': 'assets/images/bump/week_1.jpg',
  },
  {
    'week': '2',
    'bumpSize': 'Not visible',
    'fact': 'Your body is preparing, but there’s no visible bump.',
    'babyLength': '0.2 cm',
    'image': 'assets/images/bump/week_2.jpg',
  },
  {
    'week': '3',
    'bumpSize': 'Not visible',
    'fact': 'Still no bump. Hormonal changes might begin.',
    'babyLength': '0.3 cm',
    'image': 'assets/images/bump/week_3.jpg',
  },
  {
    'week': '4',
    'bumpSize': 'Not visible',
    'fact': 'You might feel bloated, but your belly hasn’t changed yet.',
    'babyLength': '0.4 cm',
    'image': 'assets/images/bump/week_4.jpg',
  },
  {
    'week': '5',
    'bumpSize': 'Barely noticeable',
    'fact': 'Some bloating or tightness may start. Uterus is expanding.',
    'babyLength': '0.9 cm',
    'image': 'assets/images/bump/week_5.jpg',
  },
  {
    'week': '6',
    'bumpSize': 'Barely noticeable',
    'fact': 'Your uterus is growing, but the bump is still tiny or hidden.',
    'babyLength': '1.6 cm',
    'image': 'assets/images/bump/week_6.jpg',
  },
  {
    'week': '7',
    'bumpSize': 'Very slight',
    'fact': 'Some moms notice a tiny pooch due to bloating and uterus expansion.',
    'babyLength': '2.5 cm',
    'image': 'assets/images/bump/week_7.jpg',
  },
  {
    'week': '8',
    'bumpSize': 'Very slight',
    'fact': 'Bump might begin to round slightly, especially for second pregnancies.',
    'babyLength': '3.1 cm',
    'image': 'assets/images/bump/week_8.jpg',
  },
  {
    'week': '9',
    'bumpSize': 'Small',
    'fact': 'Your bump may look like early weight gain or bloating.',
    'babyLength': '4.0 cm',
    'image': 'assets/images/bump/week_9.jpg',
  },
  {
    'week': '10',
    'bumpSize': 'Small',
    'fact': 'The bump is getting firmer and rounder around your lower abdomen.',
    'babyLength': '5.1 cm',
    'image': 'assets/images/bump/week_10.jpg',
  },
  {
    'week': '11',
    'bumpSize': 'Growing',
    'fact': 'Your uterus is about the size of a grapefruit. The bump becomes more visible.',
    'babyLength': '6.1 cm',
    'image': 'assets/images/bump/week_11.jpg',
  },
  {
    'week': '12',
    'bumpSize': 'Growing',
    'fact': 'You might be switching to looser clothes as your bump becomes noticeable.',
    'babyLength': '7.4 cm',
    'image': 'assets/images/bump/week_12.jpg',
  },
  {
    'week': '13',
    'bumpSize': 'Noticeable',
    'fact': 'Your bump is clearly forming and your waistline is disappearing.',
    'babyLength': '8.5 cm',
    'image': 'assets/images/bump/week_13.jpg',
  },
  {
    'week': '14',
    'bumpSize': 'Noticeable',
    'fact': 'Welcome to the second trimester! Bump is visibly rounding out.',
    'babyLength': '9.5 cm',
    'image': 'assets/images/bump/week_14.jpg',
  },
  {
    'week': '15',
    'bumpSize': 'Medium',
    'fact': 'The bump is clearly visible and steadily growing.',
    'babyLength': '10.1 cm',
    'image': 'assets/images/bump/week_15.jpg',
  },
  {
    'week': '16',
    'bumpSize': 'Medium',
    'fact': 'The bump is clearly visible and steadily growing.',
    'babyLength': '11.6 cm',
    'image': 'assets/images/bump/week_16.jpg',
  },
  {
    'week': '17',
    'bumpSize': 'Medium',
    'fact': 'The bump is clearly visible and steadily growing.',
    'babyLength': '13.0 cm',
    'image': 'assets/images/bump/week_17.jpg',
  },
  {
    'week': '18',
    'bumpSize': 'Medium',
    'fact': 'The bump is clearly visible and steadily growing.',
    'babyLength': '14.2 cm',
    'image': 'assets/images/bump/week_18.jpg',
  },
  {
    'week': '19',
    'bumpSize': 'Medium',
    'fact': 'The bump is clearly visible and steadily growing.',
    'babyLength': '15.3 cm',
    'image': 'assets/images/bump/week_19.jpg',
  },
  {
    'week': '20',
    'bumpSize': 'Growing larger',
    'fact': 'Your belly is expanding upward and outward.',
    'babyLength': '25.6 cm',
    'image': 'assets/images/bump/week_20.jpg',
  },
  {
    'week': '21',
    'bumpSize': 'Growing larger',
    'fact': 'Your belly is expanding upward and outward.',
    'babyLength': '26.7 cm',
    'image': 'assets/images/bump/week_21.jpg',
  },
  {
    'week': '22',
    'bumpSize': 'Growing larger',
    'fact': 'Your belly is expanding upward and outward.',
    'babyLength': '27.8 cm',
    'image': 'assets/images/bump/week_22.jpg',
  },
  {
    'week': '23',
    'bumpSize': 'Growing larger',
    'fact': 'Your belly is expanding upward and outward.',
    'babyLength': '28.9 cm',
    'image': 'assets/images/bump/week_23.jpg',
  },
  {
    'week': '24',
    'bumpSize': 'Growing larger',
    'fact': 'Your belly is expanding upward and outward.',
    'babyLength': '30.0 cm',
    'image': 'assets/images/bump/week_24.jpg',
  },
  {
    'week': '25',
    'bumpSize': 'Large',
    'fact': 'The bump is prominent. Movement may be felt more often.',
    'babyLength': '34.6 cm',
    'image': 'assets/images/bump/week_25.jpg',
  },
  {
    'week': '26',
    'bumpSize': 'Large',
    'fact': 'The bump is prominent. Movement may be felt more often.',
    'babyLength': '35.6 cm',
    'image': 'assets/images/bump/week_26.jpg',
  },
  {
    'week': '27',
    'bumpSize': 'Large',
    'fact': 'The bump is prominent. Movement may be felt more often.',
    'babyLength': '36.6 cm',
    'image': 'assets/images/bump/week_27.jpg',
  },
  {
    'week': '28',
    'bumpSize': 'Large',
    'fact': 'The bump is prominent. Movement may be felt more often.',
    'babyLength': '37.6 cm',
    'image': 'assets/images/bump/week_28.jpg',
  },
  {
    'week': '29',
    'bumpSize': 'Large',
    'fact': 'The bump is prominent. Movement may be felt more often.',
    'babyLength': '38.6 cm',
    'image': 'assets/images/bump/week_29.jpg',
  },
  {
    'week': '30',
    'bumpSize': 'Very large',
    'fact': 'The bump is round and firm. Your posture may begin to change.',
    'babyLength': '39.9 cm',
    'image': 'assets/images/bump/week_30.jpg',
  },
  {
    'week': '31',
    'bumpSize': 'Very large',
    'fact': 'The bump is round and firm. Your posture may begin to change.',
    'babyLength': '41.1 cm',
    'image': 'assets/images/bump/week_31.jpg',
  },
  {
    'week': '32',
    'bumpSize': 'Very large',
    'fact': 'The bump is round and firm. Your posture may begin to change.',
    'babyLength': '42.4 cm',
    'image': 'assets/images/bump/week_32.jpg',
  },
  {
    'week': '33',
    'bumpSize': 'Very large',
    'fact': 'The bump is round and firm. Your posture may begin to change.',
    'babyLength': '43.7 cm',
    'image': 'assets/images/bump/week_33.jpg',
  },
  {
    'week': '34',
    'bumpSize': 'Very large',
    'fact': 'The bump is round and firm. Your posture may begin to change.',
    'babyLength': '45.0 cm',
    'image': 'assets/images/bump/week_34.jpg',
  },
  {
    'week': '35',
    'bumpSize': 'Full term',
    'fact': 'Your bump is at its peak size, baby is getting ready for birth.',
    'babyLength': '46.2 cm',
    'image': 'assets/images/bump/week_35.jpg',
  },
  {
    'week': '36',
    'bumpSize': 'Full term',
    'fact': 'Your bump is at its peak size, baby is getting ready for birth.',
    'babyLength': '47.4 cm',
    'image': 'assets/images/bump/week_36.jpg',
  },
  {
    'week': '37',
    'bumpSize': 'Full term',
    'fact': 'Your bump is at its peak size, baby is getting ready for birth.',
    'babyLength': '48.6 cm',
    'image': 'assets/images/bump/week_37.jpg',
  },
  {
    'week': '38',
    'bumpSize': 'Full term',
    'fact': 'Your bump is at its peak size, baby is getting ready for birth.',
    'babyLength': '49.8 cm',
    'image': 'assets/images/bump/week_38.jpg',
  },
  {
    'week': '39',
    'bumpSize': 'Full term',
    'fact': 'Your bump is at its peak size, baby is getting ready for birth.',
    'babyLength': '50.7 cm',
    'image': 'assets/images/bump/week_39.jpg',
  },
  {
    'week': '40',
    'bumpSize': 'Full term',
    'fact': 'Your bump is at its peak size, baby is getting ready for birth.',
    'babyLength': '51.2 cm',
    'image': 'assets/images/bump/week_40.jpg',
  },
];


  int selectedWeekIndex = 0;
  TextEditingController appointmentTitleController = TextEditingController();
  TextEditingController hospitalController = TextEditingController();
  TextEditingController doctorController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool setReminder = true;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  void _initializeNotifications() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin!.initialize(initializationSettings);
  }

  Future<void> _scheduleNotification(Appointment appointment) async {
    if (!appointment.reminder) return;

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'appointment_channel_id',
      'Appointments',
      channelDescription: 'Appointment reminders',
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    // Schedule notification for 24 hours before appointment
    var scheduledDate = DateTime(
      appointment.date.year,
      appointment.date.month,
      appointment.date.day,
      appointment.time.hour,
      appointment.time.minute,
    ).subtract(Duration(days: 1));

    await flutterLocalNotificationsPlugin!.schedule(
      appointments.length, // Using length as a unique ID
      'Upcoming Appointment: ${appointment.title}',
      'Tomorrow at ${appointment.time.format(context)} with Dr. ${appointment.doctor} at ${appointment.hospital}',
      scheduledDate,
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          _getAppBarTitle(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: Icon(Icons.person, color: Colors.grey),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: _getPageContent(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xFFDC52AE),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _updateSelectedCard(index);
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.health_and_safety),
            label: 'Tools',
          ),
        ],
      ),
    );
  }

  String _getAppBarTitle() {
    switch (selectedCard) {
      case SelectedCard.today:
        return 'Today';
      case SelectedCard.bump:
        return 'Explore';
      case SelectedCard.tools:
        return 'Pregnancy Tools';
    }
  }

  void _updateSelectedCard(int index) {
    switch (index) {
      case 0:
        selectedCard = SelectedCard.today;
        break;
      case 1:
        selectedCard = SelectedCard.bump;
        break;
      case 2:
        selectedCard = SelectedCard.tools;
        break;
    }
  }

  Widget _getPageContent() {
    switch (selectedCard) {
      case SelectedCard.today:
        return todayView();
      case SelectedCard.bump:
        return exploreView();
      case SelectedCard.tools:
        return toolsView();
    }
  }

  Widget todayView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_today, size: 80, color: Colors.grey[300]),
          SizedBox(height: 16),
          Text(
            "Today View",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Please check the Tools tab for all features",
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget exploreView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.explore, size: 80, color: Colors.grey[300]),
          SizedBox(height: 16),
          Text(
            "Explore View",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Please check the Tools tab for all features",
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget toolsView() {
    List<Map<String, dynamic>> tools = [
      {'title': 'My Bump Tracker', 'icon': Icons.pregnant_woman, 'index': 0},
      {'title': 'Appointment Manager', 'icon': Icons.calendar_today, 'index': 1},
      {'title': 'Due Date Calculator', 'icon': Icons.date_range, 'index': 2},

    ];

    return Column(
      children: [
        Container(
          height: 120,
          child: GridView.builder(
            padding: EdgeInsets.all(16),
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 12,
              childAspectRatio: 1.1,
            ),
            itemCount: tools.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedToolIndex = tools[index]['index'];
                  });
                },
                child: Container(
                  width: 600,
                  decoration: BoxDecoration(
                    color: selectedToolIndex == tools[index]['index'] 
                        ? Color(0xFFDC52AE) 
                        : Colors.pink[50],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        tools[index]['icon'],
                        color: selectedToolIndex == tools[index]['index'] 
                            ? Colors.white 
                            : Color(0xFFDC52AE),
                        size: 32,
                      ),
                      SizedBox(height: 8),
                      Text(
                        tools[index]['title'],
                        style: TextStyle(
                          color: selectedToolIndex == tools[index]['index'] 
                              ? Colors.white 
                              : Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: _getSelectedToolContent(),
        ),
      ],
    );
  }

  Widget _getSelectedToolContent() {
    switch (selectedToolIndex) {
      case 0:
        return myBumpView();
      case 1:
        return appointmentsView();
      case 2:
        return dueDateCalculatorView();
      default:
        return myBumpView();
    }
  }

  Widget myBumpView() {
    var selectedData = pregnancyData[selectedWeekIndex];

    return Column(
      children: [
        Container(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 12),
            itemCount: pregnancyData.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedWeekIndex = index;
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: selectedWeekIndex == index ? Color(0xFFDC52AE) : Colors.pink[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Week ${pregnancyData[index]['week']}",
                      style: TextStyle(
                        color: selectedWeekIndex == index ? Colors.white : Colors.pink[900],
                        fontWeight: selectedWeekIndex == index ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          "Week ${selectedData['week']}",
                          style: TextStyle(
                            fontSize: 24, 
                            fontWeight: FontWeight.bold, 
                            color: Color(0xFFDC52AE),
                          ),
                        ),
                        SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            height: 180,
                            width: double.infinity,
                            color: Colors.grey[300],
                            child: Icon(
                              Icons.pregnant_woman,
                              size: 80,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Icon(Icons.straighten, color: Color(0xFFDC52AE)),
                                Text(
                                  selectedData['babyLength'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text("Length", style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                            Column(
                              children: [
                                Icon(Icons.zoom_out_map, color: Color(0xFFDC52AE)),
                                Text(
                                  selectedData['bumpSize'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text("Bump Size", style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Did you know?",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFDC52AE),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          selectedData['fact'],
                          style: TextStyle(fontSize: 16, height: 1.5),
                          textAlign: TextAlign.center,
                        ),
                        if (selectedData['comparison'] != null) ...[
                          SizedBox(height: 16),
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.pink[50],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "Your baby is about the size of a ${selectedData['comparison']}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFDC52AE),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Track Your Symptoms",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSymptomButton("Nausea", Icons.sick),
                    _buildSymptomButton("Fatigue", Icons.hotel),
                    _buildSymptomButton("Cravings", Icons.fastfood),
                    _buildSymptomButton("Mood", Icons.emoji_emotions),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSymptomButton(String label, IconData icon) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.pink[50],
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Color(0xFFDC52AE), size: 28),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget appointmentsView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TableCalendar(
                focusedDay: _selectedDay,
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Color(0xFFDC52AE),
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.pink[100],
                    shape: BoxShape.circle,
                  ),
                  weekendTextStyle: TextStyle(color: Colors.red[300]),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                  });
                },
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
              ),
            ),
          ),
          SizedBox(height: 24),
          Text(
            "Add New Appointment",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: appointmentTitleController,
                    decoration: InputDecoration(
                      labelText: "Appointment Title",
                      filled: true,
                      fillColor: Colors.grey[100],
                      prefixIcon: Icon(Icons.edit_calendar, color: Color(0xFFDC52AE)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: hospitalController,
                    decoration: InputDecoration(
                      labelText: "Hospital/Clinic Name",
                      filled: true,
                      fillColor: Colors.grey[100],
                      prefixIcon: Icon(Icons.local_hospital, color: Color(0xFFDC52AE)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: doctorController,
                    decoration: InputDecoration(
                      labelText: "Doctor Name",
                      filled: true,
                      fillColor: Colors.grey[100],
                      prefixIcon: Icon(Icons.person, color: Color(0xFFDC52AE)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: notesController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: "Notes",
                      filled: true,
                      fillColor: Colors.grey[100],
                      prefixIcon: Icon(Icons.note, color: Color(0xFFDC52AE)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_month, color: Colors.grey),
                          SizedBox(width: 8),
                          Text(
                            "${_selectedDay.day}/${_selectedDay.month}/${_selectedDay.year}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () async {
                          final TimeOfDay? time = await showTimePicker(
                            context: context,
                            initialTime: selectedTime,
                          );
                          if (time != null) {
                            setState(() {
                              selectedTime = time;
                            });
                          }
                        },
                        child: Row(
                          children: [
                            Icon(Icons.access_time, color: Color(0xFFDC52AE)),
                            SizedBox(width: 8),
                            Text(
                              selectedTime.format(context),
                              style: TextStyle(
                                color: Color(0xFFDC52AE),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  SwitchListTile(
                    title: Text("Set Reminder (24 hours before)"),
                    value: setReminder,
                    activeColor: Color(0xFFDC52AE),
                    onChanged: (value) {
                      setState(() {
                        setReminder = value;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (appointmentTitleController.text.isNotEmpty &&
                          hospitalController.text.isNotEmpty &&
                          doctorController.text.isNotEmpty) {
                        final newAppointment = Appointment(
                          title: appointmentTitleController.text,
                          hospital: hospitalController.text,
                          doctor: doctorController.text,
                          date: _selectedDay,
                          time: selectedTime,
                          notes: notesController.text,
                          reminder: setReminder,
                        );
                        
                        setState(() {
                          appointments.add(newAppointment);
                          appointmentTitleController.clear();
                          hospitalController.clear();
                          doctorController.clear();
                          notesController.clear();
                        });
                        
                        if (setReminder) {
                          _scheduleNotification(newAppointment);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFDC52AE),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Save Appointment",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          Text(
            "Upcoming Appointments",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          appointments.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Icon(Icons.event_busy, size: 48, color: Colors.grey[400]),
                        SizedBox(height: 16),
                        Text(
                          "No appointments yet",
                          style: TextStyle(color: Colors.grey[600], fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    final appointment = appointments[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.pink[50],
                          child: Icon(Icons.medical_services, color: Color(0xFFDC52AE)),
                        ),
                        title: Text(
                          appointment.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Dr. ${appointment.doctor} at ${appointment.hospital}"),
                            Text(
                              "${appointment.date.day}/${appointment.date.month}/${appointment.date.year} at ${appointment.time.format(context)}",
                              style: TextStyle(
                                color: Color(0xFFDC52AE),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        isThreeLine: true,
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }

  Widget dueDateCalculatorView() {
    return Center(
      child: Card(
        margin: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.date_range,
                size: 64,
                color: Color(0xFFDC52AE),
              ),
              SizedBox(height: 20),
              Text(
                "Due Date Calculator",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFDC52AE),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Calculate your expected due date based on your last menstrual period date",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton.icon(
                icon: Icon(Icons.calendar_today),
                label: Text(
                  "Select Last Period Date",
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFDC52AE),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // Show date picker
                },
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.pink[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      "Your Estimated Due Date:",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "February 15, 2026",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFDC52AE),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}