import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _userKey = 'user_data';
  static const String _workoutsKey = 'workouts_data';

  Future<Map<String, dynamic>?> getUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userString = prefs.getString(_userKey);
      if (userString != null) {
        return json.decode(userString);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to load user data: $e');
    }
  }

  Future<void> saveUser(Map<String, dynamic> userData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userKey, json.encode(userData));
    } catch (e) {
      throw Exception('Failed to save user data: $e');
    }
  }

  Future<void> clearUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userKey);
    } catch (e) {
      throw Exception('Failed to clear user data: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getWorkouts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final workoutsString = prefs.getString(_workoutsKey);
      if (workoutsString != null) {
        final List<dynamic> workoutsList = json.decode(workoutsString);
        return workoutsList.cast<Map<String, dynamic>>();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to load workouts: $e');
    }
  }

  Future<void> saveWorkouts(List<Map<String, dynamic>> workouts) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_workoutsKey, json.encode(workouts));
    } catch (e) {
      throw Exception('Failed to save workouts: $e');
    }
  }

  Future<void> clearWorkouts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_workoutsKey);
    } catch (e) {
      throw Exception('Failed to clear workouts: $e');
    }
  }

  Future<void> clearAllData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } catch (e) {
      throw Exception('Failed to clear all data: $e');
    }
  }
}
