import 'package:flutter/material.dart';

class OfficialFooter extends StatelessWidget {
  const OfficialFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
      ),
      child: const Text(
        "كل الحقوق محفوظة لدى المديرية العامة للحماية المدنية",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          color: Colors.black54,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
