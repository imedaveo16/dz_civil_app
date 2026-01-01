import 'package:flutter/material.dart';
import 'package:enqidhni/screens/map_screen.dart';
import 'package:enqidhni/screens/contacts_screen.dart';
import 'package:enqidhni/screens/login_screen.dart';
import 'package:enqidhni/screens/safety_guide_screen.dart';
import 'package:enqidhni/screens/alerts_screen.dart';
import 'package:enqidhni/screens/report_screen.dart';
import 'package:enqidhni/widgets/official_header.dart';
import 'package:enqidhni/widgets/official_footer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OfficialHeader(),
      bottomNavigationBar: const OfficialFooter(), // Using footer as a bottom bar or overlay
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5), // Light Grey background
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Official Logo
            Image.asset(
              'assets/images/civil_defense_logo_dz.png',
              height: 120,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            // Incident Reporting Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "الإبلاغ عن بلاغ الجديد:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            _buildIncidentGrid(context),
            const SizedBox(height: 20),
            const Divider(height: 1),
            const SizedBox(height: 20),
            // Quick Access Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "الوصول السريع:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _buildQuickAccessGrid(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIncidentGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildIncidentButton(
            context,
            title: "إسعاف وإجلاء",
            icon: Icons.ambulance_rounded,
            color: Colors.redAccent,
            onTap: () => _navigateToReport(context, "إسعاف وإجلاء"),
          ),
          _buildIncidentButton(
            context,
            title: "حرائق وانفجارات",
            icon: Icons.local_fire_department,
            color: Colors.orange,
            onTap: () => _navigateToReport(context, "حرائق وانفجارات"),
          ),
          _buildIncidentButton(
            context,
            title: "أنقاذ",
            icon: Icons.life_saver_rounded,
            color: Colors.blue,
            onTap: () => _navigateToReport(context, "إنقاذ"),
          ),
        ],
      ),
    );
  }

  void _navigateToReport(BuildContext context, String type) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReportScreen(incidentType: type),
      ),
    );
  }

  Widget _buildIncidentButton(BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    final size = MediaQuery.of(context).size.width / 3.5;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _buildFeatureCard(
          context,
          title: "خريطة الطوارئ",
          icon: Icons.map_outlined,
          color: const Color(0xFF1A237E),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MapScreen())),
        ),
        _buildFeatureCard(
          context,
          title: "أرقام الطوارئ",
          icon: Icons.phone_android,
          color: Colors.green,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactsScreen())),
        ),
        _buildFeatureCard(
          context,
          title: "دليل السلامة",
          icon: Icons.menu_book,
          color: Colors.orange,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SafetyGuideScreen())),
        ),
         _buildFeatureCard(
          context,
          title: "التنبيهات",
          icon: Icons.notifications_active_outlined,
          color: Colors.red,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AlertsScreen())),
        ),
         _buildFeatureCard(
          context,
          title: "حسابي",
          icon: Icons.person_outline,
          color: Colors.grey,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
        ),
      ],
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
        elevation: 2,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

