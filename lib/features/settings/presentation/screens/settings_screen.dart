import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/app_colors.dart';
import '../../../../core/design_system/app_spacing.dart';
import '../../../../core/design_system/app_text_styles.dart';

/// Pantalla de configuración
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // Notificaciones Section
          _SettingsSection(
            title: 'Notificaciones',
            children: [
              _SettingsTile(
                title: 'Notificaciones de partidos',
                subtitle: 'Recibe alertas de partidos programados',
              ),
              _SettingsTile(
                title: 'Notificaciones de goles',
                subtitle: 'Alertas en tiempo real de goles',
              ),
              _SettingsTile(
                title: 'Notificaciones de noticias',
                subtitle: 'Actualizaciones del equipo nacional',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          
          // Cuenta Section
          _SettingsSection(
            title: 'Cuenta y Sincronización',
            children: [
              _SettingsTile(
                title: 'Sincronizar datos',
                subtitle: 'Sincroniza tus favoritos entre dispositivos',
              ),
              _SettingsTile(
                title: 'Historial',
                subtitle: 'Gestiona tu historial de visualización',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          
          // Apariencia Section
          _SettingsSection(
            title: 'Apariencia',
            children: [
              _SettingsTile(
                title: 'Tema oscuro',
                subtitle: 'Tema actual: Oscuro',
              ),
              _SettingsTile(
                title: 'Tamaño de fuente',
                subtitle: 'Tamaño: Estándar',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          
          // Información Section
          _SettingsSection(
            title: 'Información',
            children: [
              _SettingsTile(
                title: 'Versión de la aplicación',
                subtitle: 'v1.0.0',
              ),
              _SettingsTile(
                title: 'Acerca de',
                subtitle: 'Información de la app',
              ),
              _SettingsTile(
                title: 'Privacidad',
                subtitle: 'Política de privacidad',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          
          // Logout Button
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.logout),
            label: const Text('Cerrar sesión'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(AppSpacing.md),
              backgroundColor: AppColors.error,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
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

class _SettingsTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SettingsTile({
    required this.title,
    required this.subtitle,
  });

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.label),
                const SizedBox(height: AppSpacing.xs),
                Text(subtitle, style: AppTextStyles.caption),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: AppColors.textSecondary,
            size: 16,
          ),
        ],
      ),
    );
  }
}