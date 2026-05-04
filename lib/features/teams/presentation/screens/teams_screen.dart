import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/team.dart';
import '../providers/team_providers.dart';
import '../widgets/team_card.dart';
import '../../../../core/design_system/app_colors.dart';

/// Pantalla de lista de selecciones nacionales
class TeamsScreen extends ConsumerWidget {
  const TeamsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamsState = ref.watch(teamsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecciones Nacionales'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
      ),
      backgroundColor: AppColors.surface,
      body: teamsState.when(
        loading: () => const _LoadingState(),
        error: (error, stackTrace) => _ErrorState(
          message: 'Error cargando selecciones',
          onRetry: () => ref.refresh(teamsProvider),
        ),
        data: (teams) => teams.isEmpty
            ? _ErrorState(
                message: 'No hay selecciones disponibles',
                onRetry: () => ref.refresh(teamsProvider),
              )
            : _TeamsListContent(teams: teams),
      ),
    );
  }
}

/// Contenido principal con lista de equipos
class _TeamsListContent extends StatelessWidget {
  final List<Team> teams;

  const _TeamsListContent({
    Key? key,
    required this.teams,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: teams.length,
      itemBuilder: (context, index) {
        final team = teams[index];
        return TeamCard(
          team: team,
          onTap: () {
            context.push('/teams/${team.id}');
          },
        );
      },
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
          const Text('Cargando selecciones...'),
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
