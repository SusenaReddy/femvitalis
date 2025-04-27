import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(SaraBabyApp());
}

class SaraBabyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFFFF4081),
        primarySwatch: Colors.pink,
        fontFamily: 'Nunito',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFFF4081),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
      ),
      home: BabyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BabyHomePage extends StatefulWidget {
  @override
  _BabyHomePageState createState() => _BabyHomePageState();
}

class _BabyHomePageState extends State<BabyHomePage> {
  int babyDays = 16;
  int babyMonths = 0;

  void _editBabyDays() {
    TextEditingController _controller = TextEditingController(text: babyDays.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFFFCE4EC),
        title: Text('Edit Baby Days', style: TextStyle(color: Color(0xFFD81B60))),
        content: TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Enter days",
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFF4081)),
            ),
          ),
        ),
        actions: [
          TextButton(
            child: Text('Cancel', style: TextStyle(color: Color(0xFF757575))),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text('Save', style: TextStyle(color: Color(0xFFD81B60), fontWeight: FontWeight.bold)),
            onPressed: () {
              setState(() {
                babyDays = int.tryParse(_controller.text) ?? babyDays;
                babyMonths = (babyDays ~/ 30); // simple logic: 30 days = 1 month
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget buildIcon(String label, String imagePath, [VoidCallback? onPressed]) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFFFCE4EC),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imagePath,
              height: 60,
              width: 60,
              fit: BoxFit.contain,
              
            ),
            SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
               
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF4081),
        title: Text(
          'BABY PORTAL',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFF80AB), Color(0xFFFCE4EC)],
            stops: [0.0, 0.3],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/baby.jpg',
                        width: 60,
                        height: 60,
                        
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              '$babyDays',
                              style: TextStyle(
                                fontSize: 48,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Days',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Image.asset(
                            'assets/images/edit.png',
                            color: Colors.white.withOpacity(0.8),
                            width: 20,
                            height: 20,
                          ),
                          onPressed: _editBabyDays,
                        ),
                        SizedBox(width: 20),
                        Column(
                          children: [
                            Text(
                              '$babyMonths',
                              style: TextStyle(
                                fontSize: 48,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Months',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Baby will be ${babyMonths + 1} months after ${30 - (babyDays % 30)} days',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 16.0, bottom: 16.0),
                      child: Text(
                        'Baby Activities',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          
                        ),
                      ),
                    ),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      childAspectRatio: 1.3,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      padding: EdgeInsets.all(8),
                      children: [
                        buildIcon(
                          'Breastfeed',
                          'assets/images/breastfeed.jpg',
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const BreastfeedingPage()),
                            );
                          },
                        ),
                        buildIcon(
                          'Bottle',
                          'assets/images/bottle.jpg',
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const BottlePage()),
                            );
                          },
                        ),
                        buildIcon(
                          'Diaper',
                          'assets/images/diaper.jpg',
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DiaperLogScreen()),
                            );
                          },
                        ),
                        buildIcon(
                          'Food', 
                          'assets/images/food.jpeg', () {
                          // Navigate to Sleep Log Page
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => FoodTrackingScreen()),
                            );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xFFD81B60),
        unselectedItemColor: Color(0xFFAD1457).withOpacity(0.6),
        backgroundColor: Colors.white,
        elevation: 12,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Records'),
          BottomNavigationBarItem(icon: Icon(Icons.question_answer), label: 'Q&A'),
        ],
      ),
    );
  }
}

class BreastfeedingPage extends StatefulWidget {
  const BreastfeedingPage({super.key});

  @override
  State<BreastfeedingPage> createState() => _BreastfeedingPageState();
}

class _BreastfeedingPageState extends State<BreastfeedingPage> {
  Timer? leftTimer;
  Timer? rightTimer;
  int leftSeconds = 0;
  int rightSeconds = 0;
  bool isLeftRunning = false;
  bool isRightRunning = false;

  final TextEditingController _noteController = TextEditingController();

  String savedNote = '';
  String savedTime = '';

  void toggleLeftTimer() {
    if (isLeftRunning) {
      leftTimer?.cancel();
    } else {
      leftTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        setState(() {
          leftSeconds++;
        });
      });
    }
    setState(() {
      isLeftRunning = !isLeftRunning;
    });
  }

  void toggleRightTimer() {
    if (isRightRunning) {
      rightTimer?.cancel();
    } else {
      rightTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        setState(() {
          rightSeconds++;
        });
      });
    }
    setState(() {
      isRightRunning = !isRightRunning;
    });
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  void saveData() {
    setState(() {
      savedNote = _noteController.text;
      savedTime = formatTime(leftSeconds + rightSeconds);
      _noteController.clear();
      leftSeconds = 0;
      rightSeconds = 0;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Breastfeeding session saved!'),
        backgroundColor: Color(0xFFEC407A),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  void dispose() {
    leftTimer?.cancel();
    rightTimer?.cancel();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFEC407A),
        title: const Text('Breastfeeding', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFEC407A).withOpacity(0.1), Colors.white],
            stops: [0.0, 0.3],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFF8BBD0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Color(0xFFAD1457)),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Track Feeding Times',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFAD1457)),
                          ),
                          Text(
                            'Press play to start timing each breast',
                            style: TextStyle(color: Color(0xFFAD1457)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Total Time',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF880E4F),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      formatTime(leftSeconds + rightSeconds),
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD81B60),
                      ),
                    ),
                    Divider(height: 32, color: Color(0xFFF8BBD0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildBreastTimer('Left', leftSeconds, isLeftRunning, toggleLeftTimer),
                        Container(
                          height: 100,
                          width: 1,
                          color: Color(0xFFF8BBD0),
                        ),
                        _buildBreastTimer('Right', rightSeconds, isRightRunning, toggleRightTimer),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Notes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF880E4F),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _noteController,
                decoration: InputDecoration(
                  hintText: 'Add a Note',
                  hintStyle: TextStyle(color: Color(0xFFAD1457).withOpacity(0.5)),
                  filled: true,
                  fillColor: Color(0xFFFFEBEE),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFFEC407A)),
                  ),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: (!isLeftRunning && !isRightRunning) ? saveData : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (!isLeftRunning && !isRightRunning) ? Color(0xFFEC407A) : Color(0xFFEC407A).withOpacity(0.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                  child: Text(
                    'SAVE SESSION',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              if (savedNote.isNotEmpty || savedTime.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFFFCE4EC),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Color(0xFFF8BBD0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.history, color: Color(0xFFD81B60)),
                          SizedBox(width: 8),
                          Text(
                            'Last Session',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD81B60),
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 16, color: Color(0xFFF8BBD0)),
                      Text(
                        'Total Time: $savedTime',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF880E4F),
                        ),
                      ),
                      SizedBox(height: 8),
                      if (savedNote.isNotEmpty)
                        Text(
                          'Note: $savedNote',
                          style: TextStyle(fontSize: 16, color: Color(0xFF880E4F)),
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

  Widget _buildBreastTimer(String side, int seconds, bool isRunning, VoidCallback toggleTimer) {
    return Column(
      children: [
        Text(
          side,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF880E4F),
          ),
        ),
        SizedBox(height: 8),
        Text(
          formatTime(seconds),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color(0xFFD81B60),
          ),
        ),
        SizedBox(height: 12),
        GestureDetector(
          onTap: toggleTimer,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isRunning ? Color(0xFFE91E63) : Color(0xFFF8BBD0),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFE91E63).withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              isRunning ? Icons.pause : Icons.play_arrow,
              color: isRunning ? Colors.white : Color(0xFFAD1457),
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}

class BottlePage extends StatefulWidget {
  const BottlePage({super.key});

  @override
  State<BottlePage> createState() => _BottlePageState();
}

class _BottlePageState extends State<BottlePage> {
  double milkAmount = 0.0;
  final TextEditingController _noteController = TextEditingController();
  String selectedMilkType = 'Breast milk';
  String selectedUnit = 'oz';

  // New variables to store saved data
  double? savedMilkAmount;
  String? savedNote;
  String? savedMilkType;
  DateTime? savedTime;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void saveBottleData() {
    setState(() {
      savedMilkAmount = milkAmount;
      savedNote = _noteController.text;
      savedMilkType = selectedMilkType;
      savedTime = DateTime.now();
      _noteController.clear();
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Bottle feeding saved!'),
        backgroundColor: Color(0xFFEC407A),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  String formatTime(DateTime datetime) {
    return "${datetime.hour.toString().padLeft(2, '0')}:${datetime.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFEC407A),
        title: Text('Bottle Feed', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFEC407A).withOpacity(0.1), Colors.white],
            stops: [0.0, 0.3],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFF8BBD0),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Color(0xFFAD1457)),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Baby Feeding',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFFAD1457),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Track bottle feeds to monitor baby\'s nutrition',
                            style: TextStyle(fontSize: 14, color: Color(0xFFAD1457)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedMilkType,
                            decoration: InputDecoration(
                              labelText: 'Milk Type',
                              labelStyle: TextStyle(color: Color(0xFF880E4F)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Color(0xFFF8BBD0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Color(0xFFEC407A)),
                              ),
                            ),
                            items: [
                              DropdownMenuItem(value: 'Breast milk', child: Text('Breast milk')),
                              DropdownMenuItem(value: 'Formula', child: Text('Formula')),
                              DropdownMenuItem(value: 'Other', child: Text('Other')),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedMilkType = value!;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedUnit,
                            decoration: InputDecoration(
                              labelText: 'Unit',
                              labelStyle: TextStyle(color: Color(0xFF880E4F)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Color(0xFFF8BBD0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Color(0xFFEC407A)),
                              ),
                            ),
                            items: [
                              DropdownMenuItem(value: 'oz', child: Text('oz')),
                              DropdownMenuItem(value: 'ml', child: Text('ml')),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedUnit = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Amount',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF880E4F),
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xFFFCE4EC),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '${milkAmount.toStringAsFixed(1)} $selectedUnit',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFD81B60),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 16),
                    SliderTheme(
                      data: SliderThemeData(
                        activeTrackColor: Color(0xFFEC407A),
                        inactiveTrackColor: Color(0xFFF8BBD0),
                        thumbColor: Color(0xFFD81B60),
                        overlayColor: Color(0xFFEC407A).withOpacity(0.2),
                        valueIndicatorColor: Color(0xFFD81B60),
                        valueIndicatorTextStyle: TextStyle(color: Colors.white),
                      ),
                      child: Slider(
                        value: milkAmount,
                        min: 0,
                        max: 10,
                        divisions: 100,
                        label: '${milkAmount.toStringAsFixed(1)} $selectedUnit',
                        onChanged: (value) {
                          setState(() {
                            milkAmount = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Notes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF880E4F),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _noteController,
                decoration: InputDecoration(
                  hintText: 'Add a Note',
                  hintStyle: TextStyle(color: Color(0xFFAD1457).withOpacity(0.5)),
                  filled: true,
                  fillColor: Color(0xFFFFEBEE),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFFEC407A)),
                  ),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: saveBottleData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFEC407A),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              if (savedMilkAmount != null)
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFFFCE4EC),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Color(0xFFF8BBD0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.history, color: Color(0xFFD81B60)),
                          SizedBox(width: 8),
                          Text(
                            'Last Bottle',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD81B60),
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 16, color: Color(0xFFF8BBD0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Type: $savedMilkType',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF880E4F),
                            ),
                          ),
                          Text(
                            savedTime != null ? formatTime(savedTime!) : '',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF880E4F),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Amount: ${savedMilkAmount!.toStringAsFixed(1)} $selectedUnit',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF880E4F),
                        ),
                      ),
                      SizedBox(height: 8),
                      if (savedNote != null && savedNote!.isNotEmpty)
                        Text(
                          'Note: $savedNote',
                          style: TextStyle(fontSize: 16, color: Color(0xFF880E4F)),
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

class DiaperLogScreen extends StatefulWidget {
  @override
  _DiaperLogScreenState createState() => _DiaperLogScreenState();
}

class _DiaperLogScreenState extends State<DiaperLogScreen> {
  String selectedDiaperType = 'Mixed';
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  final TextEditingController _noteController = TextEditingController();
  
  // Saved diaper data
  bool hasSavedDiaper = false;
  String? savedDiaperType;
  String? savedNote;
  
  void saveDiaperData() {
    setState(() {
      hasSavedDiaper = true;
      savedDiaperType = selectedDiaperType;
      savedNote = _noteController.text;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Diaper change saved!'),
        backgroundColor: Color(0xFFEC407A),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return "${weekdays[date.weekday - 1]} ${months[date.month - 1]} ${date.day}";
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final period = time.period == DayPeriod.am ? 'am' : 'pm';
    return "${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $period";
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFFEC407A),
              onPrimary: Colors.white,
              onSurface: Color(0xFF880E4F),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFFEC407A),
              onPrimary: Colors.white,
              onSurface: Color(0xFF880E4F),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFEC407A),
        title: Text(
          'Diaper Change',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFEC407A).withOpacity(0.1), Colors.white],
            stops: [0.0, 0.3],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date and Time Selection
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Color(0xFFFCE4EC),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Color(0xFFF8BBD0)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.calendar_today, color: Color(0xFFEC407A), size: 20),
                              SizedBox(width: 8),
                              Text(
                                _formatDate(selectedDate),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFD81B60),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _selectTime(context),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Color(0xFFFCE4EC),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Color(0xFFF8BBD0)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.access_time, color: Color(0xFFEC407A), size: 20),
                              SizedBox(width: 8),
                              Text(
                                _formatTime(selectedTime),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFD81B60),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),

                // Widget Banner
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFFF8BBD0).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFEC407A).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.book, color: Color(0xFFEC407A), size: 28),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Install Baby Routine Widget',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF880E4F),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Quick access to baby tracking from your home screen',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF880E4F),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Color(0xFFAD1457)),
                        onPressed: () {
                          // Close banner
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),

                Text(
                  'Diaper Type',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF880E4F),
                  ),
                ),
                SizedBox(height: 16),

                // Diaper Type Selection
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildDiaperOption('Pee', Icons.opacity),
                      _buildDiaperOption('Poop', Icons.spa),
                      _buildDiaperOption('Mixed', Icons.bubble_chart),
                      _buildDiaperOption('Dry', Icons.block),
                    ],
                  ),
                ),
                SizedBox(height: 24),

                // Color & Consistency
                Container(
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: Color(0xFFFCE4EC),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.tune, color: Color(0xFFAD1457)),
                    title: Text(
                      'Color & Consistency',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF880E4F),
                      ),
                    ),
                    trailing: Icon(Icons.edit, color: Color(0xFFAD1457)),
                  ),
                ),
                SizedBox(height: 24),

                // Notes
                Text(
                  'Notes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF880E4F),
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _noteController,
                  decoration: InputDecoration(
                    hintText: 'Add a Note',
                    hintStyle: TextStyle(color: Color(0xFFAD1457).withOpacity(0.5)),
                    filled: true,
                    fillColor: Color(0xFFFFEBEE),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Color(0xFFEC407A)),
                    ),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 24),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: saveDiaperData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFEC407A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'SAVE',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: 24),
                
                // Saved Diaper Entry
                if (hasSavedDiaper)
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFFFCE4EC),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Color(0xFFF8BBD0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.history, color: Color(0xFFD81B60)),
                            SizedBox(width: 8),
                            Text(
                              'Last Diaper Change',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD81B60),
                              ),
                            ),
                          ],
                        ),
                        Divider(height: 16, color: Color(0xFFF8BBD0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Type: $savedDiaperType',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF880E4F),
                              ),
                            ),
                            Text(
                              _formatTime(selectedTime),
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF880E4F),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        if (savedNote != null && savedNote!.isNotEmpty)
                          Text(
                            'Note: $savedNote',
                            style: TextStyle(fontSize: 16, color: Color(0xFF880E4F)),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDiaperOption(String type, IconData icon) {
    bool isSelected = selectedDiaperType == type;
    Color iconColor = isSelected 
        ? (type == 'Pee' 
            ? Color(0xFF4DB6AC) 
            : type == 'Poop' 
                ? Color(0xFF8D6E63) 
                : type == 'Mixed' 
                    ? Color(0xFFBA68C8) 
                    : Color(0xFF9E9E9E))
        : Color(0xFF9E9E9E);
    
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDiaperType = type;
        });
      },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? Color(0xFFFCE4EC) : Colors.grey[200],
              border: isSelected
                  ? Border.all(color: Color(0xFFEC407A), width: 2)
                  : null,
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: Color(0xFFEC407A).withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 1),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: Icon(
                icon,
                size: 28,
                color: iconColor,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            type,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Color(0xFFD81B60) : Color(0xFF757575),
            ),
          ),
        ],
      ),
    );
  }
}

class FoodTrackingScreen extends StatefulWidget {
  @override
  _FoodTrackingScreenState createState() => _FoodTrackingScreenState();
}

class _FoodTrackingScreenState extends State<FoodTrackingScreen> {
  String selectedReaction = '';
  TextEditingController notesController = TextEditingController();
  TextEditingController amountController = TextEditingController(text: '0');
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFC1E3).withOpacity(0.3),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Navigate back
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xFFFF9800),
              child: Text(
                'S',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(width: 12),
            Text(
              'Sara',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 22
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Baby Bib Icon
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.food_bank_outlined,
                      size: 60,
                      color: Color.fromARGB(255, 232, 124, 170),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32),
              
              // Food Label
              Text(
                'Food',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                'Last: Never',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 24),
              
              // Form Card
              Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Time Row
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(
                          children: [
                            Icon(Icons.access_time, color: Colors.grey),
                            SizedBox(width: 12),
                            Text(
                              'Time',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black87,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '26 Apr',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black87,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            SizedBox(width: 16),
                            Text(
                              '9:26 PM',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black87,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      
                      // Group Row
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(
                          children: [
                            Icon(Icons.folder_outlined, color: Colors.grey),
                            SizedBox(width: 12),
                            Text(
                              'Group',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black87,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'Select group',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black87,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      
                      // Amount Row
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(
                          children: [
                            Icon(Icons.restaurant, color: Colors.grey),
                            SizedBox(width: 12),
                            Text(
                              'Amount',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black87,
                              ),
                            ),
                            Spacer(),
                            SizedBox(
                              width: 60,
                              child: TextField(
                                controller: amountController,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Text(
                              'g',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(width: 12),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                      Divider(),
                      
                      // Reaction Row
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.emoji_emotions_outlined, color: Colors.grey),
                                SizedBox(width: 12),
                                Text(
                                  'Reaction',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildReactionButton('happy', '🙂'),
                                SizedBox(width: 12),
                                _buildReactionButton('neutral', '😐'),
                                SizedBox(width: 12),
                                _buildReactionButton('sad', '☹️'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      
                      // Notes Row
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.chat_bubble_outline, color: Colors.grey),
                                SizedBox(width: 12),
                                Text(
                                  'Notes',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            TextField(
                              controller: notesController,
                              maxLines: 4,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Add notes here...',
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '0/3000',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      
                      // Attachments Row
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(
                          children: [
                            Icon(Icons.attach_file, color: Colors.grey),
                            SizedBox(width: 12),
                            Text(
                              'Attachments',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black87,
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.add_photo_alternate_outlined, color: Colors.grey),
                            SizedBox(width: 16),
                            Icon(Icons.camera_alt_outlined, color: Colors.grey),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              
              // Save Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Save functionality
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2A7886),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReactionButton(String type, String emoji) {
    bool isSelected = selectedReaction == type;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedReaction = type;
        });
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFFFD6EC) : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            emoji,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}