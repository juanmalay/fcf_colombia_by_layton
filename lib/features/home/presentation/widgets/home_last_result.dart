import 'package:flutter/material.dart';

class HomeLastResult extends StatelessWidget {
  const HomeLastResult({super.key});

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
            "Último Resultado",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    _teamScore("🇨🇴", "3"),
                  ],
                ),
              ),
              const Text("-", style: TextStyle(fontSize: 16)),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _teamScore("🇦🇷", "1"),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text("Amistoso Internacional"),
        ],
      ),
    );
  }

  Widget _teamScore(String flag, String score) {
    return Row(
      children: [
        Text(flag, style: const TextStyle(fontSize: 28)),
        const SizedBox(width: 8),
        Text(score, style: const TextStyle(fontSize: 20)),
      ],
    );
  }
}
