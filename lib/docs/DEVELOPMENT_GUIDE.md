# 📚 DEVELOPMENT_GUIDE.md - Flutter

**Última actualización**: Abril 2026  
**FASE**: 0 (Base) - Cerrada | Iniciando FASE 1  
**Documento**: Guía de desarrollo para futuras contribuciones

---

## 📖 Índice

1. [Estructura del Proyecto](#estructura-del-proyecto)
2. [Cómo Crear una Nueva Pantalla](#cómo-crear-una-nueva-pantalla)
3. [Cómo Implementar Domain & Data Layers](#cómo-implementar-domain--data-layers)
4. [Patrones y Convenciones](#patrones-y-convenciones)
5. [Integración con Backend](#integración-con-backend)
6. [Testing](#testing)
7. [Debugging](#debugging)
8. [Commands Útiles](#commands-útiles)

---

## 1. Estructura del Proyecto

### Carpeta Root

```
.
├── lib/                           # Código Dart
├── assets/                        # Imágenes, fuentes, datos
├── test/                          # Tests (CREAR EN FASE 1)
├── ARCHITECTURE_AND_DESIGN.md    # Documento rector
├── PROJECT_BUILD_SUMMARY.md       # Summary de FASE 0
├── DEVELOPMENT_GUIDE.md           # Este archivo
├── pubspec.yaml                   # Dependencies
└── README.md
```

### Carpeta lib/

#### core/ (Infraestructura compartida)

```
core/
├── design_system/
│   ├── app_colors.dart           # 50+ colores definidos
│   ├── app_text_styles.dart      # Escalas tipográficas
│   ├── app_spacing.dart          # 8px grid constants
│   └── app_theme.dart            # Material 3 theme
│
├── models/
│   ├── app_exception.dart        # 5 exception types
│   └── result.dart               # Result<T> generic
│
├── extensions/
│   ├── build_context_ext.dart    # BuildContext helpers
│   └── widget_ref_ext.dart       # Riverpod helpers
│
├── services/
│   └── dio_service.dart          # HTTP client centralizado
│
├── providers/
│   └── app_providers.dart        # Global DI setup
│
├── utils/
│   └── logger.dart               # Logging structured
│
└── widgets/common/
    ├── custom_bottom_nav.dart
    └── custom_scaffold_with_nav.dart
```

#### app/ (Navegación principal)

```
app/
├── app.dart                       # Main MaterialApp
└── router/
    └── app_router.dart           # GoRouter config con ShellRoute
```

#### features/ (Feature modules)

```
features/{feature_name}/
├── presentation/
│   ├── screens/
│   │   └── {feature_name}_screen.dart    # Main ConsumerWidget
│   └── widgets/
│       └── {widget_name}.dart            # Sub-widgets
│
├── domain/                               # [FASE 1]
│   ├── entities/
│   ├── repositories/
│   └── usecases/
│
└── data/                                 # [FASE 1]
    ├── datasources/
    ├── models/
    └── repositories/
```

**Ejemplo completo (Matches)**:

```
features/matches/
├── presentation/
│   ├── screens/
│   │   └── matches_screen.dart
│   └── widgets/
│       └── match_card.dart
├── domain/                    # TODO FASE 1
│   ├── entities/
│   │   └── match_entity.dart
│   ├── repositories/
│   │   └── match_repository.dart
│   └── usecases/
│       ├── get_upcoming_matches_usecase.dart
│       └── get_match_results_usecase.dart
└── data/                      # INICIADO (mock data)
    ├── datasources/
    │   ├── match_remote_datasource.dart
    │   └── match_local_datasource.dart
    ├── models/
    │   └── match_model.dart (Freezed DTOs)
    └── repositories/
        └── match_repository_impl.dart
```

---

## 2. Cómo Crear una Nueva Pantalla

### Paso 1: Crear estructura de carpetas

```powershell
# Ejemplo: Nueva feature "standings"
mkdir lib/features/standings/presentation/screens
mkdir lib/features/standings/presentation/widgets
mkdir lib/features/standings/domain/{entities,repositories,usecases}
mkdir lib/features/standings/data/{datasources,models,repositories}
```

### Paso 2: Crear el Screen

```dart
// lib/features/standings/presentation/screens/standings_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/app_colors.dart';
import '../../../../core/design_system/app_text_styles.dart';

class StandingsScreen extends ConsumerWidget {
  const StandingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabla de Posiciones'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Standings Coming Soon',
          style: AppTextStyles.h2,
        ),
      ),
    );
  }
}
```

### Paso 3: Registrar en Router

```dart
// Agregar en lib/app/router/app_router.dart dentro del ShellRoute
GoRoute(
  path: '/standings',
  name: 'standings',
  builder: (context, state) => const StandingsScreen(),
),
```

### Paso 4: Agregar al Bottom Nav enum

```dart
// lib/core/widgets/common/custom_scaffold_with_nav.dart
enum MainTab {
  home,
  matches,
  explore,
  favorites,
  standings,  // ← AGREGAR (si van a ser 6+ tabs, redesign necesario)
  settings,
}
```

**⚠️ Nota**: Máximo 5 tabs recomendado. Si es STANDIG, debería ir en EXPLORE.

---

## 3. Cómo Implementar Domain & Data Layers

### A. Crear Entity

```dart
// lib/features/matches/domain/entities/match_entity.dart
class MatchEntity {
  final String id;
  final String homeTeam;
  final String awayTeam;
  final String? homeScore;
  final String? awayScore;
  final DateTime date;
  final String tournament;

  MatchEntity({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    this.homeScore,
    this.awayScore,
    required this.date,
    required this.tournament,
  });
}
```

### B. Crear Repository Interface

```dart
// lib/features/matches/domain/repositories/match_repository.dart
import '../entities/match_entity.dart';
import '../../../../core/models/result.dart';

abstract class MatchRepository {
  Future<Result<List<MatchEntity>>> getUpcomingMatches();
  Future<Result<List<MatchEntity>>> getRecentMatches();
  Future<Result<MatchEntity>> getMatchDetail(String id);
}
```

### C. Crear UseCase

```dart
// lib/features/matches/domain/usecases/get_upcoming_matches_usecase.dart
import '../repositories/match_repository.dart';
import '../entities/match_entity.dart';
import '../../../../core/models/result.dart';

class GetUpcomingMatchesUseCase {
  final MatchRepository repository;

  GetUpcomingMatchesUseCase(this.repository);

  Future<Result<List<MatchEntity>>> call() {
    return repository.getUpcomingMatches();
  }
}
```

### D. Crear DTO (congelar con Freezed)

```dart
// lib/features/matches/data/models/match_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/match_entity.dart';

part 'match_model.freezed.dart';
part 'match_model.g.dart';

@freezed
class MatchModel with _$MatchModel {
  const factory MatchModel({
    required String id,
    required String homeTeam,
    required String awayTeam,
    String? homeScore,
    String? awayScore,
    required DateTime date,
    required String tournament,
  }) = _MatchModel;

  factory MatchModel.fromJson(Map<String, dynamic> json) =>
      _$MatchModelFromJson(json);
}

extension MatchModelX on MatchModel {
  MatchEntity toEntity() => MatchEntity(
    id: id,
    homeTeam: homeTeam,
    awayTeam: awayTeam,
    homeScore: homeScore,
    awayScore: awayScore,
    date: date,
    tournament: tournament,
  );
}
```

**Para generar Freezed code**:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### E. Crear Data Source

```dart
// lib/features/matches/data/datasources/match_remote_datasource.dart
import '../../../../core/services/dio_service.dart';
import '../models/match_model.dart';

abstract class MatchRemoteDataSource {
  Future<List<MatchModel>> getUpcomingMatches();
  Future<List<MatchModel>> getRecentMatches();
  Future<MatchModel> getMatchDetail(String id);
}

class MatchRemoteDataSourceImpl implements MatchRemoteDataSource {
  final DioService dio;

  MatchRemoteDataSourceImpl(this.dio);

  @override
  Future<List<MatchModel>> getUpcomingMatches() async {
    // TODO: Actual API call cuando backend esté listo
    // return dio.get('/api/v1/matches/upcoming');
    
    // Por ahora, retornar mock
    return [
      MatchModel(
        id: '1',
        homeTeam: 'Colombia',
        awayTeam: 'Uruguay',
        date: DateTime.now().add(Duration(days: 7)),
        tournament: 'Eliminatoria',
      ),
    ];
  }

  @override
  Future<List<MatchModel>> getRecentMatches() async {
    // Mock data
    return [];
  }

  @override
  Future<MatchModel> getMatchDetail(String id) async {
    throw UnimplementedError();
  }
}
```

### F. Crear Repository Implementation

```dart
// lib/features/matches/data/repositories/match_repository_impl.dart
import '../../domain/entities/match_entity.dart';
import '../../domain/repositories/match_repository.dart';
import '../../../../core/models/result.dart';
import '../../../../core/models/app_exception.dart';
import '../datasources/match_remote_datasource.dart';

class MatchRepositoryImpl implements MatchRepository {
  final MatchRemoteDataSource remoteDataSource;

  MatchRepositoryImpl(this.remoteDataSource);

  @override
  Future<Result<List<MatchEntity>>> getUpcomingMatches() async {
    try {
      final models = await remoteDataSource.getUpcomingMatches();
      final entities = models.map((m) => m.toEntity()).toList();
      return Success(entities);
    } on Exception catch (e) {
      return Failure(
        AppException(message: 'Error fetching upcoming matches', error: e),
      );
    }
  }

  @override
  Future<Result<List<MatchEntity>>> getRecentMatches() async {
    try {
      final models = await remoteDataSource.getRecentMatches();
      final entities = models.map((m) => m.toEntity()).toList();
      return Success(entities);
    } on Exception catch (e) {
      return Failure(
        AppException(message: 'Error fetching recent matches', error: e),
      );
    }
  }

  @override
  Future<Result<MatchEntity>> getMatchDetail(String id) async {
    throw UnimplementedError();
  }
}
```

### G. Crear Providers (Riverpod)

```dart
// lib/core/providers/match_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/dio_service.dart';
import '../../features/matches/data/datasources/match_remote_datasource.dart';
import '../../features/matches/data/repositories/match_repository_impl.dart';
import '../../features/matches/domain/repositories/match_repository.dart';
import '../../features/matches/domain/usecases/get_upcoming_matches_usecase.dart';

// Data Source
final matchRemoteDataSourceProvider = Provider((ref) {
  final dio = ref.watch(dioServiceProvider);
  return MatchRemoteDataSourceImpl(dio);
});

// Repository
final matchRepositoryProvider = Provider<MatchRepository>((ref) {
  final dataSource = ref.watch(matchRemoteDataSourceProvider);
  return MatchRepositoryImpl(dataSource);
});

// UseCase
final getUpcomingMatchesUseCaseProvider = Provider((ref) {
  final repository = ref.watch(matchRepositoryProvider);
  return GetUpcomingMatchesUseCase(repository);
});

// Feature Providers
final upcomingMatchesProvider = FutureProvider((ref) async {
  final useCase = ref.watch(getUpcomingMatchesUseCaseProvider);
  final result = await useCase();
  return result.fold(
    (failure) => throw failure,
    (matches) => matches,
  );
});
```

### H. Usar en UI

```dart
// lib/features/matches/presentation/screens/matches_screen.dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  final matchesAsync = ref.watch(upcomingMatchesProvider);

  return matchesAsync.when(
    loading: () => const Center(child: CircularProgressIndicator()),
    error: (err, stack) => Center(child: Text('Error: $err')),
    data: (matches) => ListView.builder(
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final match = matches[index];
        return MatchCard(match: match);
      },
    ),
  );
}
```

---

## 4. Patrones y Convenciones

### Naming Conventions

| Elemento | Convención | Ejemplo |
|----------|-----------|---------|
| File | snake_case | `match_screen.dart` |
| Class | PascalCase | `MatchScreen` |
| Variable | camelCase | `matchId` |
| Constant | UPPER_SNAKE_CASE o camelCase | `kMaxMatches` o `maxMatches` |
| Screen | `{Feature}Screen` | `MatchesScreen` |
| Widget | `{Purpose}{Widget}` | `MatchCard`, `TeamHeader` |
| Provider | camelCase + `Provider` suffix | `matchesProvider`, `upcomingMatchesProvider` |

### Import Order

```dart
// 1. Dart imports
import 'dart:async';

// 2. Flutter imports
import 'package:flutter/material.dart';

// 3. Package imports
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 4. Relative imports (cuartas partes más cercanas primero)
import '../../../../core/design_system/app_colors.dart';
import '../../../domain/entities/match_entity.dart';
import '../widgets/match_card.dart';
```

### Widget Best Practices

```dart
// ✅ CORRECTO
class MatchCard extends StatelessWidget {
  final Match match;
  final VoidCallback? onTap;

  const MatchCard({
    Key? key,
    required this.match,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // ...
      ),
    );
  }
}

// ❌ INCORRECTO
class MatchCard extends StatefulWidget {
  // Avoid unless you need lifecycle
}

// ❌ INCORRECTO
class MatchCard extends ConsumerWidget {
  // Only use when watching Riverpod providers
}
```

### Error Handling Pattern

```dart
// ✅ Siempre usar Result<T> y fold
final result = await useCase.getMatches();
return result.fold(
  (failure) {
    // Handle error
    logger.error('Failed: $failure');
    return SizedBox(); // Or show error widget
  },
  (data) {
    // Handle success
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) => MatchCard(match: data[index]),
    );
  },
);
```

---

## 5. Integración con Backend

### Cuando Backend esté listo

1. **Cambiar mock por URLs reales**:

```dart
// Antes (mock)
@override
Future<List<MatchModel>> getUpcomingMatches() async {
  return [MatchModel(...)];
}

// Después (real)
@override
Future<List<MatchModel>> getUpcomingMatches() async {
  final response = await dio.get('/api/v1/matches/upcoming');
  return (response.data as List)
    .map((json) => MatchModel.fromJson(json))
    .toList();
}
```

2. **La estructura de carpetas NO cambia**, solo las datasources.

3. **Los DTOs deben coincidir con lo que devuelve el backend**.

---

## 6. Testing

### Testing Strategy (FASE 2)

```
test/
├── core/
│   ├── models/
│   │   └── result_test.dart
│   └── extensions/
│       └── build_context_ext_test.dart
├── features/
│   ├── matches/
│   │   ├── domain/
│   │   │   ├── usecases/
│   │   │   │   └── get_upcoming_matches_usecase_test.dart
│   │   │   └── repositories/
│   │   │       └── match_repository_test.dart
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── match_remote_datasource_test.dart
│   │   │   └── models/
│   │   │       └── match_model_test.dart
│   │   └── presentation/
│   │       └── screens/
│   │           └── matches_screen_test.dart
│   └── home/
│       └── ...
└── integration_test/
    └── app_flow_test.dart
```

### Unit Test Example

(Será documentado en FASE 2)

---

## 7. Debugging

### Logger Levels

```dart
import '../../core/utils/logger.dart';

// Info (general)
AppLogger.info('Iniciando sesión...');

// Warn (potential issues)
AppLogger.warn('Respuesta sin datos');

// Error (exceptions)
AppLogger.error('Network error', stackTrace);
```

### DevTools

```bash
flutter pub global activate devtools
devtools
```

### Hot Reload Tips

- Hot reload funciona para UI changes
- Hot restart necesario para: cambios de provider, principales, dependencias
- Command+S o Ctrl+S = hot reload

---

## 8. Commands Útiles

### Build & Run

```bash
# Debug (default)
flutter run

# Release
flutter run --release

# Profile (performance)
flutter run --profile

# Web (si aplica)
flutter run -d chrome
```

### Code Generation

```bash
# Run build_runner (para Freezed, JSON)
flutter pub run build_runner build

# Watch mode (automático)
flutter pub run build_runner watch

# Clean cache
flutter pub run build_runner clean
```

### Testing

```bash
# Run all tests
flutter test

# Run specific test
flutter test test/core/models/result_test.dart

# Watch mode
flutter test --watch
```

### Analysis & Format

```bash
# Analyze code
flutter analyze

# Format code
dart format lib/

# Combined
dart analyze && dart format lib/
```

### Limpiar caché

```bash
flutter clean
flutter pub get
```

---

## 📋 Checklist para Nueva Feature (Cópia y Pega)

```
[ ] Crear carpetas base (presentation, domain, data)
[ ] Crear screen (ConsumerWidget)
[ ] Registrar ruta en app_router.dart
[ ] ✅ SI solo placeholder, SKIP domain/data
[ ] ✅ SI con lógica:
  [ ] Crear entity
  [ ] Crear repository interface
  [ ] Crear usecase (si aplica)
  [ ] Crear DTO (Freezed)
  [ ] Crear datasource
  [ ] Crear repository impl
  [ ] Crear providers
  [ ] Implementar en screen
[ ] Testear en Android/iOS
[ ] FlutterLint check
```

---

## 🔗 Referencias

- [ARCHITECTURE_AND_DESIGN.md](./ARCHITECTURE_AND_DESIGN.md) - Documento rector
- [Flutter Official Docs](https://flutter.dev/docs)
- [Riverpod Documentation](https://riverpod.dev)
- [GoRouter Documentation](https://pub.dev/packages/go_router)
- [Freezed Documentation](https://pub.dev/packages/freezed)

---

**Última actualización**: Abril 2026  
**Mantenido por**: Equipo de desarrollo FCF Colombia  
**Versión**: 1.0 (FASE 0 Cerrada)
