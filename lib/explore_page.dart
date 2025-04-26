// First, let's create the main app structure

// main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const PregnancyApp());
}

class PregnancyApp extends StatelessWidget {
  const PregnancyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pregnancy Guide',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// home_page.dart
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Discover',
          style: TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: const Icon(Icons.person, color: Colors.grey),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: const HomeContent(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.cyan,
        unselectedItemColor: Colors.grey,
        currentIndex: 1,
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
            icon: Icon(Icons.work),
            label: 'Tools',
          ),
        ],
      ),
    );
  }
}

// home_content.dart
class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryHeader('Week by week', true),
          _buildWeekByWeekSection(),
          _buildCategoryHeader('Nutrition', false),
          _buildArticleSection(nutritionArticles),
          _buildCategoryHeader('Body', false),
          _buildArticleSection(bodyArticles),
          _buildCategoryHeader('Baby', false),
          _buildArticleSection(babyArticles),
          _buildCategoryHeader('Common Pregnancy Myths', false),
          _buildArticleSection(mythsArticles),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCategoryHeader(String title, bool hasViewAll) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (hasViewAll)
            Text(
              'See All',
              style: TextStyle(
                fontSize: 16,
                color: Colors.cyan[400],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildWeekByWeekSection() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: weekByWeekArticles.length,
        itemBuilder: (context, index) {
          final article = weekByWeekArticles[index];
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
              width: 180,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(article.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.article, color: Colors.white, size: 16),
                          SizedBox(width: 4),
                          Text(
                            'Articles',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: Text(
                      article.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildArticleSection(List<Article> articles) {
    return SizedBox(
      height: 200,
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
              width: 180,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(article.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.article, color: Colors.white, size: 16),
                          SizedBox(width: 4),
                          Text(
                            'Articles',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: Text(
                      article.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// article_detail_page.dart
class ArticleDetailPage extends StatelessWidget {
  final Article article;

  const ArticleDetailPage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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

// article.dart
class Article {
  final String id;
  final String title;
  final String imageUrl;
  final String category;
  final String content;
  final List<String> relatedArticles;

  Article({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.category,
    required this.content,
    this.relatedArticles = const [],
  });
}

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
  imageUrl: 'assets/images/baby2.jpeg',
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
  imageUrl: 'assets/images/myth1.jpg',
  category: 'Pregnancy Myths',
  content: 'Fact: You only need about 340–450 extra calories in the 2nd and 3rd trimesters.\n\nOvereating can increase the risk of gestational diabetes and excess weight gain.\n\nFocus on quality, not quantity.',
  relatedArticles: ['Healthy weight gain', 'Pregnancy nutrition', 'Calorie needs in pregnancy'],
),

Article(
  id: 'myth2',
  title: 'Myth: You can’t exercise during pregnancy',
  imageUrl: 'assets/images/myth2.jpg',
  category: 'Pregnancy Myths',
  content: 'Fact: Moderate, approved exercise is healthy and encouraged!\n\nBenefits include:\n- Reduced back pain\n- Better sleep\n- Easier labor\n\nAlways consult your doctor before starting or continuing exercise.',
  relatedArticles: ['Safe pregnancy workouts', 'Benefits of staying active', 'Prenatal yoga tips'],
),

Article(
  id: 'myth3',
  title: 'Myth: Heartburn means your baby has lots of hair',
  imageUrl: 'assets/images/myth3.jpg',
  category: 'Pregnancy Myths',
  content: 'Fact: Heartburn is caused by hormonal and digestive changes, not hair growth.\n\nSome studies show a slight link, but it’s not reliable. Use antacids safely and eat smaller meals.',
  relatedArticles: ['Common pregnancy discomforts', 'Heartburn relief tips', 'Baby development myths'],
),

Article(
  id: 'myth4',
  title: 'Myth: You can predict the baby’s gender by belly shape',
  imageUrl: 'assets/images/myth4.jpg',
  category: 'Pregnancy Myths',
  content: 'Fact: Belly shape depends on muscle tone, body type, and baby’s position—not gender.\n\nOnly an ultrasound or genetic test can accurately determine sex.',
  relatedArticles: ['Baby gender facts', 'Ultrasound info', 'Old wives’ tales'],
),

Article(
  id: 'myth5',
  title: 'Myth: You must avoid all seafood',
  imageUrl: 'assets/images/myth5.jpg',
  category: 'Pregnancy Myths',
  content: 'Fact: Many seafood options are safe and healthy during pregnancy.\n\nEat:\n- Salmon\n- Shrimp\n- Tilapia\n\nAvoid:\n- High mercury fish (shark, swordfish)\n\nSeafood is a great source of omega-3s!',
  relatedArticles: ['Pregnancy diet tips', 'Safe seafood list', 'Nutrition for baby’s brain'],
),

Article(
  id: 'myth6',
  title: 'Myth: Pregnant women can’t dye their hair',
  imageUrl: 'assets/images/myth6.jpg',
  category: 'Pregnancy Myths',
  content: 'Fact: Most hair treatments are considered safe after the first trimester.\n\nUse:\n- Well-ventilated spaces\n- Gentle, ammonia-free products\n\nAlways check with your doctor.',
  relatedArticles: ['Pregnancy-safe beauty', 'Hormonal hair changes', 'Postpartum hair tips'],
),

Article(
  id: 'myth7',
  title: 'Myth: Carrying high or low reveals gender',
  imageUrl: 'assets/images/myth7.jpg',
  category: 'Pregnancy Myths',
  content: 'Fact: Carrying position is about uterine shape, abdominal muscles, and baby’s position.\n\nGender can’t be accurately predicted this way.',
  relatedArticles: ['Gender myths', 'Body changes in pregnancy', 'Fetal development facts'],
),

Article(
  id: 'myth8',
  title: 'Myth: Spicy food induces labor',
  imageUrl: 'assets/images/myth8.jpg',
  category: 'Pregnancy Myths',
  content: 'Fact: There’s no scientific proof that spicy foods start labor.\n\nThey may irritate your stomach or cause heartburn but won’t induce contractions.',
  relatedArticles: ['Labor signs', 'Third-trimester tips', 'Foods to avoid late in pregnancy'],
),

Article(
  id: 'myth9',
  title: 'Myth: You can’t take baths while pregnant',
  imageUrl: 'assets/images/myth9.jpg',
  category: 'Pregnancy Myths',
  content: 'Fact: Warm (not hot) baths are safe and relaxing.\n\nAvoid hot tubs or water above 100°F (37.8°C). Use mild bath products and keep hydration up.',
  relatedArticles: ['Safe pregnancy self-care', 'Relaxation techniques', 'Bathing dos and don’ts'],
),

Article(
  id: 'myth10',
  title: 'Myth: Morning sickness only happens in the morning',
  imageUrl: 'assets/images/myth10.jpg',
  category: 'Pregnancy Myths',
  content: 'Fact: Nausea can occur at any time of day or night.\n\nTriggers vary and may include:\n- Strong smells\n- Hunger\n- Hormonal shifts\n\nEat small meals, stay hydrated, and ask your doctor if it’s severe.',
  relatedArticles: ['Managing nausea', 'Hyperemesis gravidarum', 'Pregnancy symptom myths'],
),

];
