import 'forbidden_sequences.dart';
import 'substitutions.dart';


List<String> generateSpellingVariations({
    required String word,
    required int n,
    required int maxCost,
    int substitutionPenalty = 0,
    List<(String, String, int)> rules = spellfixRules,
    Iterable<String> forbiddenSequences = forbiddenSequences,
}) {
    final res = <String>[]; // Variations returned in increasing-cost order.
    final best = <String, Map<String, _Score>>{
        word: {'': const _Score(0, 0)},
    }; // Track cheapest score per word/history signature.
    final q = <_State>[
        _State(word, 0, 0, 0, const <int>{}, ''),
    ]; // Priority queue ordered by tiered cost.

    void push(
      String next,
      int directCost,
      int steps,
      Set<int> appliedKeys,
      String historyKey,
    ) {
        if (_containsForbiddenSequence(next, forbiddenSequences)) return; // Skip words containing banned fragments.
        final totalCost = directCost + steps * substitutionPenalty; // Combine direct cost with per-step penalty.
        if (totalCost > maxCost) return;
        final entry = best.putIfAbsent(next, () => <String, _Score>{});
        final prev = entry[historyKey];
        if (prev != null) {
            if (prev.directCost < directCost) return; // Already have a cheaper direct cost.
            if (prev.directCost == directCost && prev.steps <= steps) return; // Same direct cost with fewer or equal substitutions.
        }
        entry[historyKey] = _Score(directCost, steps);
        q.add(
          _State(
            next,
            directCost,
            steps,
            totalCost,
            Set<int>.unmodifiable(appliedKeys),
            historyKey,
          ),
        );
    }

    while (q.isNotEmpty && res.length < n) {
        q.sort(); // Process the state with the lowest tiered cost first.
        final state = q.removeAt(0);
        final score = best[state.word]?[state.historyKey];
        if (score == null || !score.matches(state)) continue; // Ignore stale entries.
        final s = state.word;
        if (state.steps > 0) {
            res.add(s); // Collect only mutated forms.
            if (res.length >= n) break;
        }

        for (var ruleIndex = 0; ruleIndex < rules.length; ruleIndex++) {
            final rule = rules[ruleIndex];
            for (var i = s.indexOf(rule.$1); i != -1; i = s.indexOf(rule.$1, i + 1)) {
                final opKey = _encodeApplied(ruleIndex, i);
                if (state.appliedKeys.contains(opKey)) continue; // Skip repeating the same substitution at the same position.
                final nextWord = s.replaceRange(i, i + rule.$1.length, rule.$2);
                final nextApplied = Set<int>.of(state.appliedKeys)..add(opKey);
                push(
                    nextWord,
                    state.directCost + rule.$3,
                    state.steps + 1,
                    nextApplied,
                    _historyKeyFor(nextApplied),
                ); // Apply substitution rule and account for both cost tiers.
            }
        }
    }

    return res;
}

class _State implements Comparable<_State> {
    _State(
        this.word,
        this.directCost,
        this.steps,
        this.totalCost,
        this.appliedKeys,
        this.historyKey,
    );
    final String word;
    final int directCost;
    final int steps;
    final int totalCost;
    final Set<int> appliedKeys;
    final String historyKey;

    @override
    int compareTo(_State other) {
        final totalComparison = totalCost - other.totalCost;
        if (totalComparison != 0) return totalComparison;
        final directComparison = directCost - other.directCost;
        if (directComparison != 0) return directComparison;
        return steps - other.steps;
    }
}


int _encodeApplied(int ruleIndex, int position) =>
    (ruleIndex << 32) ^ position; // Combine rule and position into a unique key.

String _historyKeyFor(Set<int> applied) {
    if (applied.isEmpty) return '';
    final sorted = applied.toList()..sort();
    return sorted.join(',');
}

bool _containsForbiddenSequence(String word, Iterable<String> forbidden) {
    for (final pattern in forbidden) {
        if (pattern.isEmpty) continue;
        if (_matchesForbidden(word, pattern)) return true;
    }
    return false;
}

bool _matchesForbidden(String word, String pattern) {
    final hasRegexMeta = pattern.contains(RegExp(r'[\\\^\$\.\[\]\(\)\|\?\*\+]'));
    if (hasRegexMeta) {
        return RegExp(pattern, unicode: true).hasMatch(word);
    }
    return word.contains(pattern);
}

class _Score {
    const _Score(this.directCost, this.steps);
    final int directCost;
    final int steps;

    bool matches(_State state) =>
        directCost == state.directCost && steps == state.steps;
}