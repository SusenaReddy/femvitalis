import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'shopping.dart';

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
      routes: {
        '/explore': (context) => const HomePages(),
        '/tools': (context) => HomeScreen(),
        '/shopping': (context) => const RewardsPage(),
      },
    
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
      'image': 'assets/images/raspberry.jpg',
      'length': 16.0,
      'fact': 'Your baby\'s facial features continue to develop, and fingers and toes are beginning to form.'
    },
    {
      'week': '9',
      'comparison': 'Grape',
      'image': 'assets/images/grape.jpg',
      'length': 23.0,
      'fact': 'All essential organs have begun to develop, and your baby can make tiny movements now.'
    },
    {
      'week': '10',
      'comparison': 'Kumquat',
      'image': 'assets/images/kumquat.jpg',
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
      'image': 'assets/images/lime.jpeg',
      'length': 53.0,
      'weight': 14.0,
      'fact': 'Your baby\'s reflexes are developing, and they may start to suck their thumb.'
    },
    {
      'week': '13',
      'comparison': 'Lemon',
      'image': 'assets/images/lemon.jpeg',
      'length': 68.0,
      'weight': 23.0,
      'fact': 'Your baby\'s vocal cords are forming, and they\'re growing fingerprints on their tiny fingers.'
    },
    {
      'week': '14',
      'comparison': 'Peach',
      'image': 'assets/images/peach.jpeg',
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
      'image': 'assets/images/pear.jpeg',
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
      'image': 'assets/images/mango.jpeg',
      'length': 152.0,
      'weight': 240.0,
      'fact': 'Your baby\'s movements are becoming more coordinated, and their senses are developing rapidly.'
    },
    {
      'week': '20',
      'comparison': 'Banana',
      'image': 'assets/images/banana.jpeg',
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
      'image': 'assets/images/corn.jpeg',
      'length': 278.0,
      'weight': 430.0,
      'fact': 'Your baby\'s eyebrows and eyelids are fully formed, and they\'re developing a sleep-wake cycle.'
    },
    {
      'week': '23',
      'comparison': 'Grapefruit',
      'image': 'assets/images/grapefruit.jpeg',
      'length': 289.0,
      'weight': 501.0,
      'fact': 'Your baby\'s skin is still wrinkled and translucent but will soon begin to fill out.'
    },
    {
      'week': '24',
      'comparison': 'Cantaloupe',
      'image': 'assets/images/cantaloupe.jpg',
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
      'image': 'assets/images/eggplant.jpeg',
      'length': 373.0,
      'weight': 1000.0,
      'fact': 'Your baby can blink their eyes and is developing more regular sleeping patterns.'
    },
    {
      'week': '29',
      'comparison': 'Butternut squash',
      'image': 'assets/images/butternut_squash.jpg',
      'length': 381.0,
      'weight': 1150.0,
      'fact': 'Your baby\'s brain is developing rapidly, and they can now regulate their body temperature.'
    },
    {
      'week': '30',
      'comparison': 'Coconut',
      'image': 'assets/images/coconut.jpeg',
      'length': 390.0,
      'weight': 1300.0,
      'fact': 'Your baby has fingernails and toenails now, and their bone marrow is making red blood cells.'
    },
    {
      'week': '31',
      'comparison': 'Pineapple',
      'image': 'assets/images/pineapple.jpeg',
      'length': 410.0,
      'weight': 1500.0,
      'fact': 'Your baby can turn their head from side to side and is filling out, gaining more fat.'
    },
    {
      'week': '32',
      'comparison': 'Jicama',
      'image': 'assets/images/jicama.jpeg',
      'length': 420.0,
      'weight': 1700.0,
      'fact': 'Your baby\'s eyes can sense light and dark now, and they\'re practicing breathing movements.'
    },
    {
      'week': '33',
      'comparison': 'Durian',
      'image': 'assets/images/durian.jpeg',
      'length': 430.0,
      'weight': 1900.0,
      'fact': 'Your baby\'s bones are hardening, except for the skull which stays soft for birth.'
    },
    {
      'week': '34',
      'comparison': 'Cantaloupe',
      'image': 'assets/images/cantaloupe.jpg',
      'length': 450.0,
      'weight': 2100.0,
      'fact': 'Your baby\'s central nervous system and lungs are maturing rapidly each day.'
    },
    {
      'week': '35',
      'comparison': 'Honeydew melon',
      'image': 'assets/images/honeydew.jpeg',
      'length': 460.0,
      'weight': 2400.0,
      'fact': 'Your baby\'s kidneys are fully developed, and their liver can process some waste products.'
    },
    {
      'week': '36',
      'comparison': 'Romaine lettuce',
      'image': 'assets/images/romaine.jpeg',
      'length': 470.0,
      'weight': 2600.0,
      'fact': 'Your baby has probably settled into a head-down position to prepare for birth.'
    },
    {
      'week': '37',
      'comparison': 'Swiss chard',
      'image': 'assets/images/swiss_chard.jpeg',
      'length': 480.0,
      'weight': 2900.0,
      'fact': 'Your baby is now considered "full term" and has a firm grasp with fully formed fingernails.'
    },
    {
      'week': '38',
      'comparison': 'Leek',
      'image': 'assets/images/leek.jpeg',
      'length': 490.0,
      'weight': 3100.0,
      'fact': 'Your baby\'s brain is still developing rapidly and will continue to develop after birth.'
    },
    {
      'week': '39',
      'comparison': 'Watermelon',
      'image': 'assets/images/watermelon.jpeg',
      'length': 500.0,
      'weight': 3300.0,
      'fact': 'Your baby is shedding their lanugo (fine body hair) and building up more fat.'
    },
    {
      'week': '40',
      'comparison': 'Pumpkin',
      'image': 'assets/images/pumpkin.jpg',
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
          onPressed: () {
            Navigator.pop(context);

          },
        ),
        title: const Text(
          'Size',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: const CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white),
              ),
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
            height: 80,
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
                      onPressed: () {
                        Navigator.pushNamed(context, '/explore');
                      },
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
                      onPressed: () {
                        Navigator.pushNamed(context, '/tools');
                      },
                      color: Colors.grey,
                    ),
                    const Text('tools', style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () {
                        Navigator.pushNamed(context, '/shopping');
                      },
                      color: Colors.grey,
                    ),
                    const Text('Rewards', style: TextStyle(fontSize: 12)),
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

class HomePages extends StatelessWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        title: const Text(
          "Women's Health Insights",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.orange[300],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.monetization_on, color: Colors.white, size: 16),
                const SizedBox(width: 4),
                Text(
                  '2450', // Example coin balance
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategorySection('Week by Week', weekByWeekArticles),
            _buildCategorySection('Nutrition', nutritionArticles),
            _buildCategorySection('Body', bodyArticles),
            _buildCategorySection('Baby', babyArticles),
            _buildCategorySection('Common Pregnancy Myths', mythsArticles),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(String category, List<Article> articles) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              category,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 210,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
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
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12)),
                          child: Image.asset(
                            article.imageUrl,
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            article.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${article.coins} Coins',
                                style: TextStyle(
                                  color: Colors.orange[300],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Icon(
                                Icons.monetization_on,
                                color: Colors.orange,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ArticleDetailPage extends StatelessWidget {
  final Article article;

  const ArticleDetailPage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
        backgroundColor: Colors.teal,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.orange[300],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.monetization_on, color: Colors.white, size: 16),
                const SizedBox(width: 4),
                Text(
                  '${article.coins}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    article.imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.orange[300],
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.orange[100]!, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.monetization_on,
                            color: Colors.white, size: 16),
                        const SizedBox(width: 2),
                        Text(
                          '${article.coins}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              article.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Category: ${article.category}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              article.content,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            if (article.relatedArticles.isNotEmpty) ...[
              const SizedBox(height: 24),
              const Text(
                'Related Articles',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ...article.relatedArticles.map((title) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.article, size: 16, color: Colors.teal),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.teal,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ],
        ),
      ),
    );
  }
}

class Article {
  final String id;
  final String title;
  final String imageUrl;
  final String category;
  final String content;
  final List<String> relatedArticles;
  final int coins;

  Article({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.category,
    required this.content,
    this.relatedArticles = const [],
    this.coins = 2,
  });
}

// Add similar mock data for other categories.

// article_data.dart
// Week by week articles
final List<Article> weekByWeekArticles = [
  Article(
    id: 'week1',
    title: '1 week',
    imageUrl: 'assets/images/week1.jpg',
    category: 'Week by week',
    content: 'At 1 week pregnant, you\'re actually not pregnant yet. As your healthcare provider will tell you, the first week of pregnancy is calculated as the week of your last menstrual period. Since conception typically occurs about two weeks after the start of your period, you haven\'t conceived at this point. Your body is preparing for ovulation, when an egg will be released from your ovary.\n\nDuring this time, your uterus is shedding its lining from the previous cycle, which is what causes menstrual bleeding. Meanwhile, your body is already starting to prepare for the possibility of pregnancy. Hormones are signaling to your ovaries to prepare an egg for release.\n\nThough you\'re not physically pregnant during week 1, it\'s still an important time to take care of your health if you\'re planning to conceive. Taking prenatal vitamins with folic acid, avoiding alcohol and tobacco, maintaining a healthy diet, and getting regular exercise are all great ways to prepare your body for pregnancy.',
    relatedArticles: [
      'Understanding your menstrual cycle',
      'Preparing your body for pregnancy',
      'Signs of ovulation',
    ],
  ),
  Article(
    id: 'week2',
    title: '2 weeks',
    imageUrl: 'assets/images/week2.jpg',
    category: 'Week by week',
    content: 'At 2 weeks pregnant, you\'re still not actually pregnant. This is the week when ovulation occurs. Your body has been preparing for this moment - a mature egg is released from one of your ovaries and begins its journey through the fallopian tube, where it may meet sperm and become fertilized.\n\nYour body provides several clues that ovulation is approaching or has occurred. You might notice changes in your cervical mucus, which becomes clearer and more slippery, similar to egg whites. This helps sperm travel up to meet the egg. Some women also experience a slight pain or twinge on one side of their lower abdomen (called mittelschmerz), which signals that an egg has been released.\n\nIf you\'re trying to conceive, this is your most fertile time. Having intercourse every day or every other day during this period maximizes your chances of pregnancy. Sperm can survive in the female reproductive tract for up to 5 days, so having sex in the days leading up to ovulation also increases your odds of conception.\n\nEven though fertilization may occur during this week, you still wouldn\'t be considered pregnant yet. Pregnancy officially begins when the fertilized egg implants in the uterine lining, which happens about 6-10 days after fertilization.',
    relatedArticles: [
      'Tracking your fertile window',
      'How to recognize ovulation symptoms',
      'Timing intercourse for conception',
    ],
  ),
  Article(
    id: 'week3',
    title: '3 weeks',
    imageUrl: 'assets/images/week3.jpg',
    category: 'Week by week',
    content: 'At 3 weeks pregnant, fertilization may have occurred. If a sperm has successfully fertilized your egg, the cells immediately begin dividing to form a cluster called a zygote. This tiny cluster of cells contains all the genetic information for your future baby – half from you and half from your partner.\n\nAfter fertilization, the zygote continues to divide as it travels down the fallopian tube toward the uterus. By the time it reaches your uterus, about 5-6 days after fertilization, it has developed into a blastocyst - a hollow ball of cells with an inner cell mass that will develop into the embryo.\n\nThe blastocyst then begins the process of implantation - attaching to and embedding itself in the lining of your uterus. This process takes several days and is crucial for pregnancy to be established. The cells that form the outer layer of the blastocyst will eventually develop into the placenta, which will nourish your baby throughout pregnancy.\n\nMost women don\'t experience any symptoms at this stage, and you won\'t get a positive pregnancy test yet because the hormone hCG (which pregnancy tests detect) isn\'t produced in sufficient quantities until implantation is complete.',
    relatedArticles: [
      'The journey from egg to embryo',
      'When to take a pregnancy test',
      'Early signs of implantation',
    ],
  ),
  Article(
    id: 'week4',
    title: '4 weeks',
    imageUrl: 'assets/images/week4.jpeg',
    category: 'Week by week',
    content: 'At 4 weeks pregnant, your baby is the size of a poppy seed. The blastocyst has fully implanted in your uterine lining, and the placenta and embryo are beginning to develop.\n\nThis is typically when you might miss your period and suspect you\'re pregnant. At this stage, a home pregnancy test may detect the pregnancy hormone hCG in your urine, especially if you test first thing in the morning when the hormone is most concentrated.\n\nThe embryo now consists of three layers: the ectoderm (which will become the nervous system, skin, hair, and nails), the mesoderm (which will form the heart, blood vessels, muscles, and bones), and the endoderm (which will develop into internal organs like the lungs, intestines, and bladder).\n\nYou might not feel any different yet, but some women begin to experience early pregnancy symptoms around now, including:\n- Mild cramping or spotting (from implantation)\n- Fatigue\n- Breast tenderness\n- Nausea\n- Frequent urination\n- Food aversions or cravings\n\nIf you haven\'t already, now is a good time to start taking prenatal vitamins and schedule your first prenatal appointment, which typically happens between weeks 8 and 12.',
    relatedArticles: [
      'First signs of pregnancy',
      'Choosing the right prenatal vitamin',
      'When to see your doctor',
    ],
  ),
  Article(
    id: 'week5',
    title: '5 weeks',
    imageUrl: 'assets/images/week5.jpg',
    category: 'Week by week',
    content: 'At 5 weeks pregnant, your baby is about the size of a sesame seed (about 3mm long). The embryo now resembles a tiny tadpole, with a head and a tail. This week marks the beginning of the embryonic period, which is a time of rapid development.\n\nOne of the most significant developments this week is the formation of the neural tube, which will eventually become your baby\'s brain, spinal cord, and nervous system. The heart also begins to form and may even start beating by the end of this week, though it\'s too small to hear or feel yet.\n\nYour baby\'s arm and leg buds are starting to form, appearing as tiny paddles on the sides of the embryo. The placenta continues to develop, forming the essential connection that will provide oxygen and nutrients to your growing baby throughout pregnancy.\n\nAs for you, pregnancy symptoms may be intensifying. Morning sickness (which can occur at any time of day) often begins around this time, along with increased fatigue, breast tenderness, and frequent urination. Your body is producing more blood to support your pregnancy, and your heart may be beating faster.\n\nEmotionally, you might be experiencing mood swings as your hormone levels change dramatically. This is completely normal during pregnancy.',
    relatedArticles: [
      'Managing morning sickness',
      'Getting enough rest during first trimester',
      'Early fetal development',
    ],
  ),
  Article(
    id: 'week6',
    title: '6 weeks',
    imageUrl: 'assets/images/week6.jpeg',
    category: 'Week by week',
    content: 'At 6 weeks pregnant, your baby is about the size of a sweet pea (about 6mm long). The embryo is growing rapidly, with the head developing faster than the rest of the body.\n\nYour baby\'s heart is now beating at a rapid pace - around 110 beats per minute - and can sometimes be detected on an ultrasound at this stage. The basic structures of the brain and nervous system are forming, and tiny buds that will develop into arms and legs are growing.\n\nFacial features are beginning to take shape, with dark spots marking the places where eyes will form, and small depressions indicating the future ears and nostrils. Internal organs continue to develop, with the lungs, liver, and kidneys starting to form.\n\nYour pregnancy symptoms may be quite noticeable by now. Morning sickness, food aversions, and heightened sense of smell are common as hormone levels rise. You might also experience:\n- Extreme fatigue\n- Frequent urination\n- Mood swings\n- Breast changes (tenderness, darkening areolas)\n- Mild cramping or spotting\n\nWhile your pregnancy isn\'t visible from the outside yet, your uterus is already expanding to accommodate your growing baby.',
    relatedArticles: [
      'Understanding pregnancy hormone changes',
      'When to worry about spotting',
      'Relieving first trimester discomforts',
    ],
  ),
  Article(
    id: 'week7',
    title: '7 weeks',
    imageUrl: 'assets/images/week7.png',
    category: 'Week by week',
    content: 'At 7 weeks pregnant, your baby is about the size of a blueberry (around 1 cm long). The embryo is developing rapidly, with approximately 100 new brain cells forming every minute!\n\nYour baby\'s face is becoming more defined this week. The eyes are more prominent, with the beginnings of eyelids. Small depressions that will form the nostrils are visible, and the mouth and tongue are starting to develop. Tiny buds that will become the ears have formed on the sides of the head.\n\nThe arm and leg buds are growing longer and beginning to form cartilage that will eventually become bones. Small paddle-like hands and feet are starting to form at the ends of these limbs.\n\nInternally, your baby\'s digestive tract and other organs continue to develop. The umbilical cord is fully formed, creating the vital connection between baby and placenta for oxygen and nutrient transfer.\n\nYou may be experiencing intensified pregnancy symptoms by now. Morning sickness often peaks around this time, and your increasing hormone levels might cause:\n- Continued fatigue\n- Food aversions or cravings\n- Increased sense of smell\n- Excess saliva\n- Emotional sensitivity\n- Constipation\n\nYour uterus has doubled in size since you became pregnant, though it\'s still contained within your pelvis and not visible from the outside.',
    relatedArticles: [
      'Coping with intense food aversions',
      'Embryonic development milestones',
      'Managing constipation in pregnancy',
    ],
  ),
  Article(
    id: 'week8',
    title: '8 weeks',
    imageUrl: 'assets/images/week8.png',
    category: 'Week by week',
    content: 'At 8 weeks pregnant, your baby is about the size of a raspberry (about 1.6 cm long). The embryo is now officially referred to as a fetus, marking an important developmental milestone.\n\nYour baby\'s facial features continue to become more defined. The eyes are more obvious, and the eyelids are forming. The nose is taking shape, and the external ears are developing. The lips and palate are forming in the mouth.\n\nThe limbs are growing longer, and fingers and toes are beginning to form, though they may still be webbed. Major organs are developing rapidly under the thin, translucent skin. The heart has divided into four chambers and is beating at approximately 150-170 beats per minute – about twice as fast as your own heart rate.\n\nYour baby\'s digestive tract continues to develop, with the intestines growing. The neural tube, which will become the brain and spinal cord, has closed completely.\n\nAs for you, pregnancy symptoms may be at their peak. Morning sickness can be particularly challenging around this time. Your breasts may continue to change, becoming larger and more tender. Other symptoms may include:\n- Extreme fatigue\n- Frequent urination\n- Mood swings\n- Bloating and gas\n- Food aversions or cravings\n\nMany women have their first prenatal appointment around this time, where you might get to see your baby on ultrasound for the first time.',
    relatedArticles: [
      'What to expect at your first prenatal visit',
      'Understanding fetal heart development',
      'Pregnancy diet: what to eat when nothing appeals',
    ],
  ),
  Article(
    id: 'week9',
    title: '9 weeks',
    imageUrl: 'assets/images/week9.png',
    category: 'Week by week',
    content: 'At 9 weeks pregnant, your baby is about the size of a grape (approximately 2.3 cm long). The embryonic stage is ending, and the fetal period begins as critical structures and organs have formed.\n\nYour baby\'s body is becoming more proportionate, with the head still large but now more in balance with the rest of the body. The neck is becoming more defined, and the trunk is straightening.\n\nThe arms and legs are growing longer, and the wrists, elbows, and ankles are visible. Fingers and toes are distinct now, though they may still be slightly webbed. Tiny muscles are developing, allowing for small movements, though you won\'t be able to feel them yet.\n\nInternally, major organs continue to develop and begin functioning. The liver is producing red blood cells, and the heart is fully formed and beating strongly. Reproductive organs are developing, but it\'s still too early to determine the sex on an ultrasound.\n\nYou may still be experiencing strong pregnancy symptoms, including:\n- Nausea and vomiting\n- Fatigue\n- Mood swings\n- Food aversions\n- Heightened sense of smell\n- Breast changes\n- Frequent urination\n\nYour uterus is continuing to expand, and while you\'re probably not showing much yet, you might notice your waistline thickening slightly.',
    relatedArticles: [
      'When pregnancy symptoms should ease up',
      'Fetal movement development',
      'Managing pregnancy emotions',
    ],
  ),
  Article(
    id: 'week10',
    title: '10 weeks',
    imageUrl: 'assets/images/week10.png',
    category: 'Week by week',
    content: 'At 10 weeks pregnant, your baby is about the size of a strawberry (approximately 3.1 cm long). The critical period of organ development is nearing completion, which means the risk of structural birth defects decreases after this point.\n\nYour baby no longer has an embryonic tail and is starting to look more human. The head is still disproportionately large but is more rounded and upright. External ears are formed, and the eyes have developed further, though the eyelids remain fused shut.\n\nAll essential organs have formed and are beginning to function. The brain is developing rapidly, forming nearly 250,000 new neurons every minute. The kidneys are producing urine, which becomes part of the amniotic fluid.\n\nYour baby is becoming active, moving arms and legs, though you won\'t feel these movements for several more weeks. The beginnings of tooth buds are forming under the gums, and fingernails and hair are starting to develop.\n\nFor many women, the intense symptoms of early pregnancy begin to ease around this time, though this varies widely. You might still experience:\n- Nausea and vomiting (though possibly decreasing)\n- Fatigue\n- Increased vaginal discharge\n- Visible veins in your breasts and abdomen\n- Slight uterine cramping as ligaments stretch\n\nYour uterus is now about the size of a grapefruit and may be felt just above your pubic bone. While not obvious to others, you might notice your pants feeling tighter around the waist.',
    relatedArticles: [
      'Signs of approaching second trimester',
      'Understanding prenatal screening tests',
      'Baby\'s brain development in the first trimester',
    ],
  ),
];

// Nutrition articles
final List<Article> nutritionArticles = [
  Article(
    id: 'nutrition1',
    title: 'Essential nutrients for pregnancy',
    imageUrl: 'assets/images/nutrition1.jpeg',
    category: 'Nutrition',
    content: 'Proper nutrition during pregnancy is crucial for both maternal health and fetal development. Here are the key nutrients you need:\n\nFolate/Folic Acid: Essential for preventing neural tube defects. Found in leafy greens, fortified cereals, beans, and prenatal vitamins. Aim for 600-800 mcg daily.\n\nIron: Your blood volume increases during pregnancy, requiring more iron. Sources include lean red meat, poultry, fish, beans, and fortified cereals. Most prenatal vitamins contain iron.\n\nCalcium: Critical for developing your baby\'s bones and teeth. Sources include dairy products, fortified plant milks, leafy greens, and calcium-set tofu. Aim for 1,000 mg daily.\n\nProtein: Provides the building blocks for your baby\'s growth. Good sources include lean meats, poultry, fish, eggs, dairy, legumes, and nuts. Try to consume 75-100 grams daily.\n\nOmega-3 Fatty Acids: Support brain and eye development. Sources include fatty fish (salmon, trout), walnuts, flaxseeds, and chia seeds. If you don\'t eat fish regularly, talk to your healthcare provider about supplements.\n\nVitamin D: Aids calcium absorption and bone development. Sources include sunlight, fortified dairy products, fatty fish, and egg yolks. Many women need supplements.\n\nIodine: Essential for thyroid function and brain development. Sources include iodized salt, dairy products, and seafood. Aim for 220-250 mcg daily.\n\nCholine: Supports brain development and may prevent neural tube defects. Sources include eggs, meat, poultry, fish, and soybeans.\n\nRemember that a varied, balanced diet is the best way to get these nutrients, but prenatal vitamins help fill any gaps.',
    relatedArticles: [
      'Foods to avoid during pregnancy',
      'Managing food aversions',
      'Meal planning for pregnancy',
    ],
  ),
  Article(
    id: 'nutrition2',
    title: '5 easy healthy pregnancy snacks',
    imageUrl: 'assets/images/nutrition2.jpg',
    category: 'Nutrition',
    content: 'Healthy snacking is essential during pregnancy to maintain energy levels, provide nutrients for your growing baby, and manage hunger between meals. Here are five nutritious and easy-to-prepare pregnancy snacks:\n\n1. Greek Yogurt Parfait\nLayer Greek yogurt with berries and a sprinkle of granola or nuts. Greek yogurt provides protein and calcium, while berries offer antioxidants and vitamin C. Add a drizzle of honey for natural sweetness if desired.\n\n2. Vegetable Sticks with Hummus\nCarrot, cucumber, bell pepper, and celery sticks paired with hummus make a perfect pregnancy snack. The vegetables provide vitamins and fiber, while hummus adds protein, healthy fats, and iron. Chickpeas in hummus also contain folate, which is crucial during pregnancy.\n\n3. Apple Slices with Nut Butter\nSlice an apple and spread with almond, peanut, or cashew butter. This combination offers fiber, protein, healthy fats, and satisfying crunch. Sprinkle with cinnamon for extra flavor and blood sugar stabilization.\n\n4. Hard-Boiled Eggs with Whole Grain Crackers\nHard-boiled eggs are a convenient source of protein, choline (important for brain development), and vitamin D. Pair with whole grain crackers for added fiber and complex carbohydrates.\n\n5. Smoothie Packs\nPrepare freezer bags with portioned fruits, leafy greens, and a tablespoon of chia or flax seeds. When ready for a snack, blend with milk, yogurt, or a plant-based alternative for a nutrient-dense smoothie packed with vitamins, minerals, protein, and healthy fats.\n\nKeep these snacks readily available to help satisfy hunger while providing essential nutrients for you and your growing baby.',
    relatedArticles: [
      'Managing pregnancy cravings',
      'Portable pregnancy snacks for work',
      'Balancing nutrition in each trimester',
    ],
  ),
  Article(
    id: 'nutrition3',
    title: '5 delicious mocktail recipes',
    imageUrl: 'assets/images/nutrition3.jpeg',
    category: 'Nutrition',
    content: 'Staying hydrated during pregnancy is essential, but plain water can get boring. These alcohol-free mocktails are refreshing, festive alternatives that are safe for you and your baby:\n\n1. Berry Mint Sparkler\nIngredients:\n- 1/2 cup mixed berries (strawberries, blueberries, raspberries)\n- 5-6 fresh mint leaves\n- 1 tablespoon lime juice\n- 1 tablespoon honey or maple syrup\n- Sparkling water\n\nDirections: Muddle berries, mint, lime juice, and sweetener in a glass. Fill with ice and top with sparkling water. Garnish with additional berries and mint.\n\n2. Cucumber Lime Refresher\nIngredients:\n- 3-4 cucumber slices, plus more for garnish\n- 1 tablespoon lime juice\n- 1 teaspoon honey or agave\n- 1/2 cup coconut water\n- Sparkling water\n\nDirections: Muddle cucumber slices with lime juice and sweetener. Add coconut water, ice, and top with sparkling water. Garnish with a cucumber slice.\n\n3. Tropical Sunrise\nIngredients:\n- 1/4 cup orange juice\n- 1/4 cup pineapple juice\n- 1 tablespoon grenadine (non-alcoholic)\n- Sparkling water\n- Orange slice for garnish\n\nDirections: Fill glass with ice. Pour in orange and pineapple juices. Slowly add grenadine, which will sink to the bottom creating a sunrise effect. Top with sparkling water and garnish with an orange slice.\n\n4. Watermelon Mint Cooler\nIngredients:\n- 1 cup cubed watermelon\n- 5 mint leaves\n- 1 tablespoon lime juice\n- 1 teaspoon honey (optional)\n- Sparkling water\n\nDirections: Blend watermelon until smooth. Strain if desired. Muddle mint leaves in a glass. Add watermelon puree, lime juice, and honey. Fill with ice and top with sparkling water.\n\n5. Spiced Apple Cider Fizz\nIngredients:\n- 1/2 cup apple cider or juice\n- 1/4 teaspoon cinnamon\n- Pinch of nutmeg\n- 1 tablespoon lemon juice\n- Sparkling water\n- Apple slice and cinnamon stick for garnish\n\nDirections: Mix apple cider with spices and lemon juice. Pour over ice and top with sparkling water. Garnish with an apple slice and cinnamon stick.\n\nThese mocktails are not only delicious but provide hydration and nutrients from the fruit and herb ingredients. They\'re perfect for social gatherings when you want something special without the alcohol.',
    relatedArticles: [
      'The importance of hydration in pregnancy',
      'Safe caffeinated and herbal teas',
      'Managing drink cravings during pregnancy',
    ],
  ),
  Article(
    id: 'nutrition4',
    title: 'The importance of staying hydrated',
    imageUrl: 'assets/images/nutrition4.png',
    category: 'Nutrition',
    content: 'Hydration during pregnancy is crucial for both maternal health and fetal development. Your body\'s water needs increase during pregnancy to support the additional blood volume, amniotic fluid production, and other physiological changes.\n\nWhy Hydration Matters During Pregnancy:\n\nBlood Volume Increase: Your blood volume increases by about 50% during pregnancy, requiring more water to maintain proper circulation and blood pressure.\n\nAmniotic Fluid Formation: Proper hydration ensures adequate amniotic fluid, which creates a protective environment for your baby and allows for movement and growth.\n\nNutrient Delivery: Water helps transport nutrients to the placenta and ultimately to your baby.\n\nToxin Removal: Adequate hydration supports kidney function, helping to eliminate waste products from both your body and your baby\'s.\n\nOverheating Prevention: Pregnancy raises your body temperature slightly, and staying hydrated helps regulate body temperature and prevent overheating.\n\nConstipation Prevention: Water softens stool and helps prevent constipation, a common pregnancy discomfort.\n\nRecommended Intake:\nMost pregnant women need about 8-12 cups (64-96 ounces) of water daily, though this can vary based on activity level, climate, and individual needs. Your urine should be pale yellow—darker urine indicates you need to drink more.\n\nTips for Staying Hydrated:\n- Carry a water bottle everywhere\n- Set reminders to drink regularly\n- Flavor water with fruit slices or herbs if plain water is unappealing\n- Consume hydrating foods like watermelon, cucumber, and oranges\n- Count other beverages like milk and decaffeinated tea toward fluid intake\n- Limit caffeine, which can have a mild diuretic effect\n\nSigns of dehydration include dark urine, headaches, dry mouth, dizziness, and fatigue. If you experience these symptoms, increase fluid intake and contact your healthcare provider if they persist.',
    relatedArticles: [
      'Managing morning sickness while staying hydrated',
      'Safe beverages during pregnancy',
      'Electrolyte balance during pregnancy',
    ],
  ),
  Article(
    id: 'nutrition5',
    title: 'Foods to avoid during pregnancy',
    imageUrl: 'assets/images/nutrition5.png',
    category: 'Nutrition',
    content: 'During pregnancy, certain foods should be avoided or limited to protect your health and your baby\'s development. Here\'s a comprehensive guide to foods that require caution during pregnancy:\n\nRaw or Undercooked Animal Products:\n- Raw or undercooked meat, poultry, and seafood: These may contain harmful bacteria like Salmonella, E. coli, or parasites.\n- Raw eggs or foods containing raw eggs (like homemade mayonnaise, some hollandaise sauces, raw cookie dough): Risk of Salmonella contamination.\n- Raw or undercooked shellfish: May contain harmful bacteria or viruses.\n\nCertain Seafood:\n- High-mercury fish: Shark, swordfish, king mackerel, tilefish, bigeye tuna, marlin, and orange roughy can contain levels of mercury that may harm your baby\'s developing nervous system.\n- Limit albacore (white) tuna to 6 ounces per week.\n- Local fish from contaminated waters (check local advisories).\n\nUnpasteurized Dairy and Juices:\n- Unpasteurized (raw) milk and products made from it\n- Soft cheeses made from unpasteurized milk (like Brie, Camembert, blue-veined cheeses, queso fresco)\n- Unpasteurized fruit and vegetable juices\n\nProcessed Meats:\n- Deli meats and hot dogs: Unless heated until steaming hot (165°F) to kill potential Listeria bacteria\n- Refrigerated pâtés or meat spreads\n\nAlcohol:\n- All forms of alcohol should be avoided as there is no known safe level during pregnancy. Alcohol consumption can lead to fetal alcohol spectrum disorders (FASDs).\n\nCaffeine:\n- Limit to 200mg per day (about one 12oz cup of coffee)\n- Remember that chocolate, tea, and some medications also contain caffeine\n\nHerbal Teas and Supplements:\n- Many herbal teas and supplements haven\'t been studied in pregnant women\n- Avoid herbs like black cohosh, dong quai, and others marketed for hormonal effects\n- Check with your healthcare provider before taking any herbal products\n\nUnwashed Produce:\n- Always wash fruits and vegetables thoroughly to remove bacteria, pesticides, and soil\n\nExcessive Liver and Liver Products:\n- Limit these as they contain high levels of vitamin A, which in large amounts can harm your baby\n\nWhen in doubt about a food\'s safety during pregnancy, consult with your healthcare provider for personalized advice.',
    relatedArticles: [
      'Safe alternatives to your favorite foods',
      'Understanding food safety during pregnancy',
      'Meal planning with food restrictions',
    ],
  ),
  Article(
    id: 'nutrition6',
    title: 'Managing pregnancy cravings',
    imageUrl: 'assets/images/nutrition6.png',
    category: 'Nutrition',
    content: 'Pregnancy cravings are extremely common, affecting about 50-90% of pregnant women. These intense desires for specific foods (or sometimes non-food items) are thought to be caused by hormonal changes, nutritional needs, and enhanced smell and taste sensations. Here\'s how to manage them healthfully:\n\nUnderstanding Your Cravings:\n- Sweet cravings: May be related to increased energy needs or blood sugar fluctuations\n- Salty cravings: Could indicate electrolyte needs or changes in taste perception\n- Sour cravings: Often appear in first trimester and may help with nausea\n- Spicy cravings: May relate to the body\'s cooling mechanism through sweating\n\nHealthy Approaches to Managing Cravings:\n\n1. Listen to your body, but balance indulgence with nutrition. If you crave ice cream, have a small portion and pair it with fruit for added nutrients.\n\n2. Look for healthier substitutes: \n- Craving chocolate? Try dark chocolate (70%+ cacao) which has less sugar and more antioxidants\n- Want something salty? Choose lightly salted nuts instead of potato chips\n- Desiring something sweet? Try frozen grapes or a fruit smoothie\n- Craving something crunchy? Go for air-popped popcorn or veggie sticks\n\n3. Eat regular meals and snacks to prevent extreme hunger, which can intensify cravings.\n\n4. Stay hydrated – sometimes thirst can be misinterpreted as food cravings.\n\n5. Distract yourself with a short walk, hobby, or calling a friend if cravings hit at inconvenient times.\n\n6. Get adequate sleep, as fatigue can increase cravings for sugary or carb-heavy foods.\n\nWhen to Be Concerned:\n- Pica: Cravings for non-food items like clay, dirt, chalk, or ice. This can indicate iron deficiency and should be reported to your healthcare provider immediately.\n- Cravings that lead to excessive weight gain\n- Cravings that replace nutritious foods in your diet\n\nRemember that occasional indulgence is fine, but aim for moderation and balance in your overall pregnancy diet.',
    relatedArticles: [
      'Emotional eating during pregnancy',
      'Pregnancy nutrition by trimester',
      'Understanding pregnancy aversions',
    ],
  ),
  Article(
    id: 'nutrition7',
    title: 'First trimester nutrition essentials',
    imageUrl: 'assets/images/nutrition7.png',
    category: 'Nutrition',
    content: 'First trimester nutrition is crucial even though your baby is still tiny. This is when organs begin forming, making certain nutrients particularly important. However, morning sickness and food aversions can make eating well challenging.\n\nKey Nutrients for the First Trimester:\n\nFolate/Folic Acid: Critical for preventing neural tube defects, which develop in the first 28 days after conception—often before many women know they\'re pregnant. Take a prenatal vitamin with 600-800 mcg of folic acid daily, and eat folate-rich foods like leafy greens, citrus fruits, beans, and fortified grains.\n\nIron: Supports increased blood volume and oxygen transport. Good sources include lean red meat, chicken, fish, beans, lentils, and fortified cereals. Vitamin C helps with iron absorption, so pair iron-rich foods with citrus fruits, bell peppers, or tomatoes.\n\nCalcium: Essential for developing your baby\'s bones and teeth. Sources include dairy products, fortified plant milks, leafy greens, and calcium-set tofu.\n\nOmega-3 Fatty Acids: Support brain and eye development. Sources include fatty fish (limit to 8-12 oz of low-mercury options weekly), walnuts, chia, and flax seeds.\n\nVitamin B6: May help reduce nausea. Found in chicken, fish, potatoes, bananas, and chickpeas.\n\nManaging Morning Sickness:\n- Eat small, frequent meals to keep something in your stomach\n- Keep plain crackers by your bed to eat before getting up\n- Focus on bland, simple foods if you\'re nauseated\n- Stay hydrated with small sips throughout the day\n- Try ginger tea or candies, which may help ease nausea\n- Separate eating and drinking by about 30 minutes\n- Avoid strong smells that trigger nausea\n\nWhen Nothing Seems Appealing:\n- Focus on getting any nutrition rather than perfect nutrition\n- Try cold foods if hot food smells bother you\n- Smoothies can deliver nutrients when solid foods are unappealing\n- Eat what stays down, even if it\'s the same few foods\n- Take your prenatal vitamin to help fill nutritional gaps\n\nRemember that first trimester eating doesn\'t have to be perfect. The goal is to get adequate nutrition while managing symptoms.',
    relatedArticles: [
      'Coping with severe morning sickness',
      'When to take prenatal vitamins',
      'Recognizing dehydration in pregnancy',
    ],
  ),
  Article(
    id: 'nutrition8',
    title: 'Second trimester nutrition guide',
    imageUrl: 'assets/images/nutrition8.png',
    category: 'Nutrition',
    content: 'The second trimester (weeks 14-27) is often called the "golden period" of pregnancy. For many women, nausea subsides, energy returns, and appetite improves. This is an ideal time to focus on optimal nutrition as your baby experiences significant growth.\n\nNutritional Needs During the Second Trimester:\n\nCalories: Your caloric needs increase by about 300-350 calories per day during the second trimester. Focus on nutrient-dense foods rather than empty calories.\n\nProtein: Essential for your baby\'s tissue growth and your increased blood volume. Aim for 75-100 grams daily from sources like lean meats, poultry, fish, eggs, dairy, legumes, and tofu.\n\nCalcium: Critical as your baby\'s skeleton develops rapidly. Need remains at 1,000-1,300 mg daily (depending on your age) from dairy products, fortified plant milks, leafy greens, and calcium-set tofu.\n\nIron: Blood volume continues to increase, requiring 27 mg daily. Sources include lean red meat, chicken, fish, beans, lentils, and fortified cereals.\n\nOmega-3 Fatty Acids: Support ongoing brain development. Include low-mercury fish like salmon 2-3 times weekly, or plant sources like walnuts, flaxseeds, and chia seeds.\n\nVitamin D: Works with calcium for bone development. Sources include sunlight, fortified dairy products, fatty fish, and egg yolks. Many women need a supplement.\n\nSecond Trimester Nutrition Tips:\n\n1. Create balanced meals with protein, complex carbohydrates, healthy fats, and plenty of fruits and vegetables.\n\n2. Stay hydrated with 8-10 cups of fluid daily as your blood volume increases and to support amniotic fluid.\n\n3. Manage constipation (common in this trimester) by eating fiber-rich foods, staying hydrated, and remaining physically active.\n\n4. Choose nutrient-dense snacks like yogurt with fruit, hummus with vegetables, or a small handful of nuts.\n\n5. Continue taking your prenatal vitamin daily.\n\n6. Monitor weight gain – typical second-trimester gain is about 12-14 pounds total.\n\n7. Limit empty calories from sugary foods and beverages, which can contribute to excessive weight gain and gestational diabetes risk.\n\nThis trimester is an excellent time to establish healthy eating habits that will benefit both you and your baby through the rest of your pregnancy and beyond.',
    relatedArticles: [
      'Exercise and nutrition in the second trimester',
      'Managing heartburn through diet',
      'Gestational diabetes prevention',
    ],
  ),
  Article(
    id: 'nutrition9',
    title: 'Third trimester nutrition tips',
    imageUrl: 'assets/images/nutrition9.png',
    category: 'Nutrition',
    content: 'During the third trimester (weeks 28-40), your baby is growing rapidly, and your nutritional needs reach their peak. However, your expanding uterus can compress your stomach, making it challenging to eat large meals. Here\'s how to optimize your nutrition during this final stretch:\n\nNutritional Needs During the Third Trimester:\n\nCalories: Your needs increase to about 450-500 additional calories daily compared to pre-pregnancy. Focus on nutrient-density rather than volume.\n\nProtein: Crucial for your baby\'s final growth spurt. Continue aiming for 75-100 grams daily from sources like lean meats, poultry, fish, eggs, dairy, legumes, and tofu.\n\nIron: Supports your increased blood volume and helps build your baby\'s iron stores for the first six months of life. Continue with 27 mg daily through diet and supplements if prescribed.\n\nCalcium: Essential as your baby\'s bones strengthen and prepare for birth. Maintain 1,000-1,300 mg daily intake.\n\nOmega-3 Fatty Acids: Critical for brain development, which accelerates in the third trimester. Continue consuming low-mercury fish or plant sources.\n\nVitamin D: Works with calcium for final bone development. Many women need supplementation, especially in winter months.\n\nManaging Third Trimester Challenges:\n\n1. Eat 5-6 small meals throughout the day rather than three large ones to manage heartburn and stomach compression.\n\n2. Choose nutrient-dense foods that provide maximum nutrition in smaller volumes.\n\n3. Manage heartburn by:\n   - Avoiding spicy, fatty, or acidic foods\n   - Eating slowly and staying upright after meals\n   - Drinking between rather than during meals\n\n4. Combat constipation with:\n   - High-fiber foods (whole grains, fruits, vegetables)\n   - Adequate hydration (8-10 cups daily)\n   - Regular physical activity as approved by your provider\n\n5. Address leg cramps with potassium-rich foods like bananas, sweet potatoes, and yogurt.\n\n6. Prepare for labor by maintaining steady energy levels through balanced nutrition and staying well-hydrated.\n\n7. Consider stocking your freezer with nutritious meals for after delivery, especially if you plan to breastfeed.\n\nRemember that quality nutrition now not only supports your baby\'s final development but also helps prepare your body for labor, delivery, and recovery.',
    relatedArticles: [
      'Foods that may help prepare for labor',
      'Postpartum nutrition planning',
      'Managing water retention through diet',
    ],
  ),
  Article(
    id: 'nutrition10',
    title: 'Nutrition for breastfeeding',
    imageUrl: 'assets/images/nutrition10.png',
    category: 'Nutrition',
    content: 'Proper nutrition while breastfeeding is essential not only for producing quality milk for your baby but also for supporting your own recovery and energy levels. In many ways, your nutritional needs during lactation are even higher than during pregnancy.\n\nNutritional Needs While Breastfeeding:\n\nCalories: You need approximately 450-500 extra calories daily beyond your pre-pregnancy needs. This supports milk production and prevents excessive postpartum weight loss, which could affect milk supply.\n\nProtein: Aim for 65-75 grams daily to support milk production and tissue repair. Good sources include lean meats, poultry, fish, eggs, dairy, legumes, and tofu.\n\nCalcium: Required at levels of 1,000-1,300 mg daily to protect your bone health while providing calcium for your baby\'s needs. If you don\'t get enough, your body will take calcium from your bones to ensure your milk has sufficient amounts.\n\nIron: Important for your energy levels and recovery, especially if you experienced blood loss during delivery. Continue with iron-rich foods like lean red meat, fortified cereals, beans, and leafy greens.\n\nOmega-3 Fatty Acids: Continue consuming sources like low-mercury fish, walnuts, and flaxseeds, as these beneficial fats pass through breast milk to support your baby\'s brain development.\n\nFluid: Critical for milk production. Aim to drink enough that your urine remains pale yellow, typically about 13-16 cups (3-4 liters) daily. Keep water nearby when nursing.\n\nVitamin D: Continue ensuring adequate intake, as levels in breast milk depend on the mother\'s status. Many lactation specialists recommend supplementation for both mother and baby.\n\nPractical Tips for Breastfeeding Nutrition:\n\n1. Prepare easy-to-grab nutritious snacks and keep them where you usually nurse, such as trail mix, yogurt cups, or pre-cut fruit and vegetables.\n\n2. Consider batch cooking and freezing healthy meals while pregnant or accepting meal help from friends and family.\n\n3. Use one-handed foods during nursing sessions, like wraps, smoothies, or granola bars.\n\n4. Stay hydrated by drinking a glass of water each time you nurse.\n\n5. Continue taking prenatal vitamins or switch to postnatal supplements as recommended by your healthcare provider.\n\n6. Be patient with postpartum weight loss; restricting calories too severely can affect milk production.\n\n7. Pay attention to your baby\'s reactions to foods in your diet. Some babies may be sensitive to certain foods like dairy, caffeine, or spicy items.\n\nRemember that breastfeeding requires significant energy. Prioritizing your nutrition helps ensure you can provide for both your baby\'s needs and your own well-being during this demanding time.',
    relatedArticles: [
      'Increasing milk supply through nutrition',
      'Foods that may affect baby\'s digestion',
      'Balancing nutrition and postpartum weight loss',
    ],
  ),
];
final List<Article> bodyArticles = [
  Article(
    id: 'body1',
    title: 'Weight gain',
    imageUrl: 'assets/images/body1.jpeg',
    category: 'Body',
    content: 'Healthy weight gain is an important part of pregnancy, supporting your baby\'s development and preparing your body for breastfeeding. However, gaining the right amount of weight—not too little or too much—is important for both maternal and fetal health.\n\nRecommended Weight Gain Based on Pre-Pregnancy BMI:\n\n- Underweight (BMI < 18.5): 28-40 pounds (12.5-18 kg)\n- Normal weight (BMI 18.5-24.9): 25-35 pounds (11.5-16 kg)\n- Overweight (BMI 25-29.9): 15-25 pounds (7-11.5 kg)\n- Obese (BMI ≥ 30): 11-20 pounds (5-9 kg)\n- Twin pregnancy: 37-54 pounds (16.8-24.5 kg) for normal weight women\n\nTypical Weight Gain Pattern:\n\nFirst Trimester: 1-5 pounds (0.5-2 kg)\nSecond Trimester: About 1 pound (0.5 kg) per week\nThird Trimester: About 1 pound (0.5 kg) per week until the final few weeks, when gain may slow or stop\n\nWhere Does the Weight Go?\n\n- Baby: 7-8 pounds (3-3.6 kg)\n- Placenta: 1-2 pounds (0.5-0.9 kg)\n- Amniotic fluid: 2 pounds (0.9 kg)\n- Uterus: 2 pounds (0.9 kg)\n- Increased blood volume: 3-4 pounds (1.4-1.8 kg)\n- Increased fluid volume: 2-3 pounds (0.9-1.4 kg)\n- Breast tissue: 1-3 pounds (0.5-1.4 kg)\n- Fat and nutrient stores: 6-8 pounds (2.7-3.6 kg)\n\nHealthy Approaches to Weight Gain:\n\n1. Focus on nutrient-dense foods rather than calorie counting.\n\n2. Eat regular meals and snacks containing protein, complex carbohydrates, and healthy fats.\n\n3. Stay physically active with pregnancy-safe exercises as approved by your healthcare provider.\n\n4. Don\'t "eat for two" - you need only about 340-450 extra calories daily in the second and third trimesters.\n\n5. Monitor weight gain at prenatal appointments and discuss concerns with your healthcare provider.\n\nConcerns About Weight Gain:\n\n- Gaining too little: May increase risk of having a small baby or premature birth\n- Gaining too much: May increase risk of gestational diabetes, high blood pressure, cesarean delivery, and postpartum weight retention\n\nRemember that every pregnancy is unique. Your healthcare provider may recommend different weight gain goals based on your specific situation. The focus should always be on supporting a healthy pregnancy rather than body image concerns.',
    relatedArticles: [
      'Exercise safely during pregnancy',
      'Managing pregnancy cravings healthfully',
      'Postpartum weight loss expectations',
    ],
  ),
  Article(
    id: 'body2',
    title: 'Body changes',
    imageUrl: 'assets/images/body2.jpeg',
    category: 'Body',
    content: 'Pregnancy brings remarkable changes to your body beyond just your growing belly. Understanding these changes can help you feel more prepared and comfortable as your body transforms to support your baby\'s development.\n\nFirst Trimester Body Changes:\n\n- Breast changes: Tenderness, swelling, darkening of the areolas, and visible veins as blood flow increases\n- Fatigue: Due to hormonal changes and increased blood production\n- Skin changes: Some women experience early "pregnancy glow" while others may develop acne\n- Bloating: Hormonal changes can slow digestion, causing bloating and constipation\n- Frequent urination: Your growing uterus begins pressing on your bladder\n- Changes in vaginal discharge: Typically increases due to higher estrogen levels\n\nSecond Trimester Body Changes:\n\n- Growing belly: Your uterus rises above your pubic bone and becomes more visible\n- Darkening pigmentation: Linea nigra (dark line down abdomen), darkening of areolas, and possible melasma (facial darkening)\n- Stretch marks: May appear on abdomen, breasts, thighs, or buttocks\n- Hair and nail changes: Many women experience thicker hair and faster-growing nails\n- Nasal congestion and nosebleeds: Due to increased blood volume and hormones\n- Round ligament pain: Sharp pains in the lower abdomen as ligaments stretch\n- Increased vaginal discharge: Continues as pregnancy progresses\n\nThird Trimester Body Changes:\n\n- Significant belly growth: Your uterus reaches up under your ribs\n- Skin stretching: Possibly causing itchiness across the abdomen\n- Braxton Hicks contractions: Preparation contractions that feel like abdominal tightening\n- Swelling (edema): Particularly in feet, ankles, and hands due to fluid retention\n- Backache: Due to altered center of gravity and loosening ligaments\n- Shortness of breath: As your growing uterus pushes against your diaphragm\n- Leaking colostrum: Your breasts may produce early milk (colostrum)\n- Pelvic pressure: As your baby drops lower in preparation for birth (lightening)\n\nPostpartum Body Changes:\n\n- Uterine contractions: As your uterus shrinks back to pre-pregnancy size\n- Vaginal discharge (lochia): Bleeding that gradually lightens over several weeks\n- Breast changes: Engorgement when milk comes in, then adaptation to feeding patterns\n- Weight loss: Initial rapid loss of fluid weight, then gradual loss of pregnancy weight\n- Skin changes: Stretch marks fade to silvery lines, pigmentation usually lightens\n- Hair shedding: Often occurs 3-6 months postpartum as hormone levels normalize\n\nThese changes, while sometimes uncomfortable, are normal parts of the incredible process of growing and delivering a baby. Talk to your healthcare provider about any changes that seem severe or concerning.',
    relatedArticles: [
      'Stretch mark prevention and treatment',
      'Managing pregnancy discomforts',
      'Postpartum recovery timeline',
    ],
  ),
  Article(
    id: 'body3',
    title: 'Common pregnancy discomforts',
    imageUrl: 'assets/images/body3.jpeg',
    category: 'Body',
    content: 'Pregnancy brings joy but also various physical discomforts as your body adapts to grow a new life. Here\'s how to manage the most common pregnancy discomforts:\n\nNausea and Vomiting:\n- Eat small, frequent meals to avoid an empty stomach\n- Try bland, dry foods like crackers upon waking\n- Stay hydrated with small, frequent sips\n- Avoid strong smells and greasy foods\n- Consider vitamin B6 supplements or ginger (with provider approval)\n- Seek medical help for severe vomiting (hyperemesis gravidarum)\n\nFatigue:\n- Prioritize sleep with a consistent schedule\n- Take short naps when possible\n- Maintain light exercise for energy\n- Stay hydrated and eat iron-rich foods\n- Accept help and delegate tasks when possible\n\nHeartburn and Indigestion:\n- Eat smaller, more frequent meals\n- Avoid lying down after eating\n- Limit spicy, greasy, and acidic foods\n- Sleep with your upper body slightly elevated\n- Ask your provider about safe antacids if needed\n\nConstipation:\n- Increase fiber intake through fruits, vegetables, and whole grains\n- Stay well-hydrated\n- Exercise regularly\n- Consider fiber supplements if approved by your provider\n\nBack Pain:\n- Practice good posture\n- Wear supportive shoes and consider a maternity support belt\n- Sleep with pillows between knees and supporting your belly\n- Try prenatal yoga or stretching\n- Apply heat or cold (as recommended by your provider)\n\nSwelling (Edema):\n- Elevate your feet when sitting\n- Avoid standing for long periods\n- Wear comfortable, supportive shoes\n- Reduce sodium intake\n- Stay hydrated\n- Report sudden or severe swelling to your provider\n\nVaricose Veins and Hemorrhoids:\n- Avoid standing or sitting for long periods\n- Exercise regularly to improve circulation\n- Elevate legs when resting\n- Wear support stockings\n- Increase fiber and water for hemorrhoid prevention\n\nLeg Cramps:\n- Stretch calves before bed\n- Stay hydrated\n- Consider calcium and magnesium-rich foods\n- Avoid pointing toes when stretching legs\n\nInsomnia:\n- Create a comfortable sleep environment\n- Establish a relaxing bedtime routine\n- Use pillows for support\n- Avoid screens before bed\n- Limit fluids close to bedtime\n\nUrinary Frequency:\n- Continue drinking plenty of fluids during the day but reduce before bedtime\n- Empty bladder completely when urinating\n- Do pelvic floor exercises (Kegels)\n- Report burning or pain with urination to your provider\n\nRemember that while these discomforts are common, severe symptoms should always be discussed with your healthcare provider.',
    relatedArticles: [
      'Safe medications during pregnancy',
      'When to call your doctor about symptoms',
      'Natural remedies for pregnancy discomforts',
    ],
  ),
  Article(
  id: 'body4',
  title: 'Stretch marks during pregnancy',
  imageUrl: 'assets/images/body4.jpeg',
  category: 'Body',
  content: 'Stretch marks are common during pregnancy due to rapid weight gain and skin stretching. They often appear on the belly, breasts, thighs, and hips. Initially red, purple, or dark brown, they usually fade to silvery lines postpartum.\n\nPrevention Tips:\n\n- Keep skin moisturized with cocoa butter, shea butter, or oils\n- Stay hydrated to maintain skin elasticity\n- Maintain a healthy, gradual weight gain\n- Eat nutrient-rich foods that support skin health (vitamin C, E, zinc, and protein)\n\nTreatment:\n\n- Most stretch marks fade naturally\n- Topical treatments like retinoids or hyaluronic acid (only after pregnancy)\n- Laser therapy or microneedling (consult a dermatologist)\n\nStretch marks are a normal part of pregnancy and vary based on genetics, skin type, and weight gain.',
  relatedArticles: [
    'Body changes',
    'Postpartum skin care',
    'Nutrition for healthy skin',
  ],
),

Article(
  id: 'body5',
  title: 'Swelling and fluid retention',
  imageUrl: 'assets/images/body5.jpeg',
  category: 'Body',
  content: 'Swelling, or edema, is common in pregnancy, especially in the feet, ankles, and hands. It typically worsens later in the day and in hot weather.\n\nCauses:\n\n- Increased blood and fluid volume\n- Pressure from the growing uterus on blood vessels\n\nManagement:\n\n- Elevate feet when sitting\n- Sleep on your left side\n- Avoid standing for long periods\n- Wear compression socks\n- Stay hydrated and reduce sodium intake\n\nWhen to Call Your Provider:\n\n- Sudden or severe swelling\n- Swelling with headache, vision changes, or abdominal pain (possible signs of preeclampsia)',
  relatedArticles: [
    'Common pregnancy discomforts',
    'Signs of preeclampsia',
    'Healthy pregnancy habits',
  ],
),

Article(
  id: 'body6',
  title: 'Breast changes in pregnancy',
  imageUrl: 'assets/images/body6.jpeg',
  category: 'Body',
  content: 'Breast changes are among the earliest signs of pregnancy. Your body prepares for breastfeeding through various hormonal shifts.\n\nCommon Changes:\n\n- Tenderness and swelling\n- Darkened areolas and visible veins\n- Enlargement and heaviness\n- Leaking of colostrum in the third trimester\n\nSupport Tips:\n\n- Wear supportive, well-fitting bras\n- Use breast pads if leaking occurs\n- Moisturize nipples if dry or cracked\n\nPostpartum:\n\n- Breasts may become engorged when milk comes in\n- Find a comfortable breastfeeding or pumping routine\n\nThese changes are a natural part of preparing to nourish your baby.',
  relatedArticles: [
    'Body changes',
    'Breastfeeding basics',
    'Postpartum recovery',
  ],
),

Article(
  id: 'body7',
  title: 'Linea nigra and skin darkening',
  imageUrl: 'assets/images/body7.jpeg',
  category: 'Body',
  content: 'Hormonal changes in pregnancy can lead to hyperpigmentation—darkened areas of skin.\n\nCommon Signs:\n\n- Linea nigra: A dark vertical line on the abdomen\n- Darkening of areolas\n- Melasma: Patches of dark skin on the face (mask of pregnancy)\n\nPrevention and Care:\n\n- Use broad-spectrum sunscreen daily\n- Avoid excessive sun exposure\n- Use gentle skin care products\n\nPostpartum:\n\n- Pigmentation usually fades within a few months\n- Avoid skin lightening products while breastfeeding unless prescribed\n\nThese changes are cosmetic and harmless, typically resolving naturally.',
  relatedArticles: [
    'Body changes',
    'Postpartum skin care',
    'Pregnancy-safe skincare',
  ],
),

Article(
  id: 'body8',
  title: 'Postpartum body changes',
  imageUrl: 'assets/images/body8.jpeg',
  category: 'Body',
  content: 'The postpartum period brings many physical changes as your body recovers from childbirth.\n\nWhat to Expect:\n\n- Vaginal discharge (lochia) for several weeks\n- Uterine contractions (afterpains)\n- Breast engorgement or soreness\n- Sweating as your hormones adjust\n- Hair shedding 3-6 months postpartum\n\nRecovery Tips:\n\n- Rest and hydrate\n- Use sanitary pads for lochia\n- Wear nursing bras for support\n- Talk to your provider about pelvic floor exercises\n\nEvery recovery is different. Be gentle with yourself and ask for help when needed.',
  relatedArticles: [
    'Postpartum recovery timeline',
    'Breastfeeding challenges',
    'Mental health after birth',
  ],
),

Article(
  id: 'body9',
  title: 'Pregnancy and body temperature',
  imageUrl: 'assets/images/body9.jpeg',
  category: 'Body',
  content: 'Pregnancy increases your basal body temperature slightly due to hormonal changes and increased blood volume.\n\nEffects:\n\n- Feeling warmer or flushed\n- Increased sweating\n- Sensitivity to heat\n\nTips to Stay Cool:\n\n- Dress in breathable, loose-fitting clothing\n- Stay hydrated\n- Avoid hot tubs and saunas\n- Use fans or air conditioning\n\nMonitor for Fever:\n\n- A temperature over 100.4°F (38°C) may signal infection—consult your provider\n\nFeeling warmer is normal, but overheating should be avoided during pregnancy.',
  relatedArticles: [
    'Common pregnancy discomforts',
    'Safe exercise during pregnancy',
    'Hydration tips for expectant moms',
  ],
),

Article(
  id: 'body10',
  title: 'Pelvic pressure and lightening',
  imageUrl: 'assets/images/body10.jpeg',
  category: 'Body',
  content: 'In late pregnancy, you may feel increased pressure in your pelvis. This often means your baby is "dropping" into position for birth—a process called lightening.\n\nSymptoms:\n\n- Heaviness or pressure in the pelvic region\n- Increased urination\n- Easier breathing as baby moves lower\n\nTips to Ease Discomfort:\n\n- Wear a maternity support belt\n- Do pelvic tilts and gentle stretches\n- Use a birthing ball\n- Rest with feet elevated\n\nThis is a normal sign that your body is preparing for labor, especially in first-time pregnancies.',
  relatedArticles: [
    'Signs labor is near',
    'Body changes in third trimester',
    'Pregnancy exercises for comfort',
  ],
),
];
final List<Article> babyArticles = [
  Article(
  id: 'baby1',
  title: 'Bonding with your baby before birth',
  imageUrl: 'assets/images/baby1.jpeg',
  category: 'Baby',
  content: 'Bonding starts in the womb. Babies can hear voices and respond to touch from around 18–25 weeks of pregnancy.\n\nWays to bond:\n- Talk or sing to your baby\n- Gently touch or massage your belly\n- Play calming music\n- Share your feelings with your baby\n\nBenefits include reduced maternal stress and early emotional attachment.',
  relatedArticles: ['Talking to baby in womb', 'Prenatal connection tips', 'Baby’s hearing development'],
),

Article(
  id: 'baby2',
  title: 'What babies learn in the womb',
  imageUrl: 'assets/images/baby2.jpg',
  category: 'Baby',
  content: 'Babies start learning before they’re born! The womb is a sensory-rich environment that helps early development.\n\nWhat babies learn:\n- Recognize familiar voices\n- React to music and emotions\n- Develop taste from amniotic fluid\n\nFun Fact: Babies may show preference for foods the mother eats during pregnancy.',
  relatedArticles: ['Baby brain development', 'Prenatal music effects', 'Mother-baby sensory connection'],
),

Article(
  id: 'baby3',
  title: 'Talking to your unborn baby',
  imageUrl: 'assets/images/baby3.jpeg',
  category: 'Baby',
  content: 'Talking to your baby during pregnancy can boost early language development and emotional security.\n\nTips:\n- Use a calm, happy tone\n- Repeat your baby’s name\n- Involve your partner or other children\n\nFun Fact: Newborns often recognize and prefer their mother’s voice!',
  relatedArticles: ['Bonding before birth', 'Baby’s sense of hearing', 'Reading to your bump'],
),

Article(
  id: 'baby4',
  title: 'Reading to your bump',
  imageUrl: 'assets/images/baby4.jpeg',
  category: 'Baby',
  content: 'Reading to your baby in the womb can help with language rhythm recognition and emotional bonding.\n\nBenefits:\n- Calms both mother and baby\n- Builds routine\n- Helps baby recognize familiar sounds\n\nChoose simple, rhythmic stories with gentle tones.',
  relatedArticles: ['Talking to baby in womb', 'Prenatal bonding routines', 'Calming pregnancy activities'],
),

Article(
  id: 'baby5',
  title: 'Music and baby brain development',
  imageUrl: 'assets/images/baby5.jpeg',
  category: 'Baby',
  content: 'Music can positively affect fetal brain development and mood. Babies respond to music by moving and showing heart rate changes.\n\nTips:\n- Choose soft, soothing melodies\n- Avoid loud music\n- Make it a relaxing moment\n\nClassical and lullaby-style tunes are ideal.',
  relatedArticles: ['Baby learning in womb', 'Soothing sounds for baby', 'Bonding with baby'],
),

Article(
  id: 'baby6',
  title: 'Baby kicks and what they mean',
  imageUrl: 'assets/images/baby6.jpeg',
  category: 'Baby',
  content: 'Feeling baby kicks is a sign of healthy development and a special bonding moment.\n\nNormal Patterns:\n- Start around 18–25 weeks\n- Most active in the evening\n- Kicks increase with baby’s growth\n\nTrack movement daily and inform your doctor of any major changes.',
  relatedArticles: ['Fetal movement guide', 'Pregnancy milestones', 'When to contact your doctor'],
),

Article(
  id: 'baby7',
  title: 'Fun facts about your baby in the womb',
  imageUrl: 'assets/images/baby7.jpeg',
  category: 'Baby',
  content: 'Here are some amazing baby facts:\n\n- Babies can hiccup in the womb\n- They start to taste and smell around 14 weeks\n- They may suck their thumb before birth\n- Baby girls are born with all their eggs\n\nThe womb is a busy, fascinating place!',
  relatedArticles: ['Womb development facts', 'Sensory milestones in pregnancy', 'Baby behaviors before birth'],
),

Article(
  id: 'baby8',
  title: 'Mother-baby emotional connection',
  imageUrl: 'assets/images/baby8.jpeg',
  category: 'Baby',
  content: 'Your emotional state can affect your baby. Hormones like cortisol and oxytocin influence fetal development.\n\nTips for positive connection:\n- Practice relaxation and mindfulness\n- Talk positively to your baby\n- Keep a pregnancy journal\n\nEmotional well-being is part of prenatal care.',
  relatedArticles: ['Mental health in pregnancy', 'Bonding techniques', 'Stress and fetal health'],
),

Article(
  id: 'baby9',
  title: 'Partner bonding with the baby',
  imageUrl: 'assets/images/baby9.jpeg',
  category: 'Baby',
  content: 'Partners can bond with the baby before birth, too!\n\nWays to bond:\n- Read or sing to the belly\n- Attend prenatal visits\n- Feel for kicks together\n- Talk to the baby daily\n\nThis helps strengthen family connection early on.',
  relatedArticles: ['Father’s role in pregnancy', 'Bonding tips for partners', 'Prenatal bonding moments'],
),

Article(
  id: 'baby10',
  title: 'Teaching calmness in the womb',
  imageUrl: 'assets/images/baby10.jpeg',
  category: 'Baby',
  content: 'Calm mothers tend to have calmer babies. Your womb environment matters.\n\nPractice:\n- Deep breathing and yoga\n- Positive affirmations\n- Gentle belly rubs\n\nYour mood and energy shape the baby’s emotional development.',
  relatedArticles: ['Mindful pregnancy', 'Prenatal yoga', 'Emotional health and baby'],
),

];
final List<Article> mythsArticles = [
Article(
  id: 'myth1',
  title: 'Myth: You’re eating for two',
  imageUrl: 'assets/images/myth1.jpeg',
  category: 'Pregnancy Myths',
  content: 'Fact: You only need about 340–450 extra calories in the 2nd and 3rd trimesters.\n\nOvereating can increase the risk of gestational diabetes and excess weight gain.\n\nFocus on quality, not quantity.',
  relatedArticles: ['Healthy weight gain', 'Pregnancy nutrition', 'Calorie needs in pregnancy'],
),

Article(
  id: 'myth2',
  title: 'Myth: You can’t exercise during pregnancy',
  imageUrl: 'assets/images/myth2.jpeg',
  category: 'Pregnancy Myths',
  content: 'Fact: Moderate, approved exercise is healthy and encouraged!\n\nBenefits include:\n- Reduced back pain\n- Better sleep\n- Easier labor\n\nAlways consult your doctor before starting or continuing exercise.',
  relatedArticles: ['Safe pregnancy workouts', 'Benefits of staying active', 'Prenatal yoga tips'],
),

Article(
  id: 'myth3',
  title: 'Myth: Heartburn means your baby has lots of hair',
  imageUrl: 'assets/images/myth3.jpeg',
  category: 'Pregnancy Myths',
  content: 'Fact: Heartburn is caused by hormonal and digestive changes, not hair growth.\n\nSome studies show a slight link, but it’s not reliable. Use antacids safely and eat smaller meals.',
  relatedArticles: ['Common pregnancy discomforts', 'Heartburn relief tips', 'Baby development myths'],
),

Article(
  id: 'myth4',
  title: 'Myth: You can predict the baby’s gender by belly shape',
  imageUrl: 'assets/images/myth4.jpeg',
  category: 'Pregnancy Myths',
  content: 'Fact: Belly shape depends on muscle tone, body type, and baby’s position—not gender.\n\nOnly an ultrasound or genetic test can accurately determine sex.',
  relatedArticles: ['Baby gender facts', 'Ultrasound info', 'Old wives’ tales'],
),

Article(
  id: 'myth5',
  title: 'Myth: You must avoid all seafood',
  imageUrl: 'assets/images/myth5.jpeg',
  category: 'Pregnancy Myths',
  content: 'Fact: Many seafood options are safe and healthy during pregnancy.\n\nEat:\n- Salmon\n- Shrimp\n- Tilapia\n\nAvoid:\n- High mercury fish (shark, swordfish)\n\nSeafood is a great source of omega-3s!',
  relatedArticles: ['Pregnancy diet tips', 'Safe seafood list', 'Nutrition for baby’s brain'],
),

Article(
  id: 'myth6',
  title: 'Myth: Pregnant women can’t dye their hair',
  imageUrl: 'assets/images/myth6.jpeg',
  category: 'Pregnancy Myths',
  content: 'Fact: Most hair treatments are considered safe after the first trimester.\n\nUse:\n- Well-ventilated spaces\n- Gentle, ammonia-free products\n\nAlways check with your doctor.',
  relatedArticles: ['Pregnancy-safe beauty', 'Hormonal hair changes', 'Postpartum hair tips'],
),

Article(
  id: 'myth7',
  title: 'Myth: Carrying high or low reveals gender',
  imageUrl: 'assets/images/myth7.jpeg',
  category: 'Pregnancy Myths',
  content: 'Fact: Carrying position is about uterine shape, abdominal muscles, and baby’s position.\n\nGender can’t be accurately predicted this way.',
  relatedArticles: ['Gender myths', 'Body changes in pregnancy', 'Fetal development facts'],
),

Article(
  id: 'myth8',
  title: 'Myth: Spicy food induces labor',
  imageUrl: 'assets/images/myth8.jpeg',
  category: 'Pregnancy Myths',
  content: 'Fact: There’s no scientific proof that spicy foods start labor.\n\nThey may irritate your stomach or cause heartburn but won’t induce contractions.',
  relatedArticles: ['Labor signs', 'Third-trimester tips', 'Foods to avoid late in pregnancy'],
),

Article(
  id: 'myth9',
  title: 'Myth: You can’t take baths while pregnant',
  imageUrl: 'assets/images/myth9.jpeg',
  category: 'Pregnancy Myths',
  content: 'Fact: Warm (not hot) baths are safe and relaxing.\n\nAvoid hot tubs or water above 100°F (37.8°C). Use mild bath products and keep hydration up.',
  relatedArticles: ['Safe pregnancy self-care', 'Relaxation techniques', 'Bathing dos and don’ts'],
),

Article(
  id: 'myth10',
  title: 'Myth: Morning sickness only happens in the morning',
  imageUrl: 'assets/images/myth10.jpeg',
  category: 'Pregnancy Myths',
  content: 'Fact: Nausea can occur at any time of day or night.\n\nTriggers vary and may include:\n- Strong smells\n- Hunger\n- Hormonal shifts\n\nEat small meals, stay hydrated, and ask your doctor if it’s severe.',
  relatedArticles: ['Managing nausea', 'Hyperemesis gravidarum', 'Pregnancy symptom myths'],
),

];
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
// Default to Tools tab
  int selectedToolIndex = 0;

  List<Map<String, dynamic>> pregnancyData = [
  {
  'week': '<1',
  'bumpSize': 'Not visible',
  'fact': 'Fertilization just occurred. No physical bump yet.',
  'babyLength': '0 cm',
  'image': 'assets/images/size1.jpg',
},
{
  'week': '1',
  'bumpSize': 'Not visible',
  'fact': 'Implantation may be happening, but there’s no bump at all.',
  'babyLength': '0.1 cm',
  'image': 'assets/images/size1.jpg',
},
{
  'week': '2',
  'bumpSize': 'Not visible',
  'fact': 'Your body is preparing, but there’s no visible bump.',
  'babyLength': '0.2 cm',
  'image': 'assets/images/size3.jpg',
},
{
  'week': '3',
  'bumpSize': 'Not visible',
  'fact': 'Still no bump. Hormonal changes might begin.',
  'babyLength': '0.3 cm',
  'image': 'assets/images/size4.jpg',
},
{
  'week': '4',
  'bumpSize': 'Not visible',
  'fact': 'You might feel bloated, but your belly hasn’t changed yet.',
  'babyLength': '0.4 cm',
  'image': 'assets/images/size5.jpg',
},
{
  'week': '5',
  'bumpSize': 'Barely noticeable',
  'fact': 'Some bloating or tightness may start. Uterus is expanding.',
  'babyLength': '0.9 cm',
  'image': 'assets/images/size6.jpg',
},
{
  'week': '6',
  'bumpSize': 'Barely noticeable',
  'fact': 'Your uterus is growing, but the bump is still tiny or hidden.',
  'babyLength': '1.6 cm',
  'image': 'assets/images/size7.jpg',
},
{
  'week': '7',
  'bumpSize': 'Very slight',
  'fact': 'Some moms notice a tiny pooch due to bloating and uterus expansion.',
  'babyLength': '2.5 cm',
  'image': 'assets/images/size8.jpg',
},
{
  'week': '8',
  'bumpSize': 'Very slight',
  'fact': 'Bump might begin to round slightly, especially for second pregnancies.',
  'babyLength': '3.1 cm',
  'image': 'assets/images/size9.jpg',
},
{
  'week': '9',
  'bumpSize': 'Small',
  'fact': 'Your bump may look like early weight gain or bloating.',
  'babyLength': '4.0 cm',
  'image': 'assets/images/size10.jpg',
},
{
  'week': '10',
  'bumpSize': 'Small',
  'fact': 'The bump is getting firmer and rounder around your lower abdomen.',
  'babyLength': '5.1 cm',
  'image': 'assets/images/size11.jpg',
},
{
  'week': '11',
  'bumpSize': 'Growing',
  'fact': 'Your uterus is about the size of a grapefruit. The bump becomes more visible.',
  'babyLength': '6.1 cm',
  'image': 'assets/images/size12.jpg',
},
{
  'week': '12',
  'bumpSize': 'Growing',
  'fact': 'You might be switching to looser clothes as your bump becomes noticeable.',
  'babyLength': '7.4 cm',
  'image': 'assets/images/size13.jpg',
},
{
  'week': '13',
  'bumpSize': 'Noticeable',
  'fact': 'Your bump is clearly forming and your waistline is disappearing.',
  'babyLength': '8.5 cm',
  'image': 'assets/images/size14.jpg',
},
{
  'week': '14',
  'bumpSize': 'Noticeable',
  'fact': 'Welcome to the second trimester! Bump is visibly rounding out.',
  'babyLength': '9.5 cm',
  'image': 'assets/images/size15.jpg',
},
{
  'week': '15',
  'bumpSize': 'Medium',
  'fact': 'The bump is clearly visible and steadily growing.',
  'babyLength': '10.1 cm',
  'image': 'assets/images/size16.jpg',
},
{
  'week': '16',
  'bumpSize': 'Medium',
  'fact': 'The bump is clearly visible and steadily growing.',
  'babyLength': '11.6 cm',
  'image': 'assets/images/size17.jpg',
},
{
  'week': '17',
  'bumpSize': 'Medium',
  'fact': 'The bump is clearly visible and steadily growing.',
  'babyLength': '13.0 cm',
  'image': 'assets/images/size18.jpg',
},
{
  'week': '18',
  'bumpSize': 'Medium',
  'fact': 'The bump is clearly visible and steadily growing.',
  'babyLength': '14.2 cm',
  'image': 'assets/images/size19.jpg',
},
{
  'week': '19',
  'bumpSize': 'Medium',
  'fact': 'The bump is clearly visible and steadily growing.',
  'babyLength': '15.3 cm',
  'image': 'assets/images/size20.jpg',
},
{
  'week': '20',
  'bumpSize': 'Growing larger',
  'fact': 'Your belly is expanding upward and outward.',
  'babyLength': '25.6 cm',
  'image': 'assets/images/size21.jpg',
},
{
  'week': '21',
  'bumpSize': 'Growing larger',
  'fact': 'Your belly is expanding upward and outward.',
  'babyLength': '26.7 cm',
  'image': 'assets/images/size22.jpg',
},
{
  'week': '22',
  'bumpSize': 'Growing larger',
  'fact': 'Your belly is expanding upward and outward.',
  'babyLength': '27.8 cm',
  'image': 'assets/images/size23.jpg',
},
{
  'week': '23',
  'bumpSize': 'Growing larger',
  'fact': 'Your belly is expanding upward and outward.',
  'babyLength': '28.9 cm',
  'image': 'assets/images/size24.jpg',
},
{
  'week': '24',
  'bumpSize': 'Growing larger',
  'fact': 'Your belly is expanding upward and outward.',
  'babyLength': '30.0 cm',
  'image': 'assets/images/size25.jpg',
},
{
  'week': '25',
  'bumpSize': 'Large',
  'fact': 'The bump is prominent. Movement may be felt more often.',
  'babyLength': '34.6 cm',
  'image': 'assets/images/size26.jpg',
},
{
  'week': '26',
  'bumpSize': 'Large',
  'fact': 'The bump is prominent. Movement may be felt more often.',
  'babyLength': '35.6 cm',
  'image': 'assets/images/size27.jpg',
},
{
  'week': '27',
  'bumpSize': 'Large',
  'fact': 'The bump is prominent. Movement may be felt more often.',
  'babyLength': '36.6 cm',
  'image': 'assets/images/size28.jpg',
},
{
  'week': '28',
  'bumpSize': 'Large',
  'fact': 'The bump is prominent. Movement may be felt more often.',
  'babyLength': '37.6 cm',
  'image': 'assets/images/size29.jpg',
},
{
  'week': '29',
  'bumpSize': 'Large',
  'fact': 'The bump is prominent. Movement may be felt more often.',
  'babyLength': '38.6 cm',
  'image': 'assets/images/size30.jpg',
},
{
  'week': '30',
  'bumpSize': 'Very large',
  'fact': 'The bump is round and firm. Your posture may begin to change.',
  'babyLength': '39.9 cm',
  'image': 'assets/images/size31.jpg',
},
{
  'week': '31',
  'bumpSize': 'Very large',
  'fact': 'The bump is round and firm. Your posture may begin to change.',
  'babyLength': '41.1 cm',
  'image': 'assets/images/size32.jpg',
},
{
  'week': '32',
  'bumpSize': 'Very large',
  'fact': 'The bump is round and firm. Your posture may begin to change.',
  'babyLength': '42.4 cm',
  'image': 'assets/images/size33.jpg',
},
{
  'week': '33',
  'bumpSize': 'Very large',
  'fact': 'The bump is round and firm. Your posture may begin to change.',
  'babyLength': '43.7 cm',
  'image': 'assets/images/size34.jpg',
},
{
  'week': '34',
  'bumpSize': 'Very large',
  'fact': 'The bump is round and firm. Your posture may begin to change.',
  'babyLength': '45.0 cm',
  'image': 'assets/images/size35.jpg',
},
{
  'week': '35',
  'bumpSize': 'Full term',
  'fact': 'Your bump is at its peak size, baby is getting ready for birth.',
  'babyLength': '46.2 cm',
  'image': 'assets/images/size36.jpg',
},
{
  'week': '36',
  'bumpSize': 'Full term',
  'fact': 'Your bump is at its peak size, baby is getting ready for birth.',
  'babyLength': '47.4 cm',
  'image': 'assets/images/size37.jpg',
},
{
  'week': '37',
  'bumpSize': 'Full term',
  'fact': 'Your bump is at its peak size, baby is getting ready for birth.',
  'babyLength': '48.6 cm',
  'image': 'assets/images/size38.jpg',
},
{
  'week': '38',
  'bumpSize': 'Full term',
  'fact': 'Your bump is at its peak size, baby is getting ready for birth.',
  'babyLength': '49.8 cm',
  'image': 'assets/images/size39.jpg',
},
{
  'week': '39',
  'bumpSize': 'Full term',
  'fact': 'Your bump is at its peak size, baby is getting ready for birth.',
  'babyLength': '50.7 cm',
  'image': 'assets/images/size40.jpg',
},
{
  'week': '40',
  'bumpSize': 'Full term',
  'fact': 'Your bump is at its peak size, baby is getting ready for birth.',
  'babyLength': '51.2 cm',
  'image': 'assets/images/size40.jpg',
}

];


  int selectedWeekIndex = 0;
  TextEditingController appointmentTitleController = TextEditingController();
  TextEditingController hospitalController = TextEditingController();
  TextEditingController doctorController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool setReminder = true;


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
                        Image.asset(
                          selectedData['image'],
                          height: 200,
                          fit: BoxFit.cover,
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