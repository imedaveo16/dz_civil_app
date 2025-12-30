import 'package:flutter/material.dart';
import 'package:civil_defense_app/services/data_repository.dart';

class SafetyGuideScreen extends StatelessWidget {
  const SafetyGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("دليل السلامة (Offline)"), // Safety Guide
      ),
      body: FutureBuilder<List<SafetyTopic>>(
        future: DataRepository().getSafetyTopics(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
             return Center(child: Text('خطأ في تحميل البيانات: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('لا توجد بيانات متاحة'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final topic = snapshot.data![index];
              return SafetyTopicCard(
                title: topic.title,
                icon: IconData(topic.iconCode, fontFamily: 'MaterialIcons'),
                content: topic.content,
              );
            },
          );
        },
      ),
    );
  }
}

class SafetyTopicCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String content;

  const SafetyTopicCard({
    super.key,
    required this.title,
    required this.icon,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF0D47A1).withOpacity(0.1), // Blue tint
          child: Icon(icon, color: const Color(0xFF0D47A1)), // Civil Defense Blue
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFFB71C1C), // Civil Defense Red
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              content,
              style: const TextStyle(fontSize: 16, height: 1.5),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
