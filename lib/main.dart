import 'package:flutter/material.dart';
import 'package:narsat/admin_panel.dart';
import 'package:narsat/product_page.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(const NarsatLanding());
}

class NarsatLanding extends StatelessWidget {
  const NarsatLanding({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'نارسات',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFC41E3A),
        // در صورت افزودن فونت Vazir در pubspec می‌تونی از این استفاده کنی:
        // fontFamily: 'Vazir',
      ),

      initialRoute: '/home',
      routes: {
        '/': (context) => LandingPage(),
        '/home': (context) => LandingPage(),
        '/admin': (context) => adminPanel(),
      },
    );
  }
}
/*
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: LandingPage(),
      ),
    );
  }
} */

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _productsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void scrollToKey(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void openWhatsApp() async {
    final phone = '989331741437'; // شماره بدون علامت + — جایگزین کن
    final text = Uri.encodeComponent(
      'سلام روز بخیر، درباره سفارش عمده می‌خوام گفتگو کنم.',
    );
    final url = 'https://wa.me/$phone?text=$text';
    await launchUrlString(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            HeroSection(
              onStart: () => scrollToKey(_productsKey),
              onWhatsApp: openWhatsApp,
            ),
            const SizedBox(height: 40),
            const FeaturesSection(),
            const SizedBox(height: 40),
            ProductsSection(key: _productsKey),
            const SizedBox(height: 40),
            HowItWorksSection(),
            const SizedBox(height: 40),
            AboutSection(),
            const SizedBox(height: 40),
            FooterSection(key: _contactKey, onWhatsApp: openWhatsApp),
          ],
        ),
      ),
    );
  }
}

/* ====== Hero ====== */
class HeroSection extends StatelessWidget {
  final VoidCallback onStart;
  final VoidCallback onWhatsApp;
  const HeroSection({
    required this.onStart,
    required this.onWhatsApp,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 800;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 80,
        horizontal: 24,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFC41E3A), Color(0xFFA2192B)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: isMobile ? _buildColumn(context) : _buildRow(context),
        ),
      ),
    );
  }

  Widget _buildColumn(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        /*  SizedBox(
          height: 90,
          child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
        ),
        const SizedBox(height: 18), */
        const Text(
          'اولین اپلیکیشن خرید و فروش عمده انار در ساوه',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'خرید مستقیم از باغدار، قیمت عمده و ارسال سریع',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
        const SizedBox(height: 20),
        // Wrap(
        //   spacing: 12,
        //   children: [
        //     ElevatedButton(
        //       onPressed: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => ProductPage()),
        //         );
        //       },
        //       style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
        //       child: const Text(
        //         'شروع خرید',
        //         style: TextStyle(color: Color(0xFFC41E3A)),
        //       ),
        //     ),
        //   ],
        // ),
        OutlinedButton(
          onPressed: onWhatsApp,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.white),
          ),
          child: const Text(
            'ارتباط واتساپ',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildRow(BuildContext context) {
    return Row(
      children: [
        // چپ: متن
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'اولین اپلیکیشن خرید و فروش عمده انار در ساوه',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'خرید مستقیم از باغدار، قیمت عمده و ارسال سریع',
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProductPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      'شروع خرید',
                      style: TextStyle(color: Color(0xFFC41E3A)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton(
                    onPressed: onWhatsApp,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                    ),
                    child: const Text(
                      'ارتباط واتساپ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // راست: تصویر نمونه
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset('assets/narsat_logo.png', fit: BoxFit.contain),
          ),
        ),
      ],
    );
  }
}

/* ====== Features ====== */
class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isNarrow = w < 800;
    final items = [
      {
        'icon': Icons.shopping_cart,
        'title': 'قیمت عمده واقعی',
        'desc': 'خرید مستقیم از باغدار',
      },
      {
        'icon': Icons.local_shipping,
        'title': 'ارسال سریع',
        'desc': 'هماهنگی حمل و نقل',
      },
      {
        'icon': Icons.verified,
        'title': 'کیفیت تضمینی',
        'desc': 'بازرسی و امتیازدهی',
      },
      {
        'icon': Icons.headset_mic,
        'title': 'پشتیبانی واتساپ',
        'desc': 'پاسخ سریع به سوالات',
      },
    ];

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1100),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child:
            isNarrow
                ? Column(
                  children:
                      items
                          .map(
                            (it) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: FeatureBox(
                                icon: it['icon'] as IconData,
                                title: it['title'] as String,
                                subtitle: it['desc'] as String,
                              ),
                            ),
                          )
                          .toList(),
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                      items
                          .map(
                            (it) => Expanded(
                              child: FeatureBox(
                                icon: it['icon'] as IconData,
                                title: it['title'] as String,
                                subtitle: it['desc'] as String,
                              ),
                            ),
                          )
                          .toList(),
                ),
      ),
    );
  }
}

class FeatureBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const FeatureBox({
    required this.icon,
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Icon(icon, size: 42, color: const Color(0xFFC41E3A)),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

/* ====== Products (نمونه) ====== */
class ProductsSection extends StatelessWidget {
  const ProductsSection({super.key});

  final List<Map<String, String>> sample = const [
    {
      'title': 'انار صادراتی ساوه',
      'price': '35,000 تومان / کیلو',
      'img': 'assets/images/p1.jpg',
    },
    {
      'title': 'انار آبگیری',
      'price': '18,000 تومان / کیلو',
      'img': 'assets/images/p2.jpg',
    },
    {
      'title': 'انار درجه‌یک',
      'price': '28,000 تومان / کیلو',
      'img': 'assets/images/p3.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final cross = w < 800 ? 1 : 3;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1100),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'نمونه محصولات',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cross,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              itemCount: sample.length,
              itemBuilder: (ctx, i) {
                final it = sample[i];
                return ProductCard(
                  title: it['title']!,
                  price: it['price']!,
                  image: it['img']!,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  const ProductCard({
    required this.image,
    required this.title,
    required this.price,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(price, style: const TextStyle(color: Colors.black54)),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    launchUrlString(
                      'https://wa.me/989123456789?text=${Uri.encodeComponent('سلام، درباره این محصول می‌خواهم صحبت کنم')}',
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC41E3A),
                  ),
                  child: const Text('تماس / واتساپ'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* ====== How it works ====== */
class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      {'title': 'دیدن محصولات', 'desc': 'مشاهده‌ی نمونه و مشخصات'},
      {'title': 'تماس/واتساپ', 'desc': 'همکاری مستقیم با فروشنده'},
      {'title': 'تحویل', 'desc': 'هماهنگی ارسال و تحویل سفارش'},
    ];

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 900),
      child: Column(
        children: [
          const Text(
            'نحوه کار',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: List.generate(steps.length, (i) {
              final s = steps[i];
              return SizedBox(
                width: 260,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: const Color(0xFFC41E3A),
                          child: Text(
                            '${i + 1}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          s['title']!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          s['desc']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

/* ====== About ====== */
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 900),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: const [
            Text(
              'درباره نارسات',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              'نارسات یک پلتفرم واسط برای خرید و فروش عمده انار است. هدف ما وصل کردن مستقیم باغداران و خریداران عمده با کمترین واسطه و بهترین قیمت است.',
            ),
          ],
        ),
      ),
    );
  }
}

/* ====== Footer ====== */
class FooterSection extends StatelessWidget {
  final VoidCallback onWhatsApp;
  const FooterSection({required this.onWhatsApp, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'نارسات',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'خرید و فروش عمده انار',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: onWhatsApp,
                  icon: const Icon(Icons.phone),
                  label: const Text('تماس واتساپ'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            const Text(
              '© 2025 نارسات — همه حقوق محفوظ است',
              style: TextStyle(color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }
}
