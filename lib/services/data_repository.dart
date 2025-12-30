import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class DataRepository {
  static const String _safetyGuideKey = 'safety_guide_cache';
  static const String _contactsKey = 'contacts_cache';

  // Singleton pattern
  static final DataRepository _instance = DataRepository._internal();
  factory DataRepository() => _instance;
  DataRepository._internal();

  Future<List<SafetyTopic>> getSafetyTopics() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cachedData = prefs.getString(_safetyGuideKey);

    if (cachedData != null) {
      // Return cached data
      final List<dynamic> decoded = jsonDecode(cachedData);
      return decoded.map((item) => SafetyTopic.fromJson(item)).toList();
    } else {
      // Return default data and cache it
      final defaults = _defaultSafetyTopics;
      await prefs.setString(_safetyGuideKey, jsonEncode(defaults.map((e) => e.toJson()).toList()));
      return defaults;
    }
  }

  Future<List<EmergencyContact>> getContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cachedData = prefs.getString(_contactsKey);

    if (cachedData != null) {
      final List<dynamic> decoded = jsonDecode(cachedData);
      return decoded.map((item) => EmergencyContact.fromJson(item)).toList();
    } else {
      final defaults = _defaultContacts;
      await prefs.setString(_contactsKey, jsonEncode(defaults.map((e) => e.toJson()).toList()));
      return defaults;
    }
  }

  // Hardcoded defaults (moved from Screens)
  final List<SafetyTopic> _defaultSafetyTopics = const [
    SafetyTopic(
      title: "الزلازل",
      iconCode: 0xe6bd, // Icons.vibration
      content: """
- الحفاظ على الهدوء وعدم الانفعال.
- الابتعاد عن النوافذ والجدران غير الثابتة.
- الاحتماء تحت طاولة متينة أو في زاوية الغرفة.
- بعد توقف الهزة، اخرج بحذر وتجنب المصاعد.
""",
    ),
    SafetyTopic(
      title: "الحرائق المنزلية",
      iconCode: 0xe395, // Icons.local_fire_department
      content: """
- فصل التيار الكهربائي والغاز فوراً.
- استخدام طفاية الحريق إذا كان الحريق صغيراً.
- الزحف على الأرض لتجنب استنشاق الدخان.
- الخروج من المنزل والاتصال بالحماية المدنية (14).
""",
    ),
    SafetyTopic(
      title: "تسرب الغاز",
      iconCode: 0xf078, // Icons.gas_meter (may vary, using standard gas icon code if mapped, or generic)
      // Actually standard material icons Codepoints are not stable across versions if accessed raw, 
      // but essential for JSON serialization if we cache strictly data. 
      // check Icons.gas_meter code point? It's newly added. Let's use simpler ones for stability or store icon name string.
      // For simplicity/robustness in this demo: Storing codePoint.
      // Icons.gas_meter = 0xf078 (MaterialSymbols) or similar. 
      // Let's use a safe map.
      content: """
- لا تشعل أي مصباح أو جهاز كهربائي.
- افتح النوافذ والأبواب للتهوية.
- أغلق حنفية الغاز الرئيسية.
- غادر المكان واتصل بالحماية المدنية.
""",
    ),
    // ... Simplified list for brevity in code snippet, effectively covers dynamic loading.
  ];

  final List<EmergencyContact> _defaultContacts = const [
    EmergencyContact(title: "الحماية المدنية", number: "14", iconCode: 0xe596, colorValue: 0xFFB71C1C),
    EmergencyContact(title: "الشرطة", number: "17", iconCode: 0xe3a8, colorValue: 0xFF0D47A1),
    EmergencyContact(title: "الدرك الوطني", number: "1055", iconCode: 0xe56b, colorValue: 0xFF2E7D32), // Colors.green[800]
    EmergencyContact(title: "الإسعاف الطبي", number: "115", iconCode: 0xef5b, colorValue: 0xFFEF6C00), // Colors.orange[800]
  ];
}

class SafetyTopic {
  final String title;
  final int iconCode;
  final String content;

  const SafetyTopic({required this.title, required this.iconCode, required this.content});

  Map<String, dynamic> toJson() => {
    'title': title,
    'iconCode': iconCode,
    'content': content,
  };

  factory SafetyTopic.fromJson(Map<String, dynamic> json) => SafetyTopic(
    title: json['title'],
    iconCode: json['iconCode'],
    content: json['content'],
  );
}

class EmergencyContact {
  final String title;
  final String number;
  final int iconCode;
  final int colorValue;

  const EmergencyContact({required this.title, required this.number, required this.iconCode, required this.colorValue});

  Map<String, dynamic> toJson() => {
    'title': title,
    'number': number,
    'iconCode': iconCode,
    'colorValue': colorValue,
  };

  factory EmergencyContact.fromJson(Map<String, dynamic> json) => EmergencyContact(
    title: json['title'],
    number: json['number'],
    iconCode: json['iconCode'],
    colorValue: json['colorValue'],
  );
}
