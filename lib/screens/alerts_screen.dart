import 'package:flutter/material.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تنبيهات الطوارئ"), // Emergency Alerts
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          AlertCard(
            title: "تحذير: أمطار غزيرة",
            message: "يرجى توخي الحذر والابتعاد عن مجاري الأودية والسيول.",
            timestamp: "منذ 15 دقيقة",
            severity: AlertSeverity.high,
          ),
          AlertCard(
            title: "إشعار: موجة حر",
            message: "تجنب الخروج في أوقات الذروة واشرب كميات كافية من الماء.",
            timestamp: "منذ 2 ساعة",
            severity: AlertSeverity.medium,
          ),
          AlertCard(
            title: "تحديث: الطرق المغلقة",
            message: "تم إعادة فتح الطريق الوطني رقم 5.",
            timestamp: "منذ 5 ساعات",
            severity: AlertSeverity.low,
          ),
        ],
      ),
    );
  }
}

enum AlertSeverity { high, medium, low }

class AlertCard extends StatelessWidget {
  final String title;
  final String message;
  final String timestamp;
  final AlertSeverity severity;

  const AlertCard({
    super.key,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.severity,
  });

  Color _getSeverityColor() {
    switch (severity) {
      case AlertSeverity.high:
        return Colors.red;
      case AlertSeverity.medium:
        return Colors.orange;
      case AlertSeverity.low:
        return Colors.blue;
    }
  }

  IconData _getSeverityIcon() {
    switch (severity) {
      case AlertSeverity.high:
        return Icons.warning;
      case AlertSeverity.medium:
        return Icons.info;
      case AlertSeverity.low:
        return Icons.check_circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: _getSeverityColor(), width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(_getSeverityIcon(), color: _getSeverityColor()),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _getSeverityColor(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            Text(
              timestamp,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
