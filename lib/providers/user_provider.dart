import 'package:flutter/foundation.dart';
import '../models/user.dart' as models;
import '../services/storage_service.dart';

class UserProvider with ChangeNotifier {
  models.AppUser? _user;
  final StorageService _storageService = StorageService();

  models.AppUser? get user => _user;

  Future<void> loadUser() async {
    try {
      final userData = await _storageService.getUser();
      if (userData != null) {
        _user = models.AppUser.fromJson(userData);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading user: $e');
    }
  }

  Future<void> updateUser(models.AppUser user) async {
    try {
      await _storageService.saveUser(user.toJson());
      _user = user;
      notifyListeners();
    } catch (e) {
      debugPrint('Error updating user: $e');
    }
  }

  Future<void> createUser({
    required String fullName,
    required String email,
    required int age,
    required double height,
    required double weight,
    required String fitnessGoal,
  }) async {
    try {
      final now = DateTime.now();
      final bmi = weight / ((height / 100) * (height / 100));
      
      final newUser = models.AppUser(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        fullName: fullName,
        email: email,
        age: age,
        height: height,
        weight: weight,
        fitnessGoal: fitnessGoal,
        bmi: bmi,
        createdAt: now,
        updatedAt: now,
      );
      
      await updateUser(newUser);
    } catch (e) {
      debugPrint('Error creating user: $e');
    }
  }

  Future<void> updateWeight(double newWeight) async {
    if (_user != null) {
      final newBmi = newWeight / ((_user!.height / 100) * (_user!.height / 100));
      
      final updatedUser = _user!.copyWith(
        weight: newWeight,
        bmi: newBmi,
        updatedAt: DateTime.now(),
      );
      await updateUser(updatedUser);
    }
  }

  Future<void> updateProfileImage(String imagePath) async {
    if (_user != null) {
      final updatedUser = _user!.copyWith(
        profileImagePath: imagePath,
        updatedAt: DateTime.now(),
      );
      await updateUser(updatedUser);
    }
  }

  void clearUser() {
    _user = null;
    _storageService.clearUser();
    notifyListeners();
  }
}
