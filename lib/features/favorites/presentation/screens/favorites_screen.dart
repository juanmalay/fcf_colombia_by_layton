import 'package:flutter/material.dart';
import '../../../../core/widgets/app_scaffold.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: 'FavoritesScreen',
      body: Center(
        child: Text('Aquí irán los FavoritesScreen de Colombia'),
      ),
    );
  }
}