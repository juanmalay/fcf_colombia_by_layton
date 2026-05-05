import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/app_colors.dart';
import '../../../../core/design_system/app_spacing.dart';
import '../../../../core/design_system/app_text_styles.dart';

/// Hub de exploracion con navegacion real a modulos secundarios.
class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explorar'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _ExploreTile(
            title: 'Selecciones',
            subtitle: 'Listado y detalle de equipos nacionales',
            icon: Icons.groups,
            onTap: () => context.go('/teams'),
          ),
          _ExploreTile(
            title: 'Jugadores',
            subtitle: 'Modulo pendiente de datos y detalle',
            icon: Icons.person,
            onTap: () => context.go('/players'),
          ),
          _ExploreTile(
            title: 'Torneos',
            subtitle: 'Modulo pendiente de standings y calendario',
            icon: Icons.emoji_events,
            onTap: () => context.go('/tournaments'),
          ),
          _ExploreTile(
            title: 'Noticias',
            subtitle: 'Modulo editorial pendiente de integracion',
            icon: Icons.article,
            onTap: () => context.go('/news'),
          ),
          _ExploreTile(
            title: 'Multimedia',
            subtitle: 'Galeria y contenido audiovisual pendiente',
            icon: Icons.photo_library,
            onTap: () => context.go('/multimedia'),
          ),
        ],
      ),
    );
  }
}

class _ExploreTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _ExploreTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.md),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primary),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.h3),
                  const SizedBox(height: AppSpacing.xs),
                  Text(subtitle, style: AppTextStyles.caption),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.textSecondary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
