import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/app_colors.dart';
import '../../../../core/design_system/app_spacing.dart';
import '../../../../core/design_system/app_text_styles.dart';

/// Pantalla de favoritos (partidos, jugadores, noticias guardadas)
class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Favoritos'),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            // Tabs
            TabBar(
              indicatorColor: AppColors.accent,
              indicatorWeight: 3,
              labelStyle: AppTextStyles.label,
              tabs: const [
                Tab(text: 'Partidos'),
                Tab(text: 'Jugadores'),
                Tab(text: 'Noticias'),
              ],
            ),
            // Tab Content
            Expanded(
              child: TabBarView(
                children: [
                  // Matches Tab
                  _FavoritesTab(title: 'Partidos favoritos'),
                  // Players Tab
                  _FavoritesTab(title: 'Jugadores favoritos'),
                  // News Tab
                  _FavoritesTab(title: 'Noticias guardadas'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoritesTab extends StatelessWidget {
  final String title;

  const _FavoritesTab({required this.title});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.md),
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
          color: AppColors.accent.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.accent.withValues(alpha: 0.5)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Elemento $title ${index + 1}',
                      style: AppTextStyles.h3,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Guardado recientemente',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.favorite,
                color: AppColors.accent,
                size: 24,
              ),
            ],
          ),
        );
      },
    );
  }
}