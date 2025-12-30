import 'package:flutter/material.dart';
import 'package:civil_defense_app/screens/map_screen.dart';
import 'package:civil_defense_app/screens/contacts_screen.dart';
import 'package:civil_defense_app/screens/login_screen.dart';
import 'package:civil_defense_app/screens/safety_guide_screen.dart';
import 'package:civil_defense_app/screens/alerts_screen.dart';
import 'package:civil_defense_app/widgets/algeria_flag.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الدفاع المدني DGPC"),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: AlgeriaFlag(width: 45, height: 30),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shield, size: 100, color: Color(0xFFB71C1C)),
            const SizedBox(height: 20),
            const Text(
              "المساعدة الطارئة",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Implement SOS functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("تم ضغط زر الاستغاثة")),
                );
              },
              icon: const Icon(Icons.phone_in_talk, size: 32),
              label: const Text("نداء استغاثة", style: TextStyle(fontSize: 20)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB71C1C),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: [
                  _buildFeatureCard(
                    context,
                    title: "الإبلاغ عن خطر", // Report Hazard (Map)
                    icon: Icons.map,
                    color: Colors.blue,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MapScreen()),
                      );
                    },
                  ),
                  _buildFeatureCard(
                    context,
                    title: "أرقام الطوارئ", // Emergency Contacts
                    icon: Icons.phone,
                    color: Colors.green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ContactsScreen()),
                      );
                    },
                  ),
                  _buildFeatureCard(
                    context,
                    title: "دليل السلامة", // Safety Guide
                    icon: Icons.menu_book,
                    color: Colors.orange,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SafetyGuideScreen()),
                      );
                    },
                  ),
                  _buildFeatureCard(
                    context,
                    title: "تنبيهات الطوارئ", // Emergency Alerts
                    icon: Icons.notifications_active,
                    color: Colors.redAccent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AlertsScreen()),
                      );
                    },
                  ),
                  _buildFeatureCard(
                    context,
                    title: "حسابي", // My Account (Login)
                    icon: Icons.person,
                    color: Colors.grey,
                    onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
