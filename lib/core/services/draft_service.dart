import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DraftService {
  static const String _draftKeyPrefix = 'registration_draft_';

  Future<void> saveDraft(String companyType, Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_draftKeyPrefix$companyType';
    await prefs.setString(key, jsonEncode(data));
  }

  Future<Map<String, dynamic>?> getDraft(String companyType) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_draftKeyPrefix$companyType';
    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    }
    return null;
  }

  Future<void> clearDraft(String companyType) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_draftKeyPrefix$companyType';
    await prefs.remove(key);
  }
}
