# MATCHES MODULE - Quick Reference

## 📁 Structure

```
lib/features/matches/
├── domain/
│   ├── entities/: match.dart, team.dart
│   ├── repositories/: match_repository.dart
│   └── usecases/: get_upcoming_matches_usecase.dart, get_recent_matches_usecase.dart, get_match_detail_usecase.dart
├── data/
│   ├── datasources/: matches_remote_datasource[_impl].dart, matches_local_datasource[_impl].dart
│   ├── models/: match_model.dart, team_model.dart
│   └── repositories/: match_repository_impl.dart
└── presentation/
    ├── screens/: matches_screen.dart, match_detail_screen.dart
    ├── widgets/: match_card.dart
    └── providers/: match_providers.dart
```

## 🔌 Providers Usage

```dart
// En cualquier widget ConsumerWidget/ConsumerStatefulWidget:

// Watch upcoming matches
final upcomingState = ref.watch(upcomingMatchesProvider);
upcomingState.when(
  loading: () => Loader(),
  error: (e, st) => ErrorWidget(),
  data: (matches) => ListView(...),
);

// Watch recent matches
final recentState = ref.watch(recentMatchesProvider);

// Watch specific match
final matchState = ref.watch(matchDetailProvider('match-id-123'));

// Manual refresh
ref.read(upcomingMatchesProvider.notifier).refresh();
ref.read(recentMatchesProvider.notifier).refresh();

// Filter by tournament
ref.read(selectedTournamentProvider.notifier).state = 'Eliminatoria 2026';
final filteredMatches = ref.watch(matchesByTournamentProvider);
```

## ✅ Endpoints Connected

```
GET /api/v1/matches/upcoming           ← upcomingMatchesProvider
GET /api/v1/matches/recent             ← recentMatchesProvider
GET /api/v1/matches/{id}               ← matchDetailProvider(id)
GET /api/v1/matches/tournament/{name}  ← matchesByTournamentProvider
GET /api/v1/matches/team/{name}        ← matchesByTeamProvider
```

## 🏗️ Data Flow

```
MatchesScreen
    ↓ ref.watch()
upcomingMatchesProvider (AsyncNotifier)
    ↓ depends on
GetUpcomingMatchesUseCase
    ↓ calls
MatchRepository (impl)
    ↓ tries
RemoteDataSource (DioService → API)
    ↙ or fallback
LocalDataSource (in-memory cache)
    ↓
Match Entity objects
    ↓
MatchCard widgets
```

## 🎯 Common Tasks

### Display upcoming matches
```dart
final matches = ref.watch(upcomingMatchesProvider);
matches.when(
  data: (m) => ListView.builder(
    itemCount: m.length,
    itemBuilder: (c, i) => MatchCard(match: m[i]),
  ),
  ...
);
```

### Navigate to match detail
```dart
context.push('/matches/${match.id}');
```

### Refresh matches
```dart
ElevatedButton(
  onPressed: () => ref.refresh(upcomingMatchesProvider),
  child: Text('Refresh'),
);
```

### Filter by tournament
```dart
ref.read(selectedTournamentProvider.notifier).state = 'Torneyname';
final filtered = ref.watch(matchesByTournamentProvider);
```

## 🔑 Key Classes

| Class | Purpose |
|-------|---------|
| `Match` | Entity domain |
| `MatchModel` | DTO (freezed) |
| `MatchRepository` | Contrato (abstract) |
| `MatchRepositoryImpl` | Impl + caché |
| `RemoteDataSource` | API access |
| `LocalDataSource` | Caché fallback |
| `MatchCard` | Reutilizable widget |

## 🚨 Error Handling

```dart
// Automático en datasources
try {
  // remote
} catch (e) {
  // local fallback
}

// En UI
.when(
  error: (err, st) => ErrorWidget(
    message: 'Error cargando partidos',
    onRetry: () => ref.refresh(upcomingMatchesProvider),
  ),
);
```

## 📝 Logs

```
Network:  AppLogger.network('→ GET /api/v1/matches/upcoming')
Success:  AppLogger.info('Fetching upcoming matches from backend')
Error:    AppLogger.error('Error fetching matches', exception)
```

---

**Last Update**: Abril 2026  
**Status**: ✅ Production Ready
