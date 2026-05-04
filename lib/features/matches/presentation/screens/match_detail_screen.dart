import 'package:flutter/material.dart';

class MatchDetailScreen extends StatelessWidget {
  final String matchId;

  const MatchDetailScreen({Key? key, required this.matchId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del partido: $matchId'),
      ),
      body: Center(
        child: Text('Mostrando detalles para el partido con ID: $matchId'),
      ),
    );
  }
}
