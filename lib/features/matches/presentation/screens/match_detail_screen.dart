import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/design_system/app_colors.dart';
import '../../../../core/design_system/app_spacing.dart';
import '../../../../core/design_system/app_text_styles.dart';
import '../../domain/entities/match.dart' as match_entity;
import '../providers/match_providers.dart';

/// Pantalla de detalle de un partido
class MatchDetailScreen extends ConsumerWidget {
  final String matchId;

  const MatchDetailScreen({
    Key? key,
    required this.matchId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchState = ref.watch(matchDetailProvider(matchId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Partido'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
      ),
      backgroundColor: AppColors.surface,
      body: matchState.when(
        loading: () => const _LoadingState(),
        error: (error, stackTrace) => _ErrorState(
          message: 'Error cargando detalle del partido',
          onRetry: () => ref.refresh(matchDetailProvider(matchId)),
        ),
        data: (match) => match == null
            ? _ErrorState(
                message: 'Partido no encontrado',
                onRetry: () => ref.refresh(matchDetailProvider(matchId)),
              )
            : _MatchDetailContent(match: match),
      ),
    );
  }
}

/// Contenido principal del detalle
class _MatchDetailContent extends StatefulWidget {
  final match_entity.Match match;

  const _MatchDetailContent({required this.match});

  @override
  State<_MatchDetailContent> createState() => _MatchDetailContentState();
}

class _MatchDetailContentState extends State<_MatchDetailContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final match = widget.match;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Header Hero Premium
          _MatchHeaderHero(match: match),

          // Info Card Elegante
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: _InfoCard(match: match),
          ),

          // Tabs de información adicional (solo si es finalizado)
          if (match.status == match_entity.MatchStatus.finished) ...[
            Container(
              color: AppColors.background,
              child: TabBar(
                controller: _tabController,
                indicatorColor: AppColors.accent,
                indicatorWeight: 2.5,
                labelStyle: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                unselectedLabelStyle: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
                labelColor: AppColors.textPrimary,
                unselectedLabelColor: AppColors.textSecondary,
                tabs: const [
                  Tab(text: 'Resumen'),
                  Tab(text: 'Estadísticas'),
                  Tab(text: 'Eventos'),
                ],
              ),
            ),
            SizedBox(
              height: 320,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _ResumenTab(match: match),
                  _EstadisticasTab(match: match),
                  _EventosTab(match: match),
                ],
              ),
            ),
          ] else
            // Info adicional si no es finalizado
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Los detalles del partido estarán disponibles una vez finalice.',
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Header Hero Premium
class _MatchHeaderHero extends StatelessWidget {
  final match_entity.Match match;

  const _MatchHeaderHero({required this.match});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
      child: Column(
        children: [
          // Torneo Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.accent.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Text(
              match.tournament,
              style: AppTextStyles.body.copyWith(
                color: AppColors.accent,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Equipos y Score Grande
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Equipo Local
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      '/teams/${match.homeTeam.id}',
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        match.homeTeam.name,
                        style: AppTextStyles.h2.copyWith(
                          color: AppColors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),

              // Score Central
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _HeroScoreDisplay(match: match),
              ),

              // Equipo Visitante
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      '/teams/${match.awayTeam.id}',
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        match.awayTeam.name,
                        style: AppTextStyles.h2.copyWith(
                          color: AppColors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Status Badge (si no es finalizado)
          if (match.status != match_entity.MatchStatus.finished) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: _statusBgColor(match.status),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _statusTextColor(match.status).withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Text(
                match.status.toDisplayString().toUpperCase(),
                style: AppTextStyles.body.copyWith(
                  color: _statusTextColor(match.status),
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _statusBgColor(match_entity.MatchStatus status) {
    return switch (status) {
      match_entity.MatchStatus.upcoming =>
        AppColors.primary.withValues(alpha: 0.08),
      match_entity.MatchStatus.inProgress =>
        AppColors.accent.withValues(alpha: 0.12),
      match_entity.MatchStatus.finished => AppColors.gray100,
      match_entity.MatchStatus.postponed =>
        AppColors.error.withValues(alpha: 0.08),
    };
  }

  Color _statusTextColor(match_entity.MatchStatus status) {
    return switch (status) {
      match_entity.MatchStatus.upcoming => AppColors.primary,
      match_entity.MatchStatus.inProgress => AppColors.accent,
      match_entity.MatchStatus.finished => AppColors.textSecondary,
      match_entity.MatchStatus.postponed => AppColors.error,
    };
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
    return _PlaceholderTabContent(
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
    return _PlaceholderTabContent(
      icon: Icons.bar_chart_outlined,
      title: 'Estadísticas',
      description: 'Posesión, tiros, faltas y más estadísticas del partido',
    );
  }
}

/// Tab: Eventos
class _EventosTab extends StatelessWidget {
  final match_entity.Match match;

  const _EventosTab({required this.match});

  @override
  Widget build(BuildContext context) {
    return _PlaceholderTabContent(
      icon: Icons.event_note_outlined,
      title: 'Eventos',
      description: 'Goles, tarjetas y eventos importantes del partido',
    );
  }
}

/// Placeholder elegante para contenido vacío en tabs
class _PlaceholderTabContent extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _PlaceholderTabContent({
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
