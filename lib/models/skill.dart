class Skill {
  const Skill({
    required this.name,
    required this.currentCount,
    required this.goal,
    required this.lastUpdated,
  });

  factory Skill.initial() {
    return Skill(
      name: 'Deliberate Practice',
      currentCount: 0,
      goal: defaultGoal,
      lastUpdated: DateTime.now().toUtc(),
    );
  }

  factory Skill.fromJson(Map<String, Object?> json) {
    return Skill(
      name: json['name'] as String? ?? 'Deliberate Practice',
      currentCount: json['currentCount'] as int? ?? 0,
      goal: json['goal'] as int? ?? defaultGoal,
      lastUpdated:
          DateTime.tryParse(json['lastUpdated'] as String? ?? '')?.toUtc() ??
          DateTime.now().toUtc(),
    );
  }

  static const int defaultGoal = 10000;

  final String name;
  final int currentCount;
  final int goal;
  final DateTime lastUpdated;

  int get remaining => (goal - currentCount).clamp(0, goal);

  double get progress {
    if (goal <= 0) {
      return 0;
    }

    return (currentCount / goal).clamp(0, 1);
  }

  bool get isComplete => currentCount >= goal;

  Skill copyWith({
    String? name,
    int? currentCount,
    int? goal,
    DateTime? lastUpdated,
  }) {
    return Skill(
      name: name ?? this.name,
      currentCount: currentCount ?? this.currentCount,
      goal: goal ?? this.goal,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'name': name,
      'currentCount': currentCount,
      'goal': goal,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}
