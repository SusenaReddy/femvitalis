
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Women\'s Health Insights',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const InsightsPage(),
      debugShowCheckedModeBanner: false,
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
    imageUrl: 'assets/images/pcos3.jpg',
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
    imageUrl: 'assets/images/pcos4.jpg',
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
    imageUrl: 'assets/images/pcos6.jpg',
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
    imageUrl: 'assets/images/pcos10.jpg',
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
    imageUrl: 'assets/images/endo3.jpg',
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
    imageUrl: 'assets/images/endo4.jpg',
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
    imageUrl: 'assets/images/endo5.jpg',
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
    imageUrl: 'assets/images/endo6.jpg',
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
    imageUrl: 'assets/images/endo7.jpg',
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
    imageUrl: 'assets/images/endo10.jpg',
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
    imageUrl: 'assets/images/bc1.jpg',
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
    imageUrl: 'assets/images/bc2.jpg',
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
    imageUrl: 'assets/images/bc4.jpg',
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
    imageUrl: 'assets/images/bc5.jpg',
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
    imageUrl: 'assets/images/bc6.jpg',
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
    imageUrl: 'assets/images/bc7.jpg',
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
    imageUrl: 'assets/images/bc8.jpg',
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
    imageUrl: 'assets/images/bc9.jpg',
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
    imageUrl: 'assets/images/bc10.jpg',
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
    imageUrl: 'assets/images/gen2.jpg',
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
    imageUrl: 'assets/images/gen3.jpg',
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
    imageUrl: 'assets/images/gen4.jpg',
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
    imageUrl: 'assets/images/gen5.jpg',
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
    imageUrl: 'assets/images/gen6.jpg',
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
    imageUrl: 'assets/images/gen8.jpg',
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
    imageUrl: 'assets/images/gen9.jpg',
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