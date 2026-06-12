import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/skill.dart';

abstract interface class SkillStorage {
  Future<Skill?> loadSkill();

  Future<void> saveSkill(Skill skill);
}

class SharedPreferencesSkillStorage implements SkillStorage {
  const SharedPreferencesSkillStorage(this._preferences);

  static const String _skillKey = 'mastery.skill.v1';

  final SharedPreferences _preferences;

  @override
  Future<Skill?> loadSkill() async {
    final encodedSkill = _preferences.getString(_skillKey);
    if (encodedSkill == null) {
      return null;
    }

    final decodedSkill = jsonDecode(encodedSkill);
    if (decodedSkill is! Map<String, Object?>) {
      return null;
    }

    return Skill.fromJson(decodedSkill);
  }

  @override
  Future<void> saveSkill(Skill skill) {
    return _preferences.setString(_skillKey, jsonEncode(skill.toJson()));
  }
}
