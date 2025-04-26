// main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BabyTrackingProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baby Tracker',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        primaryColor: const Color(0xFF9C27B0),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
      ),
      home: const NewMotherDashboard(),
    );
  }
}

class NewMotherDashboard extends StatefulWidget {
  const NewMotherDashboard({Key? key}) : super(key: key);

  @override
  State<NewMotherDashboard> createState() => _HomePageState();
}

class _HomePageState extends State<NewMotherDashboard> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const TrackingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.track_changes),
            label: 'Track',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class BabyTrackingProvider extends ChangeNotifier {
  String _selectedCategory = 'Breastfeeding';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  
  // Feeding specific
  double _leftAmount = 0.0;
  double _rightAmount = 0.0;
  Duration _leftDuration = Duration.zero;
  Duration _rightDuration = Duration.zero;
  bool _isLeftTimerRunning = false;
  bool _isRightTimerRunning = false;
  
  // Diaper specific
  String _diaperType = 'Pee';  // 'Pee', 'Poop', 'Mixed', 'Dry'
  String _consistency = '';
  
  // Notes
  String _notes = '';
  
  // Getters
  String get selectedCategory => _selectedCategory;
  DateTime get selectedDate => _selectedDate;
  TimeOfDay get selectedTime => _selectedTime;
  String get diaperType => _diaperType;
  String get consistency => _consistency;
  String get notes => _notes;
  double get leftAmount => _leftAmount;
  double get rightAmount => _rightAmount;
  Duration get leftDuration => _leftDuration;
  Duration get rightDuration => _rightDuration;
  bool get isLeftTimerRunning => _isLeftTimerRunning;
  bool get isRightTimerRunning => _isRightTimerRunning;
  
  // Setters
  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
  
  void setDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
  
  void setTime(TimeOfDay time) {
    _selectedTime = time;
    notifyListeners();
  }
  
  void setDiaperType(String type) {
    _diaperType = type;
    notifyListeners();
  }
  
  void setConsistency(String consistency) {
    _consistency = consistency;
    notifyListeners();
  }
  
  void setNotes(String notes) {
    _notes = notes;
    notifyListeners();
  }
  
  void setLeftAmount(double amount) {
    _leftAmount = amount;
    notifyListeners();
  }
  
  void setRightAmount(double amount) {
    _rightAmount = amount;
    notifyListeners();
  }
  
  void toggleLeftTimer() {
    _isLeftTimerRunning = !_isLeftTimerRunning;
    notifyListeners();
  }
  
  void toggleRightTimer() {
    _isRightTimerRunning = !_isRightTimerRunning;
    notifyListeners();
  }
  
  void updateLeftDuration(Duration duration) {
    _leftDuration = duration;
    notifyListeners();
  }
  
  void updateRightDuration(Duration duration) {
    _rightDuration = duration;
    notifyListeners();
  }
  
  void resetFeedingData() {
    _leftAmount = 0.0;
    _rightAmount = 0.0;
    _leftDuration = Duration.zero;
    _rightDuration = Duration.zero;
    _isLeftTimerRunning = false;
    _isRightTimerRunning = false;
    _notes = '';
    notifyListeners();
  }
  
  // Firebase interactions
  Future<void> saveTracking() async {
    try {
      CollectionReference trackingRef = FirebaseFirestore.instance.collection('baby_tracking');
      
      DateTime combinedDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );
      
      Map<String, dynamic> trackingData = {
        'category': _selectedCategory,
        'timestamp': Timestamp.fromDate(combinedDateTime),
        'notes': _notes,
      };
      
      if (_selectedCategory == 'Breastfeeding') {
        trackingData['leftDuration'] = _leftDuration.inSeconds;
        trackingData['rightDuration'] = _rightDuration.inSeconds;
      } else if (_selectedCategory == 'Bottle') {
        trackingData['leftAmount'] = _leftAmount;
        trackingData['rightAmount'] = _rightAmount;
      } else if (_selectedCategory == 'Pump') {
        trackingData['leftAmount'] = _leftAmount;
        trackingData['rightAmount'] = _rightAmount;
      } else if (_selectedCategory == 'Diaper') {
        trackingData['diaperType'] = _diaperType;
        if (_diaperType == 'Poop') {
          trackingData['consistency'] = _consistency;
        }
      }
      
      await trackingRef.add(trackingData);
      resetFeedingData();
    } catch (e) {
      print('Error saving tracking: $e');
    }
  }
}

// TRACKING SCREEN
class TrackingScreen extends StatefulWidget {
  const TrackingScreen({Key? key}) : super(key: key);

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _showWidgetPromo = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    // Listen to tab changes
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        final provider = Provider.of<BabyTrackingProvider>(context, listen: false);
        switch (_tabController.index) {
          case 0:
            provider.setCategory('Breastfeeding');
            break;
          case 1:
            provider.setCategory('Bottle');
            break;
          case 2:
            provider.setCategory('Pump');
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    return DateFormat('h:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BabyTrackingProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Baby\'s Feeding'),
        backgroundColor: Colors.purple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back or to home
          },
        ),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Colors.teal,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.teal,
            tabs: const [
              Tab(text: 'Breastfeeding'),
              Tab(text: 'Bottle'),
              Tab(text: 'Pump'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: provider.selectedDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (picked != null) {
                        provider.setDate(picked);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.calendar_today, color: Colors.teal),
                          const SizedBox(width: 4),
                          Text(
                            DateFormat('EEE MMM dd').format(provider.selectedDate),
                            style: const TextStyle(color: Colors.teal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: provider.selectedTime,
                      );
                      if (picked != null) {
                        provider.setTime(picked);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.access_time, color: Colors.teal),
                          const SizedBox(width: 4),
                          Text(
                            _formatTimeOfDay(provider.selectedTime),
                            style: const TextStyle(color: Colors.teal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_showWidgetPromo)
            Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.book, color: Colors.purple[700], size: 28),
                          const SizedBox(width: 8),
                          Text(
                            'Install the Baby Routine Widget',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            _showWidgetPromo = false;
                          });
                        },
                      ),
                    ],
                  ),
                  const Text(
                    'Log diapers, feedings, baby sleep and more — directly from your Home screen.',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      // Handle the learn more action
                    },
                    child: const Text(
                      'LEARN MORE',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Breastfeeding Tab
                BreastfeedingTab(),
                
                // Bottle Tab
                BottleTab(),
                
                // Pump Tab
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// BREASTFEEDING TAB
class BreastfeedingTab extends StatelessWidget {
  final stopwatchL = Stopwatch();
  final stopwatchR = Stopwatch();

  BreastfeedingTab({Key? key}) : super(key: key);

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigits(duration.inHours):$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BabyTrackingProvider>(context);
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Timer Display
          Text(
            '${provider.leftDuration.inMinutes.toString().padLeft(2, '0')}:${(provider.leftDuration.inSeconds % 60).toString().padLeft(2, '0')}',
            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
          const Text('min   sec', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          
          // Left and Right buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    '${provider.leftDuration.inMinutes.toString().padLeft(2, '0')}:${(provider.leftDuration.inSeconds % 60).toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      provider.toggleLeftTimer();
                      // Start or stop the timer
                    },
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orange.withOpacity(0.1),
                      ),
                      child: Center(
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.orange.withOpacity(0.3),
                          ),
                          child: Center(
                            child: Icon(
                              provider.isLeftTimerRunning ? Icons.pause : Icons.play_arrow,
                              color: Colors.purple,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('L', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                children: [
                  Text(
                    '${provider.rightDuration.inMinutes.toString().padLeft(2, '0')}:${(provider.rightDuration.inSeconds % 60).toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      provider.toggleRightTimer();
                      // Start or stop the timer
                    },
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orange.withOpacity(0.1),
                      ),
                      child: Center(
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.orange.withOpacity(0.3),
                          ),
                          child: Center(
                            child: Icon(
                              provider.isRightTimerRunning ? Icons.pause : Icons.play_arrow,
                              color: Colors.purple,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('R', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          
          const Spacer(),
          
          // Notes Section
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Notes',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: 'Add a Note',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            onChanged: (value) {
              provider.setNotes(value);
            },
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              // Handle manual entry
            },
            child: const Text(
              'ENTER MANUALLY',
              style: TextStyle(color: Colors.teal),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextButton(
              onPressed: () {
                provider.saveTracking();
              },
              child: const Text(
                'SAVE',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'See our Terms of Use and Privacy Policy',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// BOTTLE TAB
class BottleTab extends StatelessWidget {
  const BottleTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BabyTrackingProvider>(context);
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              value: 'Breast milk',
              isExpanded: true,
              items: ['Breast milk', 'Formula', 'Mixed'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (_) {},
            ),
          ),
          const SizedBox(height: 12),
          DropdownButton<String>(
            value: 'oz',
            isExpanded: true,
            items: ['oz', 'ml'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (_) {},
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${provider.leftAmount}',
                style: const TextStyle(
                  color: Colors.teal,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                ' oz',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 8,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
              activeTrackColor: Colors.purple.shade200,
              inactiveTrackColor: Colors.orange.shade100,
              thumbColor: Colors.purple,
            ),
            child: Slider(
              min: 0,
              max: 10,
              divisions: 20,
              value: provider.leftAmount,
              onChanged: (value) {
                provider.setLeftAmount(value);
              },
            ),
          ),
          
          const Spacer(),
          
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Notes',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: 'Add a Note',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            onChanged: (value) {
              provider.setNotes(value);
            },
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              // Handle manual entry
            },
            child: const Text(
              'ENTER MANUALLY',
              style: TextStyle(color: Colors.teal),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextButton(
              onPressed: () {
                provider.saveTracking();
              },
              child: const Text(
                'SAVE',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'See our Terms of Use and Privacy Policy',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
