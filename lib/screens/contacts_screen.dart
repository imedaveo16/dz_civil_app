import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:enqidhni/services/data_repository.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (!await launchUrl(launchUri)) {
      throw Exception('Could not launch $launchUri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("أرقام الطوارئ (Offline)"), // Emergency Contacts
      ),
      body: FutureBuilder<List<EmergencyContact>>(
        future: DataRepository().getContacts(),
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
              final contact = snapshot.data![index];
              return _buildContactCard(
                context,
                title: contact.title,
                number: contact.number,
                icon: IconData(contact.iconCode, fontFamily: 'MaterialIcons'),
                color: Color(contact.colorValue),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildContactCard(BuildContext context, {
    required String title,
    required String number,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          number,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.phone, size: 30),
          color: Colors.green,
          onPressed: () => _makePhoneCall(number),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        onTap: () => _makePhoneCall(number),
      ),
    );
  }
}
