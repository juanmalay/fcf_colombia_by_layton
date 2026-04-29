import 'package:flutter/material.dart';
import '../../design_system/app_colors.dart';
import '../../design_system/app_text_styles.dart';

/// Item para el bottom navigation
class BottomNavItem {
  final IconData icon;
  final String label;
  final Color? activeColor;

  const BottomNavItem({
    required this.icon,
    required this.label,
    this.activeColor,
  });
}

/// Bottom Navigation Bar customizado
class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onChanged;
  final List<BottomNavItem> items;
  final Color? backgroundColor;
  final Color? activeColor;
  final Color? inactiveColor;

  const CustomBottomNav({
    Key? key,
    required this.currentIndex,
    required this.onChanged,
    required this.items,
    this.backgroundColor,
    this.activeColor,
    this.inactiveColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onChanged,
      type: BottomNavigationBarType.fixed,
      backgroundColor: backgroundColor ?? AppColors.background,
      selectedItemColor: activeColor ?? AppColors.primary,
      unselectedItemColor: inactiveColor ?? AppColors.textTertiary,
      selectedLabelStyle: AppTextStyles.label,
      unselectedLabelStyle: AppTextStyles.label,
      iconSize: 24,
      items: items
          .map(
            (item) => BottomNavigationBarItem(
              icon: Icon(item.icon),
              label: item.label,
            ),
          )
          .toList(),
    );
  }
}
