import 'package:flutter/material.dart';

class HomeNextMatch extends StatelessWidget {
  const HomeNextMatch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF111928),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Próximo Partido",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    _team("🇨🇴", "COL"),
                  ],
                ),
              ),
              const Text("VS", style: TextStyle(fontSize: 16)),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _team("🇦🇷", "ARG"),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text("15 Feb - 7:00 PM"),
        ],
      ),
    );
  }

  Widget _team(String flag, String name) {
    return Row(
      children: [
        Text(flag, style: const TextStyle(fontSize: 28)),
        const SizedBox(width: 8),
        Text(name, style: const TextStyle(fontSize: 18)),
      ],
    );
  }
}
