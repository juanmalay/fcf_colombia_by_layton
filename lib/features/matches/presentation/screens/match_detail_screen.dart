import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/design_system/app_colors.dart';
import '../../../../core/design_system/app_spacing.dart';
import '../../../../core/design_system/app_text_styles.dart';
import '../../domain/entities/match.dart' as match_entity;
import '../providers/match_providers.dart';
import '../../../favorites/presentation/providers/favorites_providers.dart';

/// Pantalla de detalle de un partido
class MatchDetailScreen extends ConsumerWidget {
  final String matchId;

  const MatchDetailScreen({Key? key, required this.matchId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Partido'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
      ),
      backgroundColor: AppColors.surface,
      body: Center(
        child: Text('Match Detail Screen para $matchId'),
      ),
    );
  }
}

/// Contenido principal del detalle
class _MatchDetailContent extends StatelessWidget {
  final match_entity.Match match;

  const _MatchDetailContent({required this.match});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(match.tournament),
        TabBarView(
          children: [
            Center(child: Text('Estadísticas no disponibles')), // Estadísticas
            Center(child: Text('Eventos no disponibles')), // Eventos
          ],
        ),
      ],
    );
  }
}

/// Header Hero Premium
class _MatchHeaderHero extends ConsumerWidget {
  final match_entity.Match match;

  const _MatchHeaderHero({required this.match});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(match.tournament, style: AppTextStyles.h3),
        IconButton(
          icon: Icon(
            Icons.favorite_border,
            color: Colors.grey,
          ),
          onPressed: () {
            ref.read(favoritesProvider.notifier).toggle('match:${match.id}');
          },
        ),
      ],
    );
  }
}

/// Display de Score en Hero
class _HeroScoreDisplay extends StatelessWidget {
  final match_entity.Match match;

  const _HeroScoreDisplay({required this.match});

  @override
  Widget build(BuildContext context) {
    final isFinished = match.status == match_entity.MatchStatus.finished;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isFinished) ...[
          Text(
            '${match.homeScore}',
            style: AppTextStyles.h1.copyWith(
              color: AppColors.accent,
              fontSize: 52,
              fontWeight: FontWeight.w800,
              height: 1.0,
            ),
          ),
          Text(
            '-',
            style: AppTextStyles.h2.copyWith(
              color: AppColors.textTertiary,
              fontSize: 24,
              height: 1.0,
            ),
          ),
          Text(
            '${match.awayScore}',
            style: AppTextStyles.h1.copyWith(
              color: AppColors.accent,
              fontSize: 52,
              fontWeight: FontWeight.w800,
              height: 1.0,
            ),
          ),
        ] else ...[
          Text(
            'VS',
            style: AppTextStyles.h1.copyWith(
              color: AppColors.primary,
              fontSize: 36,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ],
    );
  }
}

/// Card elegante de información
class _InfoCard extends StatelessWidget {
  final match_entity.Match match;

  const _InfoCard({required this.match});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.border,
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0F000000),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _InfoItem(
            icon: Icons.sports_soccer,
            label: 'Torneo',
            value: match.tournament,
            isFirst: true,
          ),
          _InfoItem(
            icon: Icons.location_on_outlined,
            label: 'Estadio',
            value: match.venue,
          ),
          _InfoItem(
            icon: Icons.person_outline,
            label: 'Árbitro',
            value: match.referee,
          ),
          _InfoItem(
            icon: Icons.schedule_outlined,
            label: 'Fecha',
            value: _formatDateTimeFull(match.matchDate),
            isLast: true,
          ),
        ],
      ),
    );
  }

  String _formatDateTimeFull(DateTime dateTime) {
    return DateFormat('d MMMM yyyy, HH:mm').format(dateTime);
  }
}

/// Item de información con icono
class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isFirst;
  final bool isLast;

  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            isFirst ? 16 : 14,
            16,
            isLast ? 16 : 14,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: AppColors.accent,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
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
        if (!isLast)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              color: AppColors.border,
              height: 1,
            ),
          ),
      ],
    );
  }
}

/// Tab: Resumen
class _ResumenTab extends StatelessWidget {
  final match_entity.Match match;

  const _ResumenTab({required this.match});

  @override
  Widget build(BuildContext context) {
    return _DetailListContent(
      icon: Icons.summarize_outlined,
      title: 'Resumen del Partido',
      description: 'Descripción de los eventos principales del partido',
    );
  }
}

/// Tab: Estadísticas
class _EstadisticasTab extends StatelessWidget {
  final match_entity.Match match;

  const _EstadisticasTab({required this.match});

  @override
  Widget build(BuildContext context) {
    if (match.statistics == null || match.statistics!.isEmpty) {
      return const _EmptyState(
        message: 'No hay estadísticas disponibles para este partido.',
      );
    }

    // Renderizar estadísticas reales aquí si existen
    return ListView.builder(
      itemCount: match.statistics!.length,
      itemBuilder: (context, index) {
        final stat = match.statistics![index];
        return ListTile(
          title: Text(stat.name),
          subtitle: Text(stat.value.toString()),
        );
      },
    );
  }
}

/// Tab: Eventos
class _EventosTab extends StatelessWidget {
  final match_entity.Match match;

  const _EventosTab({required this.match});

  @override
  Widget build(BuildContext context) {
    if (match.events == null || match.events!.isEmpty) {
      return const _EmptyState(
        message: 'No hay eventos registrados para este partido.',
      );
    }

    // Renderizar eventos reales aquí si existen
    return ListView.builder(
      itemCount: match.events!.length,
      itemBuilder: (context, index) {
        final event = match.events![index];
        return ListTile(
          title: Text(event.description),
          subtitle: Text(event.time),
        );
      },
    );
  }
}

/// Placeholder elegante para contenido vacío en tabs
class _DetailListContent extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _DetailListContent({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: AppTextStyles.h3.copyWith(
                color: AppColors.textPrimary,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: AppTextStyles.body.copyWith(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget de estado: cargando
class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              strokeWidth: 3,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Cargando detalle del partido...',
            style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

/// Widget de estado: error
class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const _ErrorState({
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.error_outline,
              size: 32,
              color: AppColors.error,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          if (onRetry != null)
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Empty state for tabs
class _EmptyState extends StatelessWidget {
  final String message;

  const _EmptyState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.info_outline,
                color: AppColors.primary,
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
