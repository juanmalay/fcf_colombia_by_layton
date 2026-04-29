/// Sistema de espaciado: 8px grid
/// Usado en: padding, margin, gaps, etc.
class AppSpacing {
  // Base grid: 8px
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  // Aliases for clarity
  static const double zero = 0.0;
  static const double tiny = 4.0;
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;
  static const double extraLarge = 32.0;
  static const double huge = 48.0;

  // Component-specific
  static const double componentPadding = 16.0; // Internal padding
  static const double sectionGap = 24.0; // Gap between sections
  static const double cardSpacing = 12.0; // Between cards in a list

  // Responsive breakpoints (future use)
  static const double mobileMaxWidth = 480.0;
  static const double tabletMinWidth = 768.0;
  static const double tabletMaxWidth = 1024.0;
  static const double desktopMinWidth = 1024.0;
}
