import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/app_colors.dart';
import '../../../../core/design_system/app_spacing.dart';
import '../../../../core/design_system/app_text_styles.dart';
import '../providers/settings_providers.dart';

/// Pantalla de configuracion con preferencias persistidas localmente.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuracion'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _SettingsSection(
            title: 'Notificaciones',
            children: [
              _SwitchTile(
                title: 'Notificaciones de partidos',
                subtitle: 'Recibe alertas de partidos programados',
                value: settings['match_notifications'] ?? true,
                onChanged: (value) =>
                    notifier.setValue('match_notifications', value),
              ),
              _SwitchTile(
                title: 'Notificaciones de goles',
                subtitle: 'Alertas en tiempo real de goles',
                value: settings['goal_notifications'] ?? true,
                onChanged: (value) =>
                    notifier.setValue('goal_notifications', value),
              ),
              _SwitchTile(
                title: 'Notificaciones de noticias',
                subtitle: 'Actualizaciones del equipo nacional',
                value: settings['news_notifications'] ?? false,
                onChanged: (value) =>
                    notifier.setValue('news_notifications', value),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _SettingsSection(
            title: 'Cuenta y sincronizacion',
            children: [
              _SwitchTile(
                title: 'Sincronizar datos',
                subtitle: 'Sincroniza tus favoritos entre dispositivos',
                value: settings['sync_data'] ?? false,
                onChanged: (value) => notifier.setValue('sync_data', value),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _SettingsSection(
            title: 'Apariencia',
            children: [
              _SwitchTile(
                title: 'Tema oscuro',
                subtitle: 'Preferencia guardada localmente',
                value: settings['dark_theme'] ?? true,
                onChanged: (value) => notifier.setValue('dark_theme', value),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _SettingsSection(
            title: 'Informacion',
            children: const [
              _InfoTile(title: 'Version de la aplicacion', subtitle: '1.0.0'),
              _InfoTile(title: 'Acerca de', subtitle: 'FCF Colombia no oficial'),
            ],
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.h2.copyWith(color: AppColors.accent),
        ),
        const SizedBox(height: AppSpacing.md),
        ...children,
      ],
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return _TileShell(
      child: Row(
        children: [
          Expanded(
            child: _TileText(title: title, subtitle: subtitle),
          ),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const _InfoTile({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return _TileShell(
      child: _TileText(title: title, subtitle: subtitle),
    );
  }
}

class _TileShell extends StatelessWidget {
  final Widget child;

  const _TileShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: child,
    );
  }
}

class _TileText extends StatelessWidget {
  final String title;
  final String subtitle;

  const _TileText({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.label),
        const SizedBox(height: AppSpacing.xs),
        Text(subtitle, style: AppTextStyles.caption),
      ],
    );
  }
}
