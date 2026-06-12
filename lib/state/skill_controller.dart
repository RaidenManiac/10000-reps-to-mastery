import 'package:flutter/foundation.dart';

import '../models/skill.dart';
import '../storage/skill_storage.dart';

class SkillController extends ChangeNotifier {
  SkillController({required this.storage});

  final SkillStorage storage;

  Skill _skill = Skill.initial();
  bool _isLoading = true;
  int? _previousCount;

  Skill get skill => _skill;

  bool get isLoading => _isLoading;

  bool get canUndo => _previousCount != null;

  Future<void> initialize() async {
    _skill = await storage.loadSkill() ?? Skill.initial();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> increment() async {
    _previousCount = _skill.currentCount;
    _skill = _skill.copyWith(
      currentCount: _skill.currentCount + 1,
      lastUpdated: DateTime.now().toUtc(),
    );
    notifyListeners();
    await storage.saveSkill(_skill);
  }

  Future<void> undoLastIncrement() async {
    final restoredCount = _previousCount;
    if (restoredCount == null) {
      return;
    }

    _previousCount = null;
    _skill = _skill.copyWith(
      currentCount: restoredCount,
      lastUpdated: DateTime.now().toUtc(),
    );
    notifyListeners();
    await storage.saveSkill(_skill);
  }
}
