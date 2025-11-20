import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';

class MatchCard extends StatelessWidget {
  final String homeTeamCode;
  final String homeTeamName;
  final String awayTeamCode;
  final String awayTeamName;
  final int? homeScore;
  final int? awayScore;
  final String? date;
  final String? hour;
  final bool isNext;

  const MatchCard({
    super.key,
    required this.homeTeamCode,
    required this.homeTeamName,
    required this.awayTeamCode,
    required this.awayTeamName,
    this.homeScore,
    this.awayScore,
    this.date,
    this.hour,
    this.isNext = false,
  });

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
          isNext
              ? const Text(
                  "Próximo Partido",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )
              : const Text(
                  "Resultado",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(child: _team(homeTeamCode, homeTeamName)),
              _centerText(),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: _team(awayTeamCode, awayTeamName),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          if (isNext)
            Text("$date - $hour", style: const TextStyle(color: Colors.white70))
          else
            Text("Finalizado", style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _team(String code, String name) {
    return Row(
      mainAxisSize: MainAxisSize.min,
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

  Widget _centerText() {
    if (homeScore != null && awayScore != null) {
      return Text(
        "$homeScore - $awayScore",
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      );
    } else {
      return const Text(
        "VS",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      );
    }
  }
}
