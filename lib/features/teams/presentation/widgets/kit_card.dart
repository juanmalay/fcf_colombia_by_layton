import 'package:flutter/material.dart';

import '../../../../core/design_system/app_colors.dart';
import '../../../../core/design_system/app_text_styles.dart';
import '../../domain/entities/kit.dart';

class KitCard extends StatelessWidget {
  final Kit kit;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const KitCard({
    super.key,
    required this.kit,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = kit.imageUrl.isNotEmpty;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 0.8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border, width: 0.8),
              ),
              child: hasImage
                  ? Image.network(
                      kit.imageUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return _KitImageFallback(kit: kit);
                      },
                    )
                  : _KitImageFallback(kit: kit),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          kit.title,
                          style: AppTextStyles.h3.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: onToggleFavorite,
                        tooltip: isFavorite
                            ? 'Quitar de favoritos'
                            : 'Agregar a favoritos',
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite
                              ? AppColors.error
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    kit.description,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _KitMetaChip(label: kit.brand),
                      if (kit.sponsor.isNotEmpty) _KitMetaChip(label: kit.sponsor),
                      if (kit.tournament.isNotEmpty)
                        _KitMetaChip(label: kit.tournament),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KitMetaChip extends StatelessWidget {
  final String label;

  const _KitMetaChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.border, width: 0.6),
      ),
      child: Text(
        label,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}

class _KitImageFallback extends StatelessWidget {
  final Kit kit;

  const _KitImageFallback({required this.kit});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.checkroom,
            color: AppColors.primary,
            size: 28,
          ),
          const SizedBox(height: 6),
          Text(
            kit.typeLabel,
            style: AppTextStyles.label.copyWith(color: AppColors.primary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
