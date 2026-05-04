import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../favorites/presentation/providers/favorites_providers.dart';
import '../../domain/entities/team.dart';
import '../providers/team_providers.dart';
import '../../../../core/design_system/app_colors.dart';
import '../../../../core/design_system/app_text_styles.dart';

/// Pantalla de detalle de una selección nacional
class TeamDetailScreen extends ConsumerWidget {
  final String teamId;

  const TeamDetailScreen({
    Key? key,
    required this.teamId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamState = ref.watch(teamDetailProvider(teamId));
    final favorites = ref.watch(favoritesProvider);
    final favoriteId = 'team:$teamId';
    final isFavorite = favorites.contains(favoriteId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Selección'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        actions: [
          IconButton(
            tooltip: isFavorite ? 'Quitar de favoritos' : 'Agregar a favoritos',
            onPressed: () => ref.read(favoritesProvider.notifier).toggle(favoriteId),
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? AppColors.error : AppColors.textPrimary,
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.surface,
      body: teamState.when(
        loading: () => const _LoadingState(),
        error: (error, stackTrace) => _ErrorState(
          message: 'Error cargando detalle de selección',
          onRetry: () => ref.refresh(teamDetailProvider(teamId)),
        ),
        data: (team) => team == null
            ? _ErrorState(
                message: 'Selección no encontrada',
                onRetry: () => ref.refresh(teamDetailProvider(teamId)),
              )
            : _TeamDetailContent(team: team),
      ),
    );
  }
}

/// Contenido principal del detalle
class _TeamDetailContent extends StatelessWidget {
  final Team team;

  const _TeamDetailContent({
    Key? key,
    required this.team,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header con logo
          _TeamHeaderHero(team: team),
          const SizedBox(height: 24),
          // Info del equipo
          _TeamInfoSection(team: team),
          const SizedBox(height: 16),
          const _KitHistoryPlaceholderSection(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _KitHistoryPlaceholderSection extends StatelessWidget {
  const _KitHistoryPlaceholderSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.border,
            width: 0.8,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Historial de camisetas',
              style: AppTextStyles.h3,
            ),
            const SizedBox(height: 8),
            Text(
              'Próximamente disponible en esta sección.',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Header del equipo con logo
class _TeamHeaderHero extends StatelessWidget {
  final Team team;

  const _TeamHeaderHero({
    Key? key,
    required this.team,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logoUrl = team.logoUrl;

    return Container(
      width: double.infinity,
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        children: [
          // Logo
          if (logoUrl != null && logoUrl.isNotEmpty)
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.border,
                  width: 1,
                ),
              ),
              child: Image.network(
                logoUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(
                      Icons.sports_soccer,
                      color: AppColors.primary,
                      size: 60,
                    ),
                  );
                },
              ),
            )
          else
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.border,
                  width: 1,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.sports_soccer,
                  color: AppColors.primary,
                  size: 60,
                ),
              ),
            ),
          const SizedBox(height: 24),
          // Nombre
          Text(
            team.name,
            style: AppTextStyles.h2.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          // País
          Text(
            team.country,
            style: AppTextStyles.body.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          // Badge con código corto
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.accent.withOpacity(0.3),
                width: 0.8,
              ),
            ),
            child: Text(
              team.shortName,
              style: AppTextStyles.label.copyWith(
                color: AppColors.accent,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Sección de información del equipo
class _TeamInfoSection extends StatelessWidget {
  final Team team;

  const _TeamInfoSection({
    Key? key,
    required this.team,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stadium = team.stadium;
    final coach = team.coach;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.border,
            width: 0.8,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0x0F000000),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Estadio
            if (stadium != null && stadium.isNotEmpty)
              _InfoItem(
                icon: Icons.stadium,
                label: 'Estadio',
                value: stadium,
                isFirst: true,
              ),
            // Entrenador
            if (coach != null && coach.isNotEmpty)
              _InfoItem(
                icon: Icons.person,
                label: 'Entrenador',
                value: coach,
                isFirst: stadium == null || stadium.isEmpty,
              ),
          ],
        ),
      ),
    );
  }
}

/// Item de información
class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isFirst;

  const _InfoItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
    this.isFirst = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isFirst)
          Divider(
            height: 1,
            color: AppColors.border,
            indent: 16,
            endIndent: 16,
          ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Widget de carga
class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.accent,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Cargando detalles...'),
        ],
      ),
    );
  }
}

/// Widget de error
class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({
    Key? key,
    required this.message,
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.error.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Icon(
                Icons.error_outline,
                color: AppColors.error,
                size: 40,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(message),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }
}
