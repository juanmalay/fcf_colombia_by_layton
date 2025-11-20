import 'package:flutter/material.dart';
import '../../../../core/widgets/app_scaffold.dart';

class TournamentsScreen extends StatelessWidget {
  const TournamentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: 'TournamentsScreen',
      body: Center(
        child: Text('Aquí irán los TournamentsScreen de Colombia'),
      ),
    );
  }
}
