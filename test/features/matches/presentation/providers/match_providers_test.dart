import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fcf_colombia_by_layton/features/matches/presentation/providers/match_providers.dart';

void main() {
  group('MatchProviders', () {
    test('upcomingMatchesProvider should fetch data', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final result = await container.read(upcomingMatchesProvider.future);

      expect(result.isNotEmpty, true);
    });

    test('recentMatchesProvider should fetch data', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final result = await container.read(recentMatchesProvider.future);

      expect(result.isNotEmpty, true);
    });
  });
}