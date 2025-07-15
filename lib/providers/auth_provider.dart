import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/user.dart' as models;
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {

  AuthProvider() {
    _initAuthState();
  }
  final AuthService _authService = AuthService();
  
  User? _user;
  models.AppUser? _userProfile;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  models.AppUser? get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;

  void _initAuthState() {
    _authService.authStateChanges.listen((User? user) async {
      _user = user;
      if (user != null) {
        await _loadUserProfile();
      } else {
        _userProfile = null;
      }
      notifyListeners();
    });
  }

  Future<void> _loadUserProfile() async {
    if (_user == null) return;
    
    try {
      final DocumentSnapshot doc = await _authService.getUserDocument(_user!.uid);
      if (doc.exists) {
        final Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
        _userProfile = models.AppUser.fromFirestore(data);
      }
    } catch (e) {
      _error = 'Failed to load user profile: $e';
    }
    notifyListeners();
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required String fullName,
    required int age,
    required double weight,
    required double height,
    required String fitnessGoal,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final UserCredential? result = await _authService.signUpWithEmailAndPassword(
        email: email,
        password: password,
        fullName: fullName,
        age: age,
        weight: weight,
        height: height,
        fitnessGoal: fitnessGoal,
      );

      if (result != null) {
        await _loadUserProfile();
        _setLoading(false);
        return true;
      }
    } catch (e) {
      _setError(e.toString());
    }

    _setLoading(false);
    return false;
  }

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final UserCredential? result = await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result != null) {
        await _loadUserProfile();
        _setLoading(false);
        return true;
      }
    } catch (e) {
      _setError(e.toString());
    }

    _setLoading(false);
    return false;
  }

  Future<bool> signInWithGoogle() async {
    _setLoading(true);
    _clearError();

    try {
      final UserCredential? result = await _authService.signInWithGoogle();
      
      if (result != null) {
        await _loadUserProfile();
        _setLoading(false);
        return true;
      }
    } catch (e) {
      _setError(e.toString());
    }

    _setLoading(false);
    return false;
  }

  Future<bool> resetPassword(String email) async {
    _setLoading(true);
    _clearError();

    try {
      await _authService.resetPassword(email);
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  Future<void> signOut() async {
    _setLoading(true);
    try {
      await _authService.signOut();
      _user = null;
      _userProfile = null;
    } catch (e) {
      _setError(e.toString());
    }
    _setLoading(false);
  }

  Future<bool> deleteAccount() async {
    _setLoading(true);
    _clearError();

    try {
      await _authService.deleteAccount();
      _user = null;
      _userProfile = null;
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  Future<bool> updateProfile({
    String? fullName,
    int? age,
    double? weight,
    double? height,
    String? fitnessGoal,
  }) async {
    if (_user == null || _userProfile == null) return false;

    _setLoading(true);
    _clearError();

    try {
      final Map<String, dynamic> updates = {};
      
      if (fullName != null) updates['fullName'] = fullName;
      if (age != null) updates['age'] = age;
      if (weight != null) {
        updates['weight'] = weight;
        if (_userProfile!.height > 0) {
          updates['bmi'] = weight / ((_userProfile!.height / 100) * (_userProfile!.height / 100));
        }
      }
      if (height != null) {
        updates['height'] = height;
        if (_userProfile!.weight > 0) {
          updates['bmi'] = _userProfile!.weight / ((height / 100) * (height / 100));
        }
      }
      if (fitnessGoal != null) updates['fitnessGoal'] = fitnessGoal;

      await _authService.updateUserDocument(_user!.uid, updates);
      await _loadUserProfile();
      
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  Future<bool> sendEmailVerification() async {
    _clearError();
    try {
      await _authService.sendEmailVerification();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  Future<bool> checkEmailVerification() async {
    try {
      final bool isVerified = await _authService.isEmailVerified();
      if (isVerified && _userProfile != null) {
        await _authService.updateUserDocument(_user!.uid, {'isEmailVerified': true});
        await _loadUserProfile();
      }
      return isVerified;
    } catch (e) {
      return false;
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }

  void clearError() {
    _clearError();
  }
}
