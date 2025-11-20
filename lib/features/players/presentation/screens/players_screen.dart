import 'package:flutter/material.dart';
import '../../../../core/widgets/app_scaffold.dart';

class PlayersScreen extends StatelessWidget {
  const PlayersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: 'Jugadores',
      body: Center(
        child: Text('Aquí irán los Jugadores de Colombia'),
      ),
    );
  }
}
