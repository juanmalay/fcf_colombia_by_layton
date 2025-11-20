import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';

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
                    _team("co", "COL"),
                  ],
                ),
              ),
              const Text("VS", style: TextStyle(fontSize: 16)),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _team("ar", "ARG"),
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

  Widget _team(String code, String name) {
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
        Text(name, style: const TextStyle(fontSize: 18)),
      ],
    );
  }
}
