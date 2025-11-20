import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';

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
                    _teamScore("co", "3"),
                  ],
                ),
              ),
              const Text("-", style: TextStyle(fontSize: 16)),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _teamScore("ar", "1"),
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

  Widget _teamScore(String code, String score) {
    return Row(
      children: [
        SizedBox(
          width: 28,
          height: 20,
          child: FittedBox(
            fit: BoxFit.cover,
            child: CountryFlag.fromCountryCode(code),
          ),
        ),
        const SizedBox(width: 8),
        Text(score, style: const TextStyle(fontSize: 20)),
      ],
    );
  }
}
