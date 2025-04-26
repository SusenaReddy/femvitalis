import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pregnancy Tracker',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const PregnancyTracker(),
    
      debugShowCheckedModeBanner: false,
    );
  }
}

class PregnancyTracker extends StatefulWidget {
  const PregnancyTracker({Key? key}) : super(key: key);

  @override
  State<PregnancyTracker> createState() => _PregnancyTrackerState();
}

class _PregnancyTrackerState extends State<PregnancyTracker> {
  int selectedWeek = 6;

  // Complete pregnancy week data with comparison item, length, and fun facts
  final List<Map<String, dynamic>> pregnancyData = [
    {
      'week': '<1',
      'comparison': 'Poppy seed',
      'image': 'assets/images/Poppy_seed.jpg',
      'length': 0.1,
      'fact': 'Fertilization has just happened! Your baby is a single cell starting an amazing journey.'
    },
    {
      'week': '1-2',
      'comparison': 'Poppy seed',
      'image': 'assets/images/Poppy_seed.jpg',
      'length': 0.2,
      'fact': 'The fertilized egg divides and implants in your uterus, beginning the miraculous process of development.'
    },
    {
      'week': '3-4',
      'comparison': 'Chia seed',
      'image': 'assets/images/Chia_seed.jpg',
      'length': 1.5,
      'fact': 'Your baby\'s neural tube, which becomes the brain and spinal cord, begins to form this week.'
    },
    {
      'week': '5',
      'comparison': 'Apple seed',
      'image': 'assets/images/apple_seed.jpg',
      'length': 2.0,
      'fact': 'Your baby\'s heart has begun to form and will start beating soon!'
    },
    {
      'week': '6',
      'comparison': 'Watermelon seed',
      'image': 'assets/images/watermelon_seed.jpg',
      'length': 5.0,
      'fact': 'Your baby\'s heart is now beating about 110 times per minute, and facial features are starting to form.'
    },
    {
      'week': '7',
      'comparison': 'Blueberry',
      'image': 'assets/images/blueberry.png',
      'length': 10.0,
      'fact': 'Tiny buds that will become arms and legs are forming, and your baby\'s head is growing rapidly.'
    },
    {
      'week': '8',
      'comparison': 'Raspberry',
      'image': 'assets/images/raspberry.png',
      'length': 16.0,
      'fact': 'Your baby\'s facial features continue to develop, and fingers and toes are beginning to form.'
    },
    {
      'week': '9',
      'comparison': 'Grape',
      'image': 'assets/images/grape.png',
      'length': 23.0,
      'fact': 'All essential organs have begun to develop, and your baby can make tiny movements now.'
    },
    {
      'week': '10',
      'comparison': 'Kumquat',
      'image': 'assets/images/kumquat.png',
      'length': 31.0,
      'fact': 'Your baby\'s vital organs are now functioning, and tiny toenails are beginning to form.'
    },
    {
      'week': '11',
      'comparison': 'Fig',
      'image': 'assets/images/fig.png',
      'length': 41.0,
      'fact': 'Your baby can open and close their fists and mouth. Tooth buds are beginning to form.'
    },
    {
      'week': '12',
      'comparison': 'Lime',
      'image': 'assets/images/lime.png',
      'length': 53.0,
      'weight': 14.0,
      'fact': 'Your baby\'s reflexes are developing, and they may start to suck their thumb.'
    },
    {
      'week': '13',
      'comparison': 'Lemon',
      'image': 'assets/images/lemon.png',
      'length': 68.0,
      'weight': 23.0,
      'fact': 'Your baby\'s vocal cords are forming, and they\'re growing fingerprints on their tiny fingers.'
    },
    {
      'week': '14',
      'comparison': 'Peach',
      'image': 'assets/images/peach.png',
      'length': 85.0,
      'weight': 43.0,
      'fact': 'Your baby\'s ears are shifting into their final position, and they might be able to squint and frown.'
    },
    {
      'week': '15',
      'comparison': 'Apple',
      'image': 'assets/images/apple.png',
      'length': 98.0,
      'weight': 70.0,
      'fact': 'Your baby is developing taste buds and can sense light even though their eyes are still fused shut.'
    },
    {
      'week': '16',
      'comparison': 'Avocado',
      'image': 'assets/images/avocado.png',
      'length': 116.0,
      'weight': 100.0,
      'fact': 'Your baby can make facial expressions now and may respond to certain sounds.'
    },
    {
      'week': '17',
      'comparison': 'Pear',
      'image': 'assets/images/pear.png',
      'length': 133.0,
      'weight': 140.0,
      'fact': 'Your baby\'s skeleton is changing from cartilage to bone, and they\'re developing a layer of fat.'
    },
    {
      'week': '18',
      'comparison': 'Bell pepper',
      'image': 'assets/images/bell_pepper.png',
      'length': 144.0,
      'weight': 190.0,
      'fact': 'Your baby\'s ears are now in their final position, and they might begin to hear sounds.'
    },
    {
      'week': '19',
      'comparison': 'Mango',
      'image': 'assets/images/mango.png',
      'length': 152.0,
      'weight': 240.0,
      'fact': 'Your baby\'s movements are becoming more coordinated, and their senses are developing rapidly.'
    },
    {
      'week': '20',
      'comparison': 'Banana',
      'image': 'assets/images/banana.png',
      'length': 160.0,
      'weight': 300.0,
      'fact': 'Your baby has developed unique fingerprints and may suck their thumb when resting.'
    },
    {
      'week': '21',
      'comparison': 'Carrot',
      'image': 'assets/images/carrot.png',
      'length': 267.0,
      'weight': 360.0,
      'fact': 'Your baby is swallowing more amniotic fluid, which helps develop their digestive system.'
    },
    {
      'week': '22',
      'comparison': 'Corn on the cob',
      'image': 'assets/images/corn.png',
      'length': 278.0,
      'weight': 430.0,
      'fact': 'Your baby\'s eyebrows and eyelids are fully formed, and they\'re developing a sleep-wake cycle.'
    },
    {
      'week': '23',
      'comparison': 'Grapefruit',
      'image': 'assets/images/grapefruit.png',
      'length': 289.0,
      'weight': 501.0,
      'fact': 'Your baby\'s skin is still wrinkled and translucent but will soon begin to fill out.'
    },
    {
      'week': '24',
      'comparison': 'Cantaloupe',
      'image': 'assets/images/cantaloupe.png',
      'length': 300.0,
      'weight': 600.0,
      'fact': 'Your baby\'s face is almost fully formed with eyelashes, eyebrows, and hair.'
    },
    {
      'week': '25',
      'comparison': 'Cauliflower',
      'image': 'assets/images/cauliflower.png',
      'length': 345.0,
      'weight': 660.0,
      'fact': 'Your baby\'s lungs are developing rapidly as they prepare for breathing air.'
    },
    {
      'week': '26',
      'comparison': 'Lettuce',
      'image': 'assets/images/lettuce.png',
      'length': 360.0,
      'weight': 760.0,
      'fact': 'Your baby\'s eyes are opening, and they\'re starting to develop a startle reflex.'
    },
    {
      'week': '27',
      'comparison': 'Cabbage',
      'image': 'assets/images/cabbage.png',
      'length': 366.0,
      'weight': 875.0,
      'fact': 'Your baby now sleeps and wakes regularly and may get hiccups occasionally.'
    },
    {
      'week': '28',
      'comparison': 'Eggplant',
      'image': 'assets/images/eggplant.png',
      'length': 373.0,
      'weight': 1000.0,
      'fact': 'Your baby can blink their eyes and is developing more regular sleeping patterns.'
    },
    {
      'week': '29',
      'comparison': 'Butternut squash',
      'image': 'assets/images/butternut_squash.png',
      'length': 381.0,
      'weight': 1150.0,
      'fact': 'Your baby\'s brain is developing rapidly, and they can now regulate their body temperature.'
    },
    {
      'week': '30',
      'comparison': 'Coconut',
      'image': 'assets/images/coconut.png',
      'length': 390.0,
      'weight': 1300.0,
      'fact': 'Your baby has fingernails and toenails now, and their bone marrow is making red blood cells.'
    },
    {
      'week': '31',
      'comparison': 'Pineapple',
      'image': 'assets/images/pineapple.png',
      'length': 410.0,
      'weight': 1500.0,
      'fact': 'Your baby can turn their head from side to side and is filling out, gaining more fat.'
    },
    {
      'week': '32',
      'comparison': 'Jicama',
      'image': 'assets/images/jicama.png',
      'length': 420.0,
      'weight': 1700.0,
      'fact': 'Your baby\'s eyes can sense light and dark now, and they\'re practicing breathing movements.'
    },
    {
      'week': '33',
      'comparison': 'Durian',
      'image': 'assets/images/durian.png',
      'length': 430.0,
      'weight': 1900.0,
      'fact': 'Your baby\'s bones are hardening, except for the skull which stays soft for birth.'
    },
    {
      'week': '34',
      'comparison': 'Cantaloupe',
      'image': 'assets/images/cantaloupe.png',
      'length': 450.0,
      'weight': 2100.0,
      'fact': 'Your baby\'s central nervous system and lungs are maturing rapidly each day.'
    },
    {
      'week': '35',
      'comparison': 'Honeydew melon',
      'image': 'assets/images/honeydew.png',
      'length': 460.0,
      'weight': 2400.0,
      'fact': 'Your baby\'s kidneys are fully developed, and their liver can process some waste products.'
    },
    {
      'week': '36',
      'comparison': 'Romaine lettuce',
      'image': 'assets/images/romaine.png',
      'length': 470.0,
      'weight': 2600.0,
      'fact': 'Your baby has probably settled into a head-down position to prepare for birth.'
    },
    {
      'week': '37',
      'comparison': 'Swiss chard',
      'image': 'assets/images/swiss_chard.png',
      'length': 480.0,
      'weight': 2900.0,
      'fact': 'Your baby is now considered "full term" and has a firm grasp with fully formed fingernails.'
    },
    {
      'week': '38',
      'comparison': 'Leek',
      'image': 'assets/images/leek.png',
      'length': 490.0,
      'weight': 3100.0,
      'fact': 'Your baby\'s brain is still developing rapidly and will continue to develop after birth.'
    },
    {
      'week': '39',
      'comparison': 'Watermelon',
      'image': 'assets/images/watermelon.png',
      'length': 500.0,
      'weight': 3300.0,
      'fact': 'Your baby is shedding their lanugo (fine body hair) and building up more fat.'
    },
    {
      'week': '40',
      'comparison': 'Pumpkin',
      'image': 'assets/images/pumpkin.png',
      'length': 510.0,
      'weight': 3500.0,
      'fact': 'Your baby is ready to meet you! Their lungs are fully developed and ready for their first breath.'
    },
  ];

  // Group the weeks for display in the slider
  List<Map<String, dynamic>> getGroupedWeeks() {
    final List<Map<String, dynamic>> displayWeeks = [];
    
    // Add the early weeks as shown in the images
    displayWeeks.add({'label': '<1', 'value': '<1'});
    displayWeeks.add({'label': '1-2', 'value': '1-2'});
    displayWeeks.add({'label': '3-4', 'value': '3-4'});
    
    // Add single weeks from 5-40
    for (int i = 5; i <= 40; i++) {
      displayWeeks.add({'label': '$i', 'value': '$i'});
    }
    
    return displayWeeks;
  }

  // Find the current data based on selected week
  Map<String, dynamic> getCurrentData() {
    final weekStr = selectedWeek.toString();
    
    for (var data in pregnancyData) {
      // Handle special cases like ranges and '<1'
      if (data['week'] == weekStr || 
          (weekStr == '0' && data['week'] == '<1') ||
          (weekStr == '1' && data['week'] == '1-2') ||
          (weekStr == '2' && data['week'] == '1-2') ||
          (weekStr == '3' && data['week'] == '3-4') ||
          (weekStr == '4' && data['week'] == '3-4')) {
        return data;
      }
    }
    
    // Default to week 6 if not found
    return pregnancyData.firstWhere((data) => data['week'] == '6');
  }

  @override
  Widget build(BuildContext context) {
    final currentData = getCurrentData();
    final groupedWeeks = getGroupedWeeks();
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'Size',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: const CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          // Week selector
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: groupedWeeks.length,
              itemBuilder: (context, index) {
                final item = groupedWeeks[index];
                
                // Determine if this week is selected
                bool isSelected = false;
                if (item['value'] == '<1' && selectedWeek == 0) {
                  isSelected = true;
                } else if (item['value'] == '1-2' && (selectedWeek == 1 || selectedWeek == 2)) {
                  isSelected = true;
                } else if (item['value'] == '3-4' && (selectedWeek == 3 || selectedWeek == 4)) {
                  isSelected = true;
                } else if (item['value'] == selectedWeek.toString()) {
                  isSelected = true;
                }
                
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      // Convert week string to int if possible
                      if (item['value'] == '<1') {
                        selectedWeek = 0;
                      } else if (item['value'].contains('-')) {
                        selectedWeek = int.parse(item['value'].split('-')[0]);
                      } else {
                        selectedWeek = int.parse(item['value']);
                      }
                    });
                  },
                  child: Container(
                    width: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item['label'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.pink : Colors.grey,
                          ),
                        ),
                        if (isSelected)
                          Column(
                            children: [
                              const SizedBox(height: 5),
                              Text(
                                'WEEKS',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.pink,
                                ),
                              ),
                              Container(
                                height: 3,
                                width: 60,
                                color: Colors.pink,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const Divider(height: 1),

          // Image section
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  
                  // Single image in oval shape
                  Container(
                    height: 200,
                    width: 300,
                    alignment: Alignment.center,
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          currentData['image'], // Using dynamic image based on selected week
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  
                  // Comparison name text
                  Text(
                    currentData['comparison'],
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Size by fruit button
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'SIZE BY FRUIT',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Length and weight container
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        // Length section
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const Text(
                                  'Length',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  currentData['length'].toString(),
                                  style: const TextStyle(
                                    fontSize: 42,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Text(
                                  'mm',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  '(crown to rump)',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        // Divider
                        Container(
                          height: 100,
                          width: 1,
                          color: Colors.grey.shade400,
                        ),
                        
                        // Weight section
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const Text(
                                  'Weight',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  currentData.containsKey('weight') ? 
                                      currentData['weight'].toString() : '-',
                                  style: const TextStyle(
                                    fontSize: 42,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                if (currentData.containsKey('weight'))
                                  const Text(
                                    'g',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Fun fact section
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color:Colors.pink,),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Fun Fact:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          currentData['fact'],
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  
                  // Visual representation of baby's size and development
                  const SizedBox(height: 30),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pink.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          
          // Bottom navigation bar
          Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () {
                        Navigator.pushNamed(context, '/explore');
                      },
                      color: Colors.grey,
                    ),
                    const Text('Today', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.explore),
                      onPressed: () {},
                      color: Colors.grey,
                    ),
                    const Text('Explore', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.medical_services),
                      onPressed: () {},
                      color: Colors.grey,
                    ),
                    const Text('tools', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}