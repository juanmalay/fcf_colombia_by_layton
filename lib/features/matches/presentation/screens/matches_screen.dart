import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/app_colors.dart';
import '../../../../core/design_system/app_spacing.dart';
import '../../../../core/design_system/app_text_styles.dart';
import '../../domain/entities/match.dart' as match_entity;
import '../providers/match_providers.dart';
import '../widgets/match_card.dart';

/// Pantalla principal de partidos
/// Muestra partidos próximos y resultados recientes desde el backend
class MatchesScreen extends ConsumerWidget {
  const MatchesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Partidos'),
        centerTitle: true,
        elevation: 0,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            // Tabs
            TabBar(
              indicatorColor: AppColors.accent,
              indicatorWeight: 3,
              labelStyle: AppTextStyles.label,
              tabs: const [
                Tab(text: 'Próximos'),
                Tab(text: 'Resultados'),
              ],
            ),
            // Tab Content
            Expanded(
              child: TabBarView(
                children: [
                  // Upcoming Tab
                  _UpcomingTab(onMatchTap: (match) {
                    context.push('/matches/${match.id}');
                  }),
                  // Results Tab
                  _ResultsTab(onMatchTap: (match) {
                    context.push('/matches/${match.id}');
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Tab de partidos próximos
class _UpcomingTab extends ConsumerWidget {
  final Function(match_entity.Match) onMatchTap;

  const _UpcomingTab({required this.onMatchTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upcomingState = ref.watch(upcomingMatchesProvider);

    return upcomingState.when(
      loading: () => const _LoadingState(),
      error: (error, stackTrace) => _ErrorState(
        message: 'Error cargando partidos próximos',
        onRetry: () => ref.refresh(upcomingMatchesProvider),
      ),
      data: (matches) => matches.isEmpty
          ? _EmptyState(
              message: 'No hay partidos próximos en este momento',
            )
          : RefreshIndicator(
              onRefresh: () async {
                await ref.read(upcomingMatchesProvider.notifier).refresh();
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: matches.length,
                itemBuilder: (context, index) {
                  final match = matches[index];
                  return MatchCard(
                    match: match,
                    onTap: () => onMatchTap(match),
                    showVenue: true,
                  );
                },
              ),
            ),
    );
  }
}

/// Tab de resultados recientes
class _ResultsTab extends ConsumerWidget {
  final Function(match_entity.Match) onMatchTap;

  const _ResultsTab({required this.onMatchTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentState = ref.watch(recentMatchesProvider);

    return recentState.when(
      loading: () => const _LoadingState(),
      error: (error, stackTrace) => _ErrorState(
        message: 'Error cargando resultados',
        onRetry: () => ref.refresh(recentMatchesProvider),
      ),
      data: (matches) => matches.isEmpty
          ? _EmptyState(
              message: 'No hay resultados disponibles',
            )
          : RefreshIndicator(
              onRefresh: () async {
                await ref.read(recentMatchesProvider.notifier).refresh();
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: matches.length,
                itemBuilder: (context, index) {
                  final match = matches[index];
                  return MatchCard(
                    match: match,
                    onTap: () => onMatchTap(match),
                  );
                },
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
          const SizedBox(height: AppSpacing.md),
          Text(
            'Cargando partidos...',
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
          Icon(
            Icons.error_outline,
            size: 60,
            color: AppColors.error,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            message,
            style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          if (onRetry != null)
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
            ),
        ],
      ),
    );
  }
}

/// Widget de estado: vacío
class _EmptyState extends StatelessWidget {
  final String message;

  const _EmptyState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sports_soccer,
            size: 60,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            message,
            style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// CÓDIGO ANTIGUO PRESERVADO
// ============================================================================
// Comentario preservado pero sin usar */
