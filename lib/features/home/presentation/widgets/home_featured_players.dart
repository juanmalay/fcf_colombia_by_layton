import 'package:flutter/material.dart';

class HomeFeaturedPlayers extends StatelessWidget {
  const HomeFeaturedPlayers({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Jugadores Destacados",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.redAccent,
          ),
        ),
        SizedBox(height: 20),

        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            _PlayerCard(name: "Luis Díaz", number: 7),
            _PlayerCard(name: "James Rodríguez", number: 10),
            _PlayerCard(name: "D. Muñoz", number: 2),
            _PlayerCard(name: "Borré", number: 19),
          ],
        ),
      ],
    );
  }
}

class _PlayerCard extends StatelessWidget {
  final String name;
  final int number;

  const _PlayerCard({required this.name, required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 32,
            backgroundColor: Colors.white24,
            child: Icon(Icons.person, size: 38),
          ),
          const SizedBox(height: 12),
          Text(name, textAlign: TextAlign.center),
          const SizedBox(height: 4),
          Text("#$number", style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
