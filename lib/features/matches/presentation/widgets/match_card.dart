import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/match.dart' as match_entity;
import '../../../../core/design_system/app_colors.dart';
import '../../../../core/design_system/app_text_styles.dart';

/// Widget para mostrar un partido en formato card premium
class MatchCard extends StatelessWidget {
  final match_entity.Match match;
  final VoidCallback? onTap;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;
  final bool showVenue;

  const MatchCard({
    Key? key,
    required this.match,
    this.onTap,
    required this.isFavorite,
    this.onFavoriteTap,
    this.showVenue = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
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
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Torneo + Estado
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      match.tournament,
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 12),
                  _StatusBadge(status: match.status),
                ],
              ),
              const SizedBox(height: 14),

              // Equipos y Score Principal
              Row(
                children: [
                  // Equipo Local
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          match.homeTeam.name,
                          style: AppTextStyles.h3.copyWith(
                            color: AppColors.textPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Score o VS
                  _ScoreDisplay(match: match),
                  const SizedBox(width: 12),

                  // Equipo Visitante
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          match.awayTeam.name,
                          style: AppTextStyles.h3.copyWith(
                            color: AppColors.textPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Footer: Fecha y Venue
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatDateTimePremium(match.matchDate),
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (showVenue)
                    Expanded(
                      child: Text(
                        ' · ${match.venue}',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textTertiary,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? AppColors.accent : AppColors.textSecondary,
                    ),
                    onPressed: onFavoriteTap,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDateTimePremium(DateTime dateTime) {
    final now = DateTime.now();
    final difference = dateTime.difference(now);

    if (difference.inDays == 0 && difference.isNegative == false) {
      return 'Hoy · ${DateFormat('HH:mm').format(dateTime)}';
    }

    final dayStr = DateFormat('d').format(dateTime);
    final monthStr = DateFormat('MMM').format(dateTime);
    final timeStr = DateFormat('HH:mm').format(dateTime);

    return '$dayStr $monthStr · $timeStr';
  }
}

/// Badge elegante de estado
class _StatusBadge extends StatelessWidget {
  final match_entity.MatchStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final (bgColor, textColor) = _statusColors(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: textColor.withValues(alpha: 0.2),
          width: 0.8,
        ),
      ),
      child: Text(
        status.toDisplayString(),
        style: AppTextStyles.caption.copyWith(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  (Color, Color) _statusColors(match_entity.MatchStatus status) {
    return switch (status) {
      match_entity.MatchStatus.upcoming =>
        (AppColors.primary.withValues(alpha: 0.08), AppColors.primary),
      match_entity.MatchStatus.inProgress =>
        (AppColors.accent.withValues(alpha: 0.12), AppColors.accent),
      match_entity.MatchStatus.finished =>
        (AppColors.gray100, AppColors.gray700),
      match_entity.MatchStatus.postponed =>
        (AppColors.error.withValues(alpha: 0.08), AppColors.error),
    };
  }
}

/// Display refinado de score o VS
class _ScoreDisplay extends StatelessWidget {
  final match_entity.Match match;

  const _ScoreDisplay({required this.match});

  @override
  Widget build(BuildContext context) {
    final isFinished = match.status == match_entity.MatchStatus.finished;

    return Container(
      width: 68,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: isFinished
            ? AppColors.primary.withValues(alpha: 0.06)
            : AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isFinished
              ? AppColors.primary.withValues(alpha: 0.15)
              : AppColors.border,
          width: 0.8,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isFinished ? '${match.homeScore}' : 'VS',
            style: AppTextStyles.h2.copyWith(
              color: isFinished ? AppColors.primary : AppColors.textSecondary,
              fontSize: isFinished ? 20 : 16,
              fontWeight: FontWeight.w700,
              height: 1.0,
            ),
          ),
          if (isFinished) ...[
            Text(
              '-',
              style: AppTextStyles.h3.copyWith(
                color: AppColors.textTertiary,
                fontSize: 12,
                height: 1.0,
              ),
            ),
            Text(
              '${match.awayScore}',
              style: AppTextStyles.h2.copyWith(
                color: AppColors.primary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                height: 1.0,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
