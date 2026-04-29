# FCF Colombia App - Arquitectura y Diseño del Producto

**Versión**: 1.0  
**Fecha**: Abril 2026  
**Estado**: Documento de referencia oficial del proyecto

---

## Reglas iniciales obligatorias

1. Ningún widget consume JSON o API directamente.
2. Ninguna pantalla contiene lógica de negocio.
3. Todo módulo debe respetar:
   presentation → domain → data
4. Todo endpoint del backend debe responder con DTOs, no entidades directas.
5. Todo módulo nuevo debe crearse completo desde su estructura base.
6. No diseñar pantallas finales sin antes tener design system.
7. No integrar backend real hasta que matches funcione completo en mock.

## 📋 Tabla de Contenidos

1. [Propuesta de Diseño Visual](#propuesta-de-diseño-visual)
2. [Arquitectura Flutter Recomendada](#arquitectura-flutter-recomendada)
3. [Organización Funcional por Módulos](#organización-funcional-por-módulos)
4. [Reglas de Desarrollo del Proyecto](#reglas-de-desarrollo-del-proyecto)
5. [Plan de Refactor por Fases](#plan-de-refactor-por-fases)
6. [Preparación para Backend Spring Boot](#preparación-para-backend-spring-boot)
7. [Árbol de Carpetas Detallado](#árbol-de-carpetas-detallado)
8. [Propuesta de Navegación Principal](#propuesta-de-navegación-principal)
9. [Pantallas Recomendadas para V1](#pantallas-recomendadas-para-v1)
10. [Componentes Base Reutilizables](#componentes-base-reutilizables)
11. [Resumen Ejecutivo y Próximos Pasos](#resumen-ejecutivo-y-próximos-pasos)

---

## 1. Propuesta de Diseño Visual

### 1.1 Dirección Visual General

**Concepto**: "Stadio Moderno" – Una app deportiva premium que refleja la intensidad, profesionalismo y modernidad del fútbol contemporáneo.

### Identidad Visual Diferenciadora

Además del concepto "Stadio Moderno", la app debe incluir:

- Elemento distintivo visual:
  - Líneas diagonales dinámicas (inspiradas en movimiento de balón)
  - Gradientes sutiles en headers (azul → negro)
  - Glow sutil en eventos importantes (goles, highlights)

- Microinteracciones:
  - Animación al marcar favorito
  - Highlight animado en goles
  - Transiciones con easing deportivo (rápido y fluido)

- Regla:
  Ninguna pantalla debe sentirse plana o genérica.

#### Características Clave

- **Tipografía**:
  - **Inter**: Body, accesibilidad, modernidad
  - **Roboto Mono**: Datos/números, precisión deportiva

#### Paleta de Colores Principal

| Color | Código | Uso |
|-------|--------|-----|
| Azul Profundo | `#0F1E3D` | Corporativo, confianza, profesional |
| Amarillo Vibrante | `#FFD700` | Acento, energía, fútbol (Colombia) |
| Rojo Deportivo | `#E63946` | Acción, urgencia, emoción |
| Gris Neutro | `#2D3E50`, `#ECF0F1` | Jerarquía y legibilidad |
| Blanco Limpio | `#FFFFFF` | Fondo principal |

**Justificación**: Esta paleta evoca el profesionalismo de apps como ESPN o Onefootball, con identidad local (azul/amarillo colombiano) sin copiar. El alto contraste asegura legibilidad en condiciones de luz solar (uso común en estadios).

---

### 1.2 Navegación Principal

**Arquitectura de navegación**: Bottom Tab Navigation + Stack interno por feature.

```
┌─────────────────────────────────┐
│  HOME                           │
│  [Header adapta a contexto]     │
│  [Contenido scrollable]         │
└─────────────────────────────────┘
┌─────────────────────────────────┐
│ 🏠 Home │⚽ Matches│📊 All │⭐│⚙️  │
└─────────────────────────────────┘
```

#### Tab Principal (5 pestañas)

1. **Home** - Inicio, resumen, próximos partidos destacados
2. **Matches** - Partidos completo (próximos, resultados, detalle)
3. **Explore** - Hub central: Equipos, Jugadores, Torneos, Tabla, Noticias, Multimedia
4. **Favorites** - Favoritos (búsqueda rápida, acceso filtrado)
5. **Settings** - Ajustes, perfil, idioma, notificaciones

Justificación:
- "Explore" suena natural y descubrimiento
- Evita sensación de "cajón de cosas"
- Permite evolucionar a buscador + categorías

**Por qué esta estructura**:
- Reduce el agotamiento cognitivo (no 10+ tabs, solo 5 principales)
- "All" actúa como discovery central sin sobrecargar Home
- Matches obtiene su propio tab porque es el centro de la app
- Favorites es búsqueda rápida (patrón de uso real)
- Settings separado (patrón estándar)

---

### 1.3 Distribución de Pantallas y Jerarquía Visual

#### Screen Hierarchy

```
HOME TAB
├── HomeScreen
│   ├── NextMatch (Hero Card animado)
│   ├── RecentResults (Carrusel)
│   ├── FeaturedNews (Snippet)
│   └── QuickStats (Tabla condensada)

MATCHES TAB
├── MatchesScreen (Tab interno: Upcoming | Results)
│   ├── UpcomingTab
│   │   └── MatchCard (Grouped by date)
│   └── ResultsTab
│       └── MatchCard
├── MatchDetailScreen
│   ├── Hero Header (Score, teams, date)
│   ├── Tabs: Info | LineUp | Stats | Commentary
│   └── RelatedMatches

ALL TAB
├── AllScreen (Tab interno)
│   ├── TeamsTab
│   │   ├── TeamListScreen
│   │   └── TeamDetailScreen
│   ├── PlayersTab
│   │   ├── PlayerListScreen
│   │   └── PlayerDetailScreen
│   ├── TournamentsTab
│   │   ├── TournamentListScreen
│   │   └── TournamentDetailScreen [WORLD_CUP como subtipo]
│   ├── StandingsTab
│   │   └── StandingsScreen
│   ├── NewsTab
│   │   ├── NewsListScreen
│   │   └── NewsDetailScreen
│   └── MultimediaTab
│       ├── MultimediaListScreen
│       └── MultimediaViewerScreen

WORLD_CUP (Sub-módulo integrado dentro de Tournaments)
├── WorldCupHubScreen (Calendario, Grupos, Cruces)
├── WorldCupGroupsScreen
├── WorldCupCrossScreen
└── WorldCupTeamDetailScreen
```

---

### 1.4 Componentes Reutilizables Base

#### Atomismo Visual (Atomic Design)

**Atoms (Componentes micro)**:
- `CustomButton` - Primary, Secondary, Ghost, Filled (4 estilos)
- `CustomChip` - Selección, filtro, estado
- `CustomBadge` - Números, estados (goles, tarjetas)
- `CustomDivider` - Líneas divisoras branded
- `CustomTag` - Etiquetas de torneo, estado
- `CustomIcon` - Wrapper de IconButton con branding

**Molecules (Componentes simples)**:
- `MatchScore` - Score card compacto
- `PlayerCard` - Foto, nombre, posición, número
- `TeamLogo` - Logo con fallback, decoración
- `StatItem` - Icono + valor + label
- `RatingBar` - Evaluación visual
- `NewsCardSmall` - Thumbnail + título + fecha
- `EmptyState` - Ilustración + mensaje + acción
- `LoadingShimmer` - Loading esquelético

**Organisms (Componentes complejos)**:
- `MatchCard` - Card de partido completo (próximo o resultado)
- `MatchDetailHeader` - Header de detalle de partido
- `LineupSection` - Alineaciones XI
- `StatsComparison` - Comparativa de equipo
- `TournamentCard` - Torneo con estado
- `News Feed` - Feed de noticias
- `BottomNavigationBar` - Navegación custom

---

### 1.5 Estilo de Cards, Botones, Headers

#### Cards

```
┌─────────────────────────┐
│ ⚽ Colombia  2 - 1 Uruguay│  ← Header info
│ 15 Jun 2024 • Clasificat.│
│                         │
│ [Equipo]  vs  [Equipo] │  ← Teams
│                         │
│ VER DETALLE            │  ← CTA
└─────────────────────────┘
```

- Esquinas redondeadas (12px)
- Sombra sutil (elevation 2)
- Borde sutil (#ddd) para alto contraste
- Padding interno 16px

#### Botones

- **Primary**: Azul profundo fondo, texto blanco, 48px altura
- **Secondary**: Borde azul, texto azul, transparente fondo
- **Ghost**: Sin borde, texto, útil para acciones secundarias
- **Filled**: Color de acento (amarillo/rojo) para CTAs críticas
- Siempre **rounded corners (8px)**
- **Ripple effect** en tap
- **Loading state**: Spinner animado + disablé

#### Headers

```
┌──────────────────────────────┐
│ < Partidos                  │  ← Título + Icono atrás
├──────────────────────────────┤
│  📅 [ Próximos | Resultados ]│  ← Filtros/Tabs
└──────────────────────────────┘
```

- Altura variable: 56px (simple) a 200px (hero)
- Blur effect opcional en scroll (iOS style)
- Icono atrás siempre presente (X o <)

#### Tabs Internos

- Indicador underline animado (color amarillo)
- Scroll horizontal en móviles
- Padding 16px horizontal

---

### 1.6 Tono Visual Deportivo y Premium

#### Animaciones

- Transiciones suaves (300ms) entre pantallas
- Hero animation en fotos de jugadores/equipos
- Bounce effect en interacciones
- Shimmer loading (premium feel)

#### Tipografía Escala

- **H1**: 32px, bold, leading 1.2
- **H2**: 24px, semibold, leading 1.3
- **H3**: 18px, semibold, leading 1.4
- **Body**: 14px, regular, leading 1.5
- **Caption**: 12px, regular, leading 1.4

#### Espaciado (8px Grid)

- Componentes: 16px padding
- Secciones: 24px gap
- Texto: 8px entre elementos

---

## 2. Arquitectura Flutter Recomendada

### 2.1 Principios Arquitectónicos

- **Clean Architecture**: Separación clara entre Presentation, Domain y Data
- **Feature-First**: Cada módulo es autónomo e independiente
- **Riverpod State Management**: Providers para estado global y local
- **GoRouter Navigation**: Navegación declarativa y robusta
- **Dependency Injection**: Providers de Riverpod como inyector

---

### 2.2 Capas de Arquitectura

#### PRESENTATION LAYER (`presentation/`)

**Responsabilidades**:
- Gestiona UI, interacción, estado visual
- Usa `ConsumerWidget` y `ConsumerStatefulWidget` de Riverpod
- Llama a `providers`, no a repositories directamente
- Validación de entrada visual, UX

**Estructura**:
```
presentation/
├── screens/          # Pantallas principales
├── widgets/          # Widgets específicos de la feature
└── providers/        # Riverpod providers (presentación)
```

**Patrón correcto**:
```dart
class MatchesScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchesState = ref.watch(matchesProvider);
    return matchesState.when(
      loading: () => ShimmerLoading(),
      data: (matches) => MatchesList(matches),
      error: (err, st) => ErrorWidget(),
    );
  }
}
```

#### DOMAIN LAYER (`domain/`)

**Responsabilidades**:
- Lógica de negocio **independiente de Flutter**
- Entities: modelos de dominio (Match, Team, Player)
- Repositories: contratos (abstractos), sin implementación
- UseCases: acciones de negocio aisladas

**Estructura**:
```
domain/
├── entities/        # Modelos puros (sin Flutter)
├── repositories/    # Contratos abstractos
└── usecases/        # Lógica de negocio
```

**Ejemplo**:
```dart
// Entity (modelo puro, sin Flutter)
class Match {
  final String id;
  final Team homeTeam;
  final Team awayTeam;
  final int? homeGoals;
  final int? awayGoals;
  final DateTime dateTime;
  // sin Flutter, sin serialización
}

// Repository contrato
abstract class MatchRepository {
  Future<List<Match>> getUpcomingMatches();
  Future<Match> getMatchDetail(String id);
}

// UseCase
class GetUpcomingMatchesUseCase {
  final MatchRepository repository;
  Future<Result<List<Match>>> call() async {
    try {
      return Result.success(await repository.getUpcomingMatches());
    } catch (e) {
      return Result.failure(e);
    }
  }
}
```

#### DATA LAYER (`data/`)

**Responsabilidades**:
- Obtiene datos de fuentes (API, BD local, caché)
- LocalDataSource: acceso a datos locales (SharedPrefs, SQLite)
- RemoteDataSource: acceso a API REST
- Models (DTOs): transforman JSON en Entities
- RepositoryImpl: implementa el contrato, decide dónde obtener datos

**Estructura**:
```
data/
├── datasources/     # Interfaces y implementaciones
├── models/          # DTOs (mapeo JSON)
└── repositories/    # Implementación de repositorios
```

**Ejemplo**:
```dart
// DTO (mapeo JSON con freezed)
@freezed
class MatchModel with _$MatchModel {
  const factory MatchModel({
    required String id,
    required TeamModel homeTeam,
    required TeamModel awayTeam,
    required int? homeGoals,
    required int? awayGoals,
    required DateTime dateTime,
  }) = _MatchModel;

  factory MatchModel.fromJson(Map<String, dynamic> json) =>
      _$MatchModelFromJson(json);

  // Conversión a Entity
  Match toEntity() => Match(
    id: id,
    homeTeam: homeTeam.toEntity(),
    awayTeam: awayTeam.toEntity(),
    homeGoals: homeGoals,
    awayGoals: awayGoals,
    dateTime: dateTime,
  );
}

// RemoteDataSource
abstract class MatchesRemoteDataSource {
  Future<List<MatchModel>> getUpcomingMatches();
}

class MatchesRemoteDataSourceImpl implements MatchesRemoteDataSource {
  final DioService dio;
  
  @override
  Future<List<MatchModel>> getUpcomingMatches() async {
    final response = await dio.get('/api/matches/upcoming');
    return (response.data as List)
        .map((m) => MatchModel.fromJson(m))
        .toList();
  }
}

// RepositoryImpl: orquesta dónde obtener datos
class MatchRepositoryImpl implements MatchRepository {
  final MatchesRemoteDataSource remoteDataSource;
  final MatchesLocalDataSource localDataSource;

  @override
  Future<List<Match>> getUpcomingMatches() async {
    try {
      final models = await remoteDataSource.getUpcomingMatches();
      // Caché local
      await localDataSource.saveMatches(models);
      return models.map((m) => m.toEntity()).toList();
    } catch (e) {
      // Fallback a local si falla red
      final cached = await localDataSource.getUpcomingMatches();
      return cached.map((m) => m.toEntity()).toList();
    }
  }
}
```

---

### 2.3 Riverpod Providers Strategy

#### Estructura de Providers por Feature

**1. Service Providers (inyección de dependencias)**:
```dart
@riverpod
MatchRepository matchRepository(MatchRepositoryRef ref) {
  final dio = ref.watch(dioServiceProvider);
  final local = ref.watch(localStorageServiceProvider);
  final remoteDataSource = MatchesRemoteDataSourceImpl(dio);
  final localDataSource = MatchesLocalDataSourceImpl(local);
  return MatchRepositoryImpl(remoteDataSource, localDataSource);
}
```

**2. UseCase Providers**:
```dart
@riverpod
GetUpcomingMatchesUseCase getUpcomingMatchesUseCase(GetUpcomingMatchesUseCaseRef ref) {
  return GetUpcomingMatchesUseCase(ref.watch(matchRepositoryProvider));
}
```

**3. State Providers (datos + estado)**:
```dart
@riverpod
class MatchesNotifier extends _$MatchesNotifier {
  @override
  Future<List<Match>> build() async {
    final useCase = ref.watch(getUpcomingMatchesUseCaseProvider);
    final result = await useCase();
    return result.fold(
      (failure) => throw failure,
      (matches) => matches,
    );
  }

  void refresh() => ref.refresh(matchesProvider);
}
```

**4. Filter Providers (estado local UI)**:
```dart
@riverpod
class MatchesFilterNotifier extends _$MatchesFilterNotifier {
  @override
  MatchesFilter build() => MatchesFilter.initial();

  void updateTeam(String teamId) =>
      state = state.copyWith(selectedTeamId: teamId);

  void updateDate(DateTime date) =>
      state = state.copyWith(selectedDate: date);
}
```

**5. Computed Providers (selecciones derivadas)**:
```dart
@riverpod
List<Match> filteredMatches(FilteredMatchesRef ref) {
  final allMatches = ref.watch(matchesProvider).maybeWhen(
    data: (data) => data,
    orElse: () => [],
  );
  final filter = ref.watch(matchesFilterProvider);
  
  return allMatches.where((m) {
    if (filter.selectedTeamId != null) {
      if (m.homeTeam.id != filter.selectedTeamId &&
          m.awayTeam.id != filter.selectedTeamId) return false;
    }
    return true;
  }).toList();
}
```

**6. Detail Providers (por ID)**:
```dart
@riverpod
Future<MatchDetail> matchDetail(MatchDetailRef ref, String matchId) async {
  final useCase = ref.watch(getMatchDetailUseCaseProvider);
  final result = await useCase(matchId);
  return result.fold(
    (failure) => throw failure,
    (detail) => detail,
  );
}
```

#### Patrón de Uso en UI

```dart
class MatchesScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(matchesProvider);
    
    return state.when(
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => ErrorWidget(
        error: error,
        onRetry: () => ref.refresh(matchesProvider),
      ),
      data: (matches) {
        final filtered = ref.watch(filteredMatchesProvider);
        return Column(
          children: [
            MatchesFilterBar(
              onTeamSelected: (teamId) {
                ref.read(matchesFilterProvider.notifier)
                    .updateTeam(teamId);
              },
            ),
            ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (ctx, i) => MatchCard(filtered[i]),
            ),
          ],
        );
      },
    );
  }
}
```

---

### 2.4 GoRouter - Estructura de Navegación

```dart
// lib/app_router.dart
final goRouterProvider = Provider((ref) {
  return GoRouter(
    initialLocation: '/home',
    routes: [
      // SHELL ROUTE: Tab Navigation (persiste bottom nav)
      ShellRoute(
        navigator: GlobalKey<NavigatorState>(),
        builder: (context, state, child) {
          return ScaffoldWithNav(child: child);
        },
        routes: [
          // TAB 1: HOME
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (ctx, state) => const HomeScreen(),
            routes: [
              GoRoute(
                path: 'match/:id',
                name: 'matchDetail',
                builder: (ctx, state) => MatchDetailScreen(
                  matchId: state.pathParameters['id']!,
                ),
              ),
            ],
          ),

          // TAB 2: MATCHES
          GoRoute(
            path: '/matches',
            name: 'matches',
            builder: (ctx, state) => const MatchesScreen(),
            routes: [
              GoRoute(
                path: ':matchId',
                name: 'matchDetail',
                builder: (ctx, state) => MatchDetailScreen(
                  matchId: state.pathParameters['matchId']!,
                ),
              ),
            ],
          ),

          // TAB 3: ALL (Hub central con subrutas)
          GoRoute(
            path: '/all',
            name: 'all',
            builder: (ctx, state) => const AllHubScreen(),
            routes: [
              // Equipos
              GoRoute(
                path: 'teams',
                name: 'teams',
                builder: (ctx, state) => const TeamsScreen(),
                routes: [
                  GoRoute(
                    path: ':teamId',
                    name: 'teamDetail',
                    builder: (ctx, state) => TeamDetailScreen(
                      teamId: state.pathParameters['teamId']!,
                    ),
                  ),
                ],
              ),
              // Jugadores
              GoRoute(
                path: 'players',
                name: 'players',
                builder: (ctx, state) => const PlayersScreen(),
                routes: [
                  GoRoute(
                    path: ':playerId',
                    name: 'playerDetail',
                    builder: (ctx, state) => PlayerDetailScreen(
                      playerId: state.pathParameters['playerId']!,
                    ),
                  ),
                ],
              ),
              // Torneos
              GoRoute(
                path: 'tournaments',
                name: 'tournaments',
                builder: (ctx, state) => const TournamentsScreen(),
                routes: [
                  GoRoute(
                    path: ':tournamentId',
                    name: 'tournamentDetail',
                    builder: (ctx, state) => TournamentDetailScreen(
                      tournamentId: state.pathParameters['tournamentId']!,
                    ),
                    routes: [
                      // ⭐ Copa del Mundo como sub-ruta
                      GoRoute(
                        path: 'world-cup',
                        name: 'worldCupDetail',
                        builder: (ctx, state) => const WorldCupHubScreen(
                          tournamentId: ':tournamentId',
                        ),
                        routes: [
                          GoRoute(
                            path: 'groups',
                            name: 'worldCupGroups',
                            builder: (ctx, state) =>
                                const WorldCupGroupsScreen(),
                          ),
                          GoRoute(
                            path: 'knockout',
                            name: 'worldCupKnockout',
                            builder: (ctx, state) =>
                                const WorldCupKnockoutScreen(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              // Tabla de posiciones
              GoRoute(
                path: 'standings',
                name: 'standings',
                builder: (ctx, state) => const StandingsScreen(),
              ),
              // Noticias
              GoRoute(
                path: 'news',
                name: 'news',
                builder: (ctx, state) => const NewsScreen(),
                routes: [
                  GoRoute(
                    path: ':newsId',
                    name: 'newsDetail',
                    builder: (ctx, state) => NewsDetailScreen(
                      newsId: state.pathParameters['newsId']!,
                    ),
                  ),
                ],
              ),
              // Multimedia
              GoRoute(
                path: 'multimedia',
                name: 'multimedia',
                builder: (ctx, state) => const MultimediaScreen(),
              ),
            ],
          ),

          // TAB 4: FAVORITES
          GoRoute(
            path: '/favorites',
            name: 'favorites',
            builder: (ctx, state) => const FavoritesScreen(),
          ),

          // TAB 5: SETTINGS
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (ctx, state) => const SettingsScreen(),
            routes: [
              GoRoute(
                path: 'language',
                name: 'language',
                builder: (ctx, state) => const LanguageScreen(),
              ),
              GoRoute(
                path: 'notifications',
                name: 'notifications',
                builder: (ctx, state) => const NotificationsScreen(),
              ),
            ],
          ),
        ],
      ),

      // FULL SCREEN ROUTES (sin tab nav)
      GoRoute(
        path: '/video/:videoId',
        builder: (ctx, state) => VideoPlayerScreen(
          videoId: state.pathParameters['videoId']!,
        ),
      ),
    ],
  );
});
```

---

### 2.5 Estructura de Modelos y Conversión JSON → Entity

**Entity** (modelo de dominio puro):
```dart
class Match {
  final String id;
  final Team homeTeam;
  final Team awayTeam;
  final int? homeGoals;
  final int? awayGoals;
  final DateTime dateTime;
  final MatchStatus status;
  final String? tournament;
  final List<MatchEvent> events;

  const Match({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeGoals,
    required this.awayGoals,
    required this.dateTime,
    required this.status,
    this.tournament,
    this.events = const [],
  });

  String get scoreLine => '$homeGoals:$awayGoals';
  bool get isFinished => status == MatchStatus.finished;
  bool get isLive => status == MatchStatus.live;
}
```

**Model** (DTO para mapeo JSON):
```dart
@freezed
class MatchModel with _$MatchModel {
  const factory MatchModel({
    required String id,
    required TeamModel homeTeam,
    required TeamModel awayTeam,
    required int? homeGoals,
    required int? awayGoals,
    required DateTime dateTime,
    required String status,
    @Default('') String tournament,
    @Default([]) List<MatchEventModel> events,
  }) = _MatchModel;

  factory MatchModel.fromJson(Map<String, dynamic> json) =>
      _$MatchModelFromJson(json);

  Match toEntity() => Match(
    id: id,
    homeTeam: homeTeam.toEntity(),
    awayTeam: awayTeam.toEntity(),
    homeGoals: homeGoals,
    awayGoals: awayGoals,
    dateTime: dateTime,
    status: MatchStatus.values.firstWhere(
      (s) => s.name == status,
      orElse: () => MatchStatus.upcoming,
    ),
    tournament: tournament,
    events: events.map((e) => e.toEntity()).toList(),
  );
}
```

---

## 3. Organización Funcional por Módulos

### 3.1 Matriz de Módulos

| Módulo | Responsabilidad | Pantallas | Entidades Clave | Dependencias |
|--------|-----------------|-----------|-----------------|--------------|
| **home** | Hub inicial, resumen próximos | HomeScreen | HomeSummary | matches, news |
| **matches** | Partidos: próximos, resultados, detalle | MatchesScreen, MatchDetailScreen | Match, Team, MatchEvent | - |
| **teams** | Listado de equipos y detalle | TeamsScreen, TeamDetailScreen | Team, TeamSquad, TeamStats | - |
| **players** | Búsqueda y detalle de jugadores | PlayersScreen, PlayerDetailScreen | Player, PlayerStats, CareerHistory | teams |
| **tournaments** | Torneos nacionales e int'l | TournamentsScreen, TournamentDetailScreen | Tournament, Standings, Standing | - |
| **standings** | Tabla de clasificación | StandingsScreen | Standings, ClubStanding | tournaments |
| **news** | Noticias y artículos | NewsScreen, NewsDetailScreen | News, NewsCategory | - |
| **multimedia** | Galerías, videos, fotos | MultimediaScreen, MediaViewerScreen | Media, Gallery | - |
| **favorites** | Marcadores rápidos | FavoritesScreen | Favorite (wrapper genérico) | *(todos los demás)* |
| **settings** | Preferencias, idioma, notificaciones | SettingsScreen, LanguageScreen | AppSettings, UserPreferences | - |
| **world_cup** ⭐ | Copa del Mundo (grupos, cruces, calendario) | WorldCupHubScreen, GroupsScreen, KnockoutScreen | WorldCupEdition, Group, KnockoutBracket | tournaments |

### 3.2 Interacciones entre Módulos

```
favorites → puede contener referencias a: matches, players, teams, news
home → consume: matches, world_cup (si es época de mundial)
matches → puede enlazar a: teams, players
players → puede enlazar a: teams, matches
tournament → puede contener sub-módulo: world_cup
```

---

## 4. Reglas de Desarrollo del Proyecto

### 4.1 Convención de Nombres

#### Archivos

```
Screens:           {feature}_screen.dart         (ej: matches_screen.dart)
Widgets:           {widget_name}.dart            (ej: match_card.dart)
Providers:         {feature}_providers.dart      (ej: matches_providers.dart)
Models:            {entity}_model.dart           (ej: match_model.dart)
Entities:          {entity}.dart                 (ej: match.dart)
Repositories:      {feature}_repository.dart    (ej: match_repository.dart)
UseCases:          {action}_usecase.dart        (ej: get_upcoming_matches_usecase.dart)
```

#### Clases

```
Screens:           MatchesScreen, MatchDetailScreen
Widgets:           MatchCard, MatchScoreBox
Models:            MatchModel
Entities:          Match, Team
Repositories:      MatchRepository (abstract), MatchRepositoryImpl
UseCases:          GetUpcomingMatchesUseCase
Providers:         matchesProvider, matchDetailProvider, matchesFilterProvider
Notifiers:         MatchesNotifier, MatchesFilterNotifier
```

#### Variables

```
boolean:           isLoading, hasError, canProceed
futures:           fetchMatches(), loadData()
streams:           stream, broadcastStream
collections:       matches, playerList, teamMap
constantes:        MATCH_CARD_HEIGHT, API_TIMEOUT (ALL_CAPS)
```

---

### 4.2 Estructura de Archivos

**Principio**: 1 archivo = 1 clase (excepto modelos pequeños o widgets atómicos).

✅ **CORRECTO**:
```
lib/features/matches/presentation/widgets/match_card.dart
└── class MatchCard extends StatelessWidget { ... }
```

❌ **INCORRECTO**:
```
lib/features/matches/presentation/widgets/all_widgets.dart
└── class MatchCard { }
└── class MatchScore { }
└── class MatchTeam { }
```

**Excepciones permitidas**:
- Widgets atómicos reutilizables en `core/widgets/` pueden estar juntos
- Modelos pequeños (enums, types) pueden agruparse

---

### 4.3 Componentes Reutilizables - Criterio

**Crear widget/componente reutilizable si**:
1. Se usa en 2+ pantallas
2. Resuelve un problema visual específico (card, botón, lista)
3. Merece documentación propia y variantes

**Ubicación**:
```
✅ GLOBAL (core/widgets/):     CustomButton, CustomChip, EmptyState
✅ LOCAL (features/{feature}/): MatchCard (solo en matches)
❌ Uno-off UI:                 inline en la pantalla
```

---

### 4.4 Providers por Feature

**Patrón Riverpod**:

1. **Service providers** (inyectables, globales)
   ```dart
   @riverpod
   MatchRepository matchRepository(MatchRepositoryRef ref) { ... }
   ```

2. **UseCase providers** (encapsulan lógica)
   ```dart
   @riverpod
   GetUpcomingMatchesUseCase getUpcomingMatchesUseCase(...) { ... }
   ```

3. **State providers** (datos ± Riverpod async)
   ```dart
   @riverpod
   class MatchesNotifier extends _$MatchesNotifier {
     @override
     Future<List<Match>> build() async { ... }
   }
   ```

4. **Filter/UI state providers** (estado local)
   ```dart
   @riverpod
   class MatchesFilterNotifier extends _$MatchesFilterNotifier {
     @override
     MatchesFilter build() => MatchesFilter.initial();
     void updateTeam(...) { ... }
   }
   ```

5. **Computed providers** (derivadas)
   ```dart
   @riverpod
   List<Match> filteredMatches(FilteredMatchesRef ref) { ... }
   ```

---

### 4.5 Manejo de Errores y Estados

#### Patrón AsyncValue

```dart
// State puede ser: loading, error, o data
ref.watch(matchesProvider).when(
  loading: () => ShimmerLoading(),
  error: (err, st) => ErrorDisplay(err, st),
  data: (data) => MatchesList(data),
);
```

#### Estados Típicos de UI

```dart
enum ScreenState { loading, empty, success, error }

// En un Notifier:
@riverpod
class MatchesScreenStateNotifier extends _$MatchesScreenStateNotifier {
  @override
  Future<MatchesScreenState> build() async {
    try {
      final matches = await ref.watch(matchesProvider.future);
      if (matches.isEmpty) {
        return MatchesScreenState(state: ScreenState.empty);
      }
      return MatchesScreenState(state: ScreenState.success, data: matches);
    } catch (e) {
      return MatchesScreenState(state: ScreenState.error, error: e);
    }
  }
}

// Widget:
switch (state.state) {
  case ScreenState.loading:
    return ShimmerLoading();
  case ScreenState.empty:
    return EmptyState(
      icon: Icons.sports_soccer,
      message: 'No hay partidos próximos',
    );
  case ScreenState.success:
    return MatchesList(state.data);
  case ScreenState.error:
    return ErrorWidget(error: state.error);
}
```

---

### 4.6 Documentación de Componentes

**Documentar con dartdoc**:

```dart
/// Muestra en una card compacta datos de un partido.
///
/// Parámetros:
/// - [match]: Entidad Match con datos del partido
/// - [onTap]: Callback cuando el usuario toca la card
/// - [showTeamLogo]: Si true, muestra logo de equipos (default: true)
///
/// Ejemplo:
/// ```dart
/// MatchCard(
///   match: myMatch,
///   onTap: () => context.push('/matches/${myMatch.id}'),
/// )
/// ```
class MatchCard extends StatelessWidget {
  final Match match;
  final VoidCallback? onTap;
  final bool showTeamLogo;

  const MatchCard({
    required this.match,
    this.onTap,
    this.showTeamLogo = true,
  });

  @override
  Widget build(BuildContext context) {
    // ...
  }
}
```

---

### 4.7 Escalabilidad y Preparación de Código

#### Lazy Loading de Módulos

```dart
GoRoute(
  path: '/world-cup',
  builder: (ctx, state) async =>
      (await dynamicImport('world_cup_module')).WorldCupHubScreen(),
)
```

#### Inyección de Dependencias Centralizada

```dart
// lib/core/providers/app_providers.dart
@riverpod
DioService dioService(DioServiceRef ref) { ... }
```

#### Versionado de API

```dart
class ApiConstants {
  static const String baseUrl = 'https://api.fcf-app.com';
  static const String apiVersion = '/v1';
  static const String matchesEndpoint = '$baseUrl$apiVersion/matches';
}
```

#### Feature Flags

```dart
@riverpod
class FeatureFlagsNotifier extends _$FeatureFlagsNotifier {
  @override
  FeatureFlags build() => FeatureFlags(
    worldCupEnabled: true,
    statisticsEnabled: false,
  );
}
```

---

## 5. Plan de Refactor por Fases

### FASE 0: Preparación (1-2 semanas)

**Tareas**:
- [ ] Crear rama `refactor/v2-architecture`
- [ ] Definir design system completo (colores, tipografía, componentes)
- [ ] Crear `core/design_system/` con paleta y estilos
- [ ] Definir estructura `core/widgets/` base (atoms + molecules)
- [ ] Completar `pubspec.yaml` con dependencias faltantes

**Dependencias a agregar**:
```yaml
dependencies:
  freezed_annotation: ^2.4.0
  json_serializable: ^6.7.0
  dio: ^5.3.0
  shared_preferences: ^2.2.0
  cached_network_image: ^3.3.0
  shimmer: ^3.0.0
  intl: ^0.19.0
  
dev_dependencies:
  build_runner: ^2.4.0
  freezed: ^2.4.0
```

**Outcome**: Proyecto limpio, dependencias listas, design system inicial.

---

### FASE 1: Base del Proyecto y Arquitectura (3-4 semanas)

**Tareas**:
- [ ] Estructura carpetas completa
- [ ] Configurar App Theme (colores, tipografía, componentes Material 3)
- [ ] Implementar `core/services/` (DioService, StorageService, NotificationService)
- [ ] Crear `core/models/` (ApiResponse, Result<T>, AppException)
- [ ] Crear `core/extensions/` (BuildContext, String, DateTime, WidgetRef)
- [ ] Configurar GoRouter completamente (shell routes + nested)
- [ ] Implementar `core/widgets/` básicos (CustomButton, CustomAppBar, etc.)
- [ ] Crear LocalDataSource mock para todos los módulos (JSONs en `assets/data/`)

**Outcome**: Proyecto estructurado, navegación funcional, componentes base, datos mock listos.

---

### FASE 2: Sistema de Diseño y Navegación (2-3 semanas)

**Tareas**:
- [ ] Completar `core/design_system/`
- [ ] Crear `core/widgets/common/` completo
- [ ] Crear `core/widgets/sports/`
- [ ] Implementar `ScaffoldWithNav`
- [ ] Diseñar y documentar componentes UI
- [ ] Probar navegación fluida

**Outcome**: Diseño visual consistente, componentes reutilizables, navegación fluida.

---

### FASE 3: Módulos Principales - Parte 1 (4-5 semanas)

**Implementar COMPLETO** (presentación + domain + data):

1. **Matches**
   - MatchesScreen + MatchDetailScreen
   - Data layer con JSON local
   - Providers (list, filter, detail)
   
2. **Teams**
   - TeamsScreen + TeamDetailScreen
   - Squad grid, stats
   - Data layer mock
   
3. **Players**
   - PlayersScreen + PlayerDetailScreen
   - Search, stats, career
   - Data layer mock

**Outcome**: 3 módulos completos funcionales con UI/UX profesional.

---

### FASE 4: Módulos Principales - Parte 2 (3-4 semanas)

**Implementar COMPLETO**:

1. **Tournaments** + **Standings** (integrados)
2. **News**
3. **Multimedia**

**Outcome**: 5/10 módulos de negocio completos.

---

### FASE 5: Home, Favorites, Settings, Integration (3-4 semanas)

1. **Home**
   - NextMatch hero card
   - RecentResults carrusel
   - FeaturedNews snippet
   - QuickStats tabla

2. **Favorites**
   - Sistema de favoritos (local storage)
   - CRUD de favoritos
   - Filtros

3. **Settings**
   - Idioma, notificaciones, tema
   - Storage de preferencias
   - About screen

4. **Integración**
   - Evitar duplicación de datos
   - Unified cache strategy

**Outcome**: 8/10 módulos, app funcional end-to-end.

---

### FASE 6: MÓDULO ESPECIAL - COPA DEL MUNDO (3-4 semanas)

**Implementar como módulo premium integrado**:

- [ ] WorldCupHubScreen (pantalla principal)
- [ ] WorldCupGroupsScreen (grupos A-H)
- [ ] WorldCupKnockoutScreen (cruces)
- [ ] WorldCupTeamDetailScreen
- [ ] WorldCupCalendarScreen (fixture completo)
- [ ] Providers específicos
- [ ] Data layer completo
- [ ] Animaciones y UX especial
- [ ] Integración con Tournaments

**Outcome**: Módulo Copa del Mundo completamente funcional, con identidad propia.

---

## 6.5 Arquitectura Backend (Spring Boot)

Stack definido:

- Spring Boot
- PostgreSQL
- JPA / Hibernate
- REST API
- Scheduler (para automatización futura)

Módulos backend:

- matches
- teams
- players
- tournaments
- standings
- world_cup
- news
- multimedia
- users (favoritos, preferencias)

Estructura sugerida:

src/main/java/com/layton/fcf/

  ├── config/
  ├── common/
  ├── modules/
  │   ├── matches/
  │   ├── teams/
  │   ├── players/
  │   ├── tournaments/
  │   ├── standings/
  │   ├── worldcup/
  │   ├── news/
  │   ├── multimedia/
  │   └── users/

Cada módulo:
- controller
- service
- repository
- entity
- dto

Regla:
Backend NO depende de Flutter.
Flutter depende del backend.

### FASE 7: Preparación para Backend Spring Boot (2-3 semanas)

- [ ] Reemplazar JSON mocks por API endpoints reales
- [ ] Configurar Dio service con interceptores (autenticación, errores)
- [ ] Implementar retry logic y offline support
- [ ] Tests de integración
- [ ] CI/CD setup si es necesario

**Outcome**: App lista para conectar con backend real.

---

### FASE 8: Pulido, Testing y Release (2-3 semanas)

- [ ] Tests unitarios (domain, data repositories)
- [ ] Tests de widget (UI)
- [ ] Performance optimization
- [ ] Crash reporting
- [ ] Analytics basic
- [ ] README y documentación
- [ ] Alpha/Beta testing

**Outcome**: App production-ready.

---

**Timeline total estimado**: 4-5 meses para MVP + Copa del Mundo completo.

---

## 6. Preparación para Backend Spring Boot

### 6.1 Desacoplamiento de JSON Mock

**Actualmente** (FASE 0-1):
```
assets/data/matches.json → LocalDataSource → Repository
```

**Meta** (FASE 7):
```
Backend Spring Boot API → RemoteDataSource (Dio) → Repository
```

#### Estrategia de Implementación

**1. Interfaz DataSource abstracta** (agnóstica a fuente):
```dart
abstract class MatchesDataSource {
  Future<List<MatchModel>> getUpcomingMatches();
  Future<MatchModel> getMatchDetail(String id);
}

// Implementación Local (temporal)
class MatchesLocalDataSourceImpl implements MatchesDataSource {
  Future<List<MatchModel>> getUpcomingMatches() async {
    final json = await rootBundle.loadString('assets/data/matches.json');
    final data = jsonDecode(json);
    return (data['matches'] as List)
        .map((m) => MatchModel.fromJson(m))
        .toList();
  }
}

// Implementación Remote (cuando backend esté listo)
class MatchesRemoteDataSourceImpl implements MatchesDataSource {
  final DioService dio;
  
  @override
  Future<List<MatchModel>> getUpcomingMatches() async {
    final response = await dio.get('/api/v1/matches/upcoming');
    return (response.data['data'] as List)
        .map((m) => MatchModel.fromJson(m))
        .toList();
  }
}
```

**2. Repository orquesta** (inyecta implementación):
```dart
class MatchRepositoryImpl implements MatchRepository {
  final MatchesDataSource dataSource; // puede ser Local o Remote
  
  MatchRepositoryImpl(this.dataSource);

  @override
  Future<List<Match>> getUpcomingMatches() async {
    final models = await dataSource.getUpcomingMatches();
    return models.map((m) => m.toEntity()).toList();
  }
}
```

**3. Provider decide** (sin cambiar presentación):
```dart
@riverpod
MatchesDataSource matchesDataSource(MatchesDataSourceRef ref) {
  final env = ref.watch(environmentProvider);
  
  if (env.useMockData) {
    return MatchesLocalDataSourceImpl(); // Fase 1-6
  } else {
    return MatchesRemoteDataSourceImpl(ref.watch(dioServiceProvider)); // Fase 7
  }
}

@riverpod
MatchRepository matchRepository(MatchRepositoryRef ref) {
  return MatchRepositoryImpl(ref.watch(matchesDataSourceProvider));
}
```

---

### 6.2 Estructura de Servicios y Repositorios

#### DioService (HTTP client centralizado)

```dart
@riverpod
DioService dioService(DioServiceRef ref) {
  final env = ref.watch(environmentProvider);
  
  final dio = Dio(
    BaseOptions(
      baseUrl: env.apiBaseUrl,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    ),
  );

  dio.interceptors.addAll([
    LoggingInterceptor(),
    AuthInterceptor(ref.watch(authTokenProvider)),
    RetryInterceptor(dio),
  ]);

  return DioService(dio);
}

class DioService {
  final Dio _dio;

  DioService(this._dio);

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get<T>(path, queryParameters: queryParameters);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    required Map<String, dynamic> data,
  }) async {
    try {
      return await _dio.post<T>(path, data: data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  AppException _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return NetworkException('Conexión expirada');
        case DioExceptionType.receiveTimeout:
          return NetworkException('Tiempo límite excedido');
        case DioExceptionType.badResponse:
          return ServerException('Error ${error.response?.statusCode}');
        default:
          return NetworkException('Error de red');
      }
    }
    return UnknownException(error.toString());
  }
}
```

---

### 6.3 Capa de Red - Preparación

```dart
// core/models/app_exception.dart
abstract class AppException implements Exception {
  final String message;
  AppException(this.message);
}

class NetworkException extends AppException {
  NetworkException(super.message);
}

class ServerException extends AppException {
  ServerException(super.message);
}

class ParseException extends AppException {
  ParseException(super.message);
}

class UnknownException extends AppException {
  UnknownException(super.message);
}

// core/models/result.dart
@freezed
class Result<T> with _$Result<T> {
  const factory Result.success(T data) = _Success;
  const factory Result.failure(AppException error) = _Failure;

  T getOrNull() => maybeMap(
    success: (res) => res.data,
    orElse: () => null,
  );
}
```

**UseCases devuelven Result**:

```dart
class GetUpcomingMatchesUseCase {
  final MatchRepository repository;

  GetUpcomingMatchesUseCase(this.repository);

  Future<Result<List<Match>>> call() async {
    try {
      final matches = await repository.getUpcomingMatches();
      return Result.success(matches);
    } on AppException catch (e) {
      return Result.failure(e);
    }
  }
}
```

---

### 6.4 Endpoints Esperados del Backend

**Propuesta de estructura REST**:

```
GET    /api/v1/matches/upcoming          → List<Match>
GET    /api/v1/matches/recent            → List<Match>
GET    /api/v1/matches/:id               → Match + details + lineup
GET    /api/v1/teams                     → List<Team>
GET    /api/v1/teams/:id                 → Team + squad + stats
GET    /api/v1/players                   → List<Player> (con filtros)
GET    /api/v1/players/search            → List<Player>
GET    /api/v1/players/:id               → Player + career + stats
GET    /api/v1/tournaments               → List<Tournament>
GET    /api/v1/tournaments/:id           → Tournament + standings
GET    /api/v1/standings                 → Standings (tabla)
GET    /api/v1/news                      → List<News>
GET    /api/v1/news/:id                  → News detail
GET    /api/v1/world-cup/editions        → List<WorldCupEdition>
GET    /api/v1/world-cup/:editionId/groups    → WorldCup Groups + standings
GET    /api/v1/world-cup/:editionId/knockout  → WorldCup Knockout bracket
GET    /api/v1/multimedia                → List<Multimedia>
GET    /api/v1/multimedia/:id            → Multimedia + media files
POST   /api/v1/favorites                 → Add favorite
DELETE /api/v1/favorites/:id             → Remove favorite
GET    /api/v1/user/preferences          → User settings
PUT    /api/v1/user/preferences          → Update settings
```

---

## 7. Árbol de Carpetas Detallado

```
fcf_colombia_by_layton/
├── assets/
│   ├── data/
│   │   ├── matches.json
│   │   ├── teams.json
│   │   ├── players.json
│   │   ├── tournaments.json
│   │   ├── world_cup.json
│   │   ├── news.json
│   │   └── multimedia.json
│   ├── fonts/
│   │   ├── inter/
│   │   │   ├── Inter-Regular.ttf
│   │   │   ├── Inter-SemiBold.ttf
│   │   │   └── Inter-Bold.ttf
│   │   └── roboto_mono/
│   │       ├── RobotoMono-Regular.ttf
│   │       └── RobotoMono-Bold.ttf
│   └── images/
│       ├── logos/
│       ├── teams/
│       ├── players/
│       ├── banners/
│       └── illustrations/
│
├── lib/
│   ├── main.dart
│   ├── app_router.dart
│   │
│   ├── core/
│   │   ├── config/
│   │   │   ├── app_theme.dart
│   │   │   ├── app_constants.dart
│   │   │   └── environment.dart
│   │   ├── design_system/
│   │   │   ├── colors.dart
│   │   │   ├── typography.dart
│   │   │   ├── spacing.dart
│   │   │   ├── shadows.dart
│   │   │   ├── icons.dart
│   │   │   └── theme_data.dart
│   │   ├── widgets/
│   │   │   ├── common/
│   │   │   │   ├── custom_button.dart
│   │   │   │   ├── custom_app_bar.dart
│   │   │   │   ├── custom_text_field.dart
│   │   │   │   ├── custom_chip.dart
│   │   │   │   ├── custom_badge.dart
│   │   │   │   ├── custom_bottom_nav.dart
│   │   │   │   ├── custom_divider.dart
│   │   │   │   ├── custom_icon_button.dart
│   │   │   │   ├── shimmer_loading.dart
│   │   │   │   ├── empty_state.dart
│   │   │   │   ├── error_widget.dart
│   │   │   │   └── loading_dialog.dart
│   │   │   ├── sports/
│   │   │   │   ├── match_score_card.dart
│   │   │   │   ├── player_card.dart
│   │   │   │   ├── team_badge.dart
│   │   │   │   ├── lineup_card.dart
│   │   │   │   ├── stat_item.dart
│   │   │   │   ├── rating_bar.dart
│   │   │   │   └── stat_comparison.dart
│   │   │   └── layouts/
│   │   │       ├── scaffold_with_nav.dart
│   │   │       └── centered_layout.dart
│   │   ├── services/
│   │   │   ├── dio_service.dart
│   │   │   ├── storage_service.dart
│   │   │   ├── notification_service.dart
│   │   │   └── analytics_service.dart
│   │   ├── models/
│   │   │   ├── api_response.dart
│   │   │   ├── result.dart
│   │   │   ├── app_exception.dart
│   │   │   ├── paginated_response.dart
│   │   │   └── filter.dart
│   │   ├── extensions/
│   │   │   ├── build_context_ext.dart
│   │   │   ├── string_ext.dart
│   │   │   ├── date_time_ext.dart
│   │   │   ├── widget_ref_ext.dart
│   │   │   └── list_ext.dart
│   │   ├── utils/
│   │   │   ├── logger.dart
│   │   │   ├── validation.dart
│   │   │   ├── formatters.dart
│   │   │   └── constants.dart
│   │   └── providers/
│   │       ├── app_providers.dart
│   │       ├── auth_providers.dart
│   │       ├── app_state_providers.dart
│   │       └── feature_flags_providers.dart
│   │
│   ├── features/
│   │   │
│   │   ├── home/
│   │   │   ├── presentation/
│   │   │   │   ├── screens/
│   │   │   │   │   └── home_screen.dart
│   │   │   │   ├── widgets/
│   │   │   │   │   ├── next_match_hero.dart
│   │   │   │   │   ├── recent_results_carousel.dart
│   │   │   │   │   ├── featured_news_snippet.dart
│   │   │   │   │   └── quick_stats_section.dart
│   │   │   │   └── providers/
│   │   │   │       └── home_providers.dart
│   │   │   ├── domain/
│   │   │   └── data/
│   │   │
│   │   ├── matches/
│   │   │   ├── presentation/
│   │   │   │   ├── screens/
│   │   │   │   │   ├── matches_screen.dart
│   │   │   │   │   ├── match_detail_screen.dart
│   │   │   │   │   └── match_tabs/
│   │   │   │   ├── widgets/
│   │   │   │   └── providers/
│   │   │   ├── domain/
│   │   │   └── data/
│   │   │
│   │   ├── teams/
│   │   │   ├── presentation/
│   │   │   ├── domain/
│   │   │   └── data/
│   │   │
│   │   ├── players/
│   │   │   ├── presentation/
│   │   │   ├── domain/
│   │   │   └── data/
│   │   │
│   │   ├── tournaments/
│   │   │   ├── presentation/
│   │   │   ├── domain/
│   │   │   └── data/
│   │   │
│   │   ├── world_cup/                    [⭐ MÓDULO ESPECIAL]
│   │   │   ├── presentation/
│   │   │   │   ├── screens/
│   │   │   │   │   ├── world_cup_hub_screen.dart
│   │   │   │   │   ├── world_cup_groups_screen.dart
│   │   │   │   │   ├── world_cup_knockout_screen.dart
│   │   │   │   │   ├── world_cup_team_detail_screen.dart
│   │   │   │   │   └── world_cup_calendar_screen.dart
│   │   │   │   ├── widgets/
│   │   │   │   └── providers/
│   │   │   ├── domain/
│   │   │   └── data/
│   │   │
│   │   ├── standings/
│   │   ├── news/
│   │   ├── multimedia/
│   │   ├── favorites/
│   │   └── settings/
│   │
│   └── test/
│       ├── unit/
│       ├── widget/
│       └── integration/
│
├── analysis_options.yaml
├── pubspec.yaml
├── pubspec.lock
├── README.md
├── .gitignore
├── ARCHITECTURE_AND_DESIGN.md         [ESTE ARCHIVO]
│
└── documentation/
    ├── DEVELOPMENT_GUIDE.md
    ├── API_INTEGRATION.md
    └── DESIGN_SYSTEM.md
```

---

## 8. Propuesta de Navegación Principal

```
┌────────────────────────────────────────────────────────┐
│ APPBAR (contexto adaptable)                            │
├────────────────────────────────────────────────────────┤
│                                                        │
│  MAIN CONTENT AREA (scrollable / tabable)              │
│  ├─ Home: Summary, próximos, noticias                 │
│  ├─ Matches: Upcoming / Results con filtro            │
│  ├─ All Hub:                                           │
│  │   ├─ Teams (grid / list)                           │
│  │   ├─ Players (search + list)                       │
│  │   ├─ Tournaments (list + standings)                │
│  │   ├─ Standings (tabla)                             │
│  │   ├─ News (feed)                                   │
│  │   └─ Multimedia (gallery)                          │
│  ├─ Favorites: Items favoritos filtrados              │
│  └─ Settings: Preferencias                            │
│                                                        │
├────────────────────────────────────────────────────────┤
│ BOTTOM TAB NAVIGATION (Sticky)                         │
│ 🏠Home │ ⚽Matches │ 📊All │ ⭐Favorites │ ⚙️Settings │
└────────────────────────────────────────────────────────┘
```

### Detail Screens (push por encima)

- MatchDetail
- TeamDetail
- PlayerDetail
- NewsDetail
- TournamentDetail
- WorldCupHub

### Full-screen Modals

- VideoPlayer (Multimedia)
- GalleryViewer (Multimedia)
- ImageZoom (Multimedia)

---

## Modelo de Datos Inicial (Base)

Entidades principales:

Match:
- id
- homeTeamId
- awayTeamId
- date
- status
- homeScore
- awayScore
- tournamentId

Team:
- id
- name
- logo
- country

Player:
- id
- name
- teamId
- position
- number

Tournament:
- id
- name
- type (league, cup, world_cup)

Standing:
- teamId
- points
- position

WorldCupGroup:
- groupName
- teams[]

WorldCupMatch:
- group / knockout

## 9. Pantallas Recomendadas para V1

| Pantalla | Componentes | Datos | Fase |
|----------|------------|-------|------|
| **HomeScreen** | NextMatchHero, RecentResults, FeaturedNews, QuickStats | Mock | 1 |
| **MatchesScreen** | UpcomingTab/ResultsTab, FilterChips, MatchCards | Mock | 1 |
| **MatchDetailScreen** | Hero header, Tabs, RelatedMatches | Mock | 1 |
| **TeamsScreen** | TeamList/Grid, SearchBar, FilterChips | Mock | 1 |
| **TeamDetailScreen** | BannerHero, SquadGrid, StatsCard, RecentMatches | Mock | 1 |
| **PlayersScreen** | PlayerList, SearchBar, FilterChips | Mock | 1 |
| **PlayerDetailScreen** | PlayerHero, StatCards, CareerTimeline, Achievements | Mock | 1 |
| **TournamentsScreen** | TournamentCards, FilterChips, Standings preview | Mock | 1 |
| **StandingsScreen** | StandingsTable, Tournament selector | Mock | 1 |
| **WorldCupHubScreen** | Tabs (Grupos/Cruces/Calendario), Hero banner | Mock | 1 |
| **WorldCupGroupsScreen** | A-H cards, Group table, team standings | Mock | 1 |
| **WorldCupKnockoutScreen** | Knockout bracket visual, Match details | Mock | 1 |
| **NewsScreen** | NewsFeed, FilterChips, SearchBar | Mock | 1 |
| **NewsDetailScreen** | ArticleContent, RelatedNews, ShareButtons | Mock | 1 |
| **MultimediaScreen** | MediaGrid, FilterChips | Mock | 1 |
| **FavoritesScreen** | FavoritesList, FilterChips | Local storage | 1 |
| **SettingsScreen** | SettingsTiles, Language/Notifications/About | Local storage | 1 |

**Total para V1**: 17 pantallas completamente funcionales.

---

## 10. Componentes Base Reutilizables

### ATOMS (Componentes Micro)

#### 1. CustomButton

```dart
CustomButton(
  label: 'Ver Detalle',
  variant: ButtonVariant.primary,       // primary, secondary, ghost, filled
  onPressed: () { },
  isLoading: false,
  size: ButtonSize.large,               // small, medium, large
)
```

**Variantes**: Primary (azul fondo), Secondary (borde azul), Ghost (sin borde), Filled (color de acento)

#### 2. CustomChip

```dart
CustomChip(
  label: 'Próximos',
  isSelected: true,
  onTap: () { },
  variant: ChipVariant.filter,          // filter, status, tag
)
```

#### 3. CustomBadge

```dart
CustomBadge(
  label: '2',
  backgroundColor: Colors.red,
  textColor: Colors.white,
)
```

#### 4. CustomDivider

```dart
CustomDivider(
  color: AppColors.divider,
  height: 1,
  margin: EdgeInsets.symmetric(vertical: 16),
)
```

#### 5. CustomIconButton

```dart
CustomIconButton(
  icon: Icons.favorite,
  onPressed: () { },
  isFilled: true,
  size: 24,
)
```

---

### MOLECULES (Componentes Simples)

#### 1. MatchScoreCard

```dart
MatchScoreCard(
  homeTeam: 'Colombia',
  awayTeam: 'Uruguay',
  homeGoals: 2,
  awayGoals: 1,
  onTap: () { },
)
```

#### 2. PlayerCard

```dart
PlayerCard(
  player: playerEntity,
  onTap: () { },
  showStats: true,
)
```

#### 3. TeamBadge

```dart
TeamBadge(
  team: teamEntity,
  size: TeamBadgeSize.medium,           // small, medium, large
)
```

#### 4. StatItem

```dart
StatItem(
  icon: Icons.sports,
  value: '42',
  label: 'Partidos',
  color: Colors.blue,
)
```

#### 5. NewsCardSmall

```dart
NewsCardSmall(
  news: newsEntity,
  onTap: () { },
)
```

#### 6. EmptyState

```dart
EmptyState(
  icon: Icons.sports_soccer,
  title: 'Sin partidos',
  message: 'No hay partidos próximos',
  actionLabel: 'Ver resultados',
  onAction: () { },
)
```

#### 7. RatingBar

```dart
RatingBar(
  rating: 4.5,
  maxRating: 5,
  onRatingChanged: (newRating) { },
)
```

---

### ORGANISMS (Componentes Complejos)

#### 1. MatchCard

```dart
MatchCard(
  match: matchEntity,
  variant: MatchCardVariant.compact,     // compact, expanded
  onTap: () { },
  showTeamLogo: true,
)
```

#### 2. LineupSection

```dart
LineupSection(
  homeLineup: List<Player>,
  awayLineup: List<Player>,
  homeFormation: '4-3-3',
  awayFormation: '4-2-3-1',
)
```

#### 3. StandingsTable

```dart
StandingsTable(
  standings: List<ClubStanding>,
  onTeamTap: (team) { },
  showRanking: true,
)
```

#### 4. TournamentCard

```dart
TournamentCard(
  tournament: tournamentEntity,
  showStandings: true,
  onTap: () { },
)
```

#### 5. NewsFeed

```dart
NewsFeed(
  news: List<News>,
  onNewsTap: (news) { },
  isLoading: false,
  hasMore: true,
  onLoadMore: () { },
)
```

#### 6. CustomBottomNav

```dart
CustomBottomNav(
  currentIndex: 0,
  onChanged: (index) { },
  items: [
    BottomNavItem(icon: Icons.home, label: 'Inicio'),
    // ...
  ],
  backgroundColor: AppColors.surface,
  activeColor: AppColors.primary,
)
```

#### 7. ScaffoldWithNav (Principal)

```dart
ScaffoldWithNav(
  currentTab: TabType.home,
  onTabChanged: (tab) { },
  body: homeScreen,
)
```

## MVP REAL (PRIMERA VERSIÓN FUNCIONAL)

PRIORIDAD 1:
- Home
- Matches (list + detail)
- Teams (list + detail)
- Players (list + detail)

PRIORIDAD 2:
- Standings
- Tournaments
- Favorites

PRIORIDAD 3:
- News
- Multimedia

PRIORIDAD 4:
- World Cup (versión básica)

Regla:
No construir todo al tiempo.
Primero funcional, luego completo.

## Regla de Oro del Proyecto

NINGUNA pantalla debe consumir datos directamente.

Siempre:

UI → Provider → UseCase → Repository → DataSource

Prohibido:
- Leer JSON directo en UI
- Llamar API desde Widget
- Mezclar lógica de negocio con UI

---

## 11. Resumen Ejecutivo y Próximos Pasos

### VISIÓN DEL PRODUCTO

No es solo una app de fútbol.

Es una plataforma propia de contenido y seguimiento del fútbol colombiano, con control total de datos, sin dependencia de APIs externas, diseñada para escalar a múltiples competiciones y eventos globales (como la Copa del Mundo).

Diferenciadores:
- Datos controlados por nosotros (no dependencia externa)
- Contenido editorial propio (no solo resultados)
- Módulos especiales como Copa del Mundo con experiencia premium
- Base para monetización futura (ads, patrocinios, data)

### Recomendaciones Finales Como Arquitecto Senior

#### 1. REPLANTEAR ES LO CORRECTO

- El proyecto actual tiene estructura básica, pero no es suficiente para producto de valor real.
- Propuesta: Rebuild siguiendo esta arquitectura completa = base sólida para 2-3 años de crecimiento.

#### 2. PRIORIDADES EN ORDEN

1. **Diseño visual** → Establecer identidad, no ser genérico
2. **Arquitectura limpia** → Separación capas, escalabilidad
3. **Módulos core** → Matches, Teams, Players (80% del valor)
4. **Copa del Mundo** → Módulo especial desde día 1, no parche
5. **Backend** → Ready para integración Spring Boot sin cambios masivos

#### 3. STACK SELECCIONADO ✅

- Flutter + Riverpod + GoRouter = opción correcta
- Material 3 + custom theme = diseño moderno + control
- Clean Architecture = mantenibilidad futura

#### 4. TIMELINE REALISTA

- MVP (8 pantallas principales): 6-8 semanas
- MVP+ (17 pantallas + Copa del Mundo): 12-14 semanas
- Listo para backend: 16 semanas

#### 5. NO HACER

- ❌ Mantener diseño genérico/plano
- ❌ Saltar documentación de componentes
- ❌ Crear hard-dependencies a JSON mock
- ❌ Olvidar que Copa del Mundo es "módulo especial"

#### 6. DECISIÓN PRINCIPAL RECOMENDADA

**Hacer full rebuild desde cero siguiendo esta estructura.** Es más limpio que adaptar lo existente.

---

### Próximos Pasos Recomendados

1. ✅ **Generar árbol de carpetas** en el proyecto
2. ✅ **Crear archivos base** (theme, constantes, widgets core)
3. ✅ **Implementar navegación GoRouter** completa
4. ✅ **Crear primeros modelos y providers** de ejemplo
5. ✅ **Generar datos mock** (JSON en assets/)
6. ✅ **Documentar reglas** en DEVELOPMENT_GUIDE.md

---

### Documentos de Referencia Recomendados

- `ARCHITECTURE_AND_DESIGN.md` ← ESTE ARCHIVO (referencia principal)
- `DEVELOPMENT_GUIDE.md` (reglas prácticas día a día)
- `API_INTEGRATION.md` (integración con backend)
- `DESIGN_SYSTEM.md` (guía de componentes y colores)

---

**¿Listo para convertir esta visión en código?**

---

*Documento creado: Abril 2026*  
*Versión: 1.0*  
*Autor: Equipo Arquitectura FCF Colombia*
