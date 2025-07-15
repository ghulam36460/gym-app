import 'package:flutter/foundation.dart';
import '../models/workout.dart';
import '../services/storage_service.dart';

class WorkoutProvider with ChangeNotifier {
  List<Workout> _workouts = [];
  List<Exercise> _exercises = [];
  Workout? _currentWorkout;
  final StorageService _storageService = StorageService();

  List<Workout> get workouts => _workouts;
  List<Exercise> get exercises => _exercises;
  Workout? get currentWorkout => _currentWorkout;

  Future<void> loadWorkouts() async {
    try {
      final workoutData = await _storageService.getWorkouts();
      _workouts = workoutData.map(Workout.fromJson).toList();
      _workouts.sort((a, b) => b.date.compareTo(a.date));
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading workouts: $e');
    }
  }

  Future<void> loadExercises() async {
    if (_exercises.isEmpty) {
      _exercises = _getDefaultExercises();
      notifyListeners();
    }
  }

  Future<void> addWorkout(Workout workout) async {
    try {
      _workouts.insert(0, workout);
      await _storageService.saveWorkouts(_workouts.map((w) => w.toJson()).toList());
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding workout: $e');
    }
  }

  Future<void> updateWorkout(Workout workout) async {
    try {
      final index = _workouts.indexWhere((w) => w.id == workout.id);
      if (index != -1) {
        _workouts[index] = workout;
        await _storageService.saveWorkouts(_workouts.map((w) => w.toJson()).toList());
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error updating workout: $e');
    }
  }

  Future<void> deleteWorkout(String workoutId) async {
    try {
      _workouts.removeWhere((w) => w.id == workoutId);
      await _storageService.saveWorkouts(_workouts.map((w) => w.toJson()).toList());
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting workout: $e');
    }
  }

  void startWorkout(Workout workout) {
    _currentWorkout = workout;
    notifyListeners();
  }

  void finishWorkout() {
    if (_currentWorkout != null) {
      final finishedWorkout = Workout(
        id: _currentWorkout!.id,
        name: _currentWorkout!.name,
        date: _currentWorkout!.date,
        exercises: _currentWorkout!.exercises,
        duration: _currentWorkout!.duration,
        notes: _currentWorkout!.notes,
        completed: true,
      );
      updateWorkout(finishedWorkout);
      _currentWorkout = null;
    }
  }

  List<Workout> getRecentWorkouts(int count) {
    return _workouts.take(count).toList();
  }

  List<Workout> getWorkoutsByDateRange(DateTime start, DateTime end) {
    return _workouts.where((workout) =>
        workout.date.isAfter(start.subtract(const Duration(days: 1))) &&
        workout.date.isBefore(end.add(const Duration(days: 1)))).toList();
  }

  Map<String, int> getWorkoutStats() {
    final now = DateTime.now();
    final thisWeek = getWorkoutsByDateRange(
      now.subtract(Duration(days: now.weekday - 1)),
      now,
    );
    final thisMonth = getWorkoutsByDateRange(
      DateTime(now.year, now.month),
      now,
    );

    return {
      'totalWorkouts': _workouts.length,
      'thisWeek': thisWeek.length,
      'thisMonth': thisMonth.length,
      'completedWorkouts': _workouts.where((w) => w.completed).length,
    };
  }

  List<Exercise> _getDefaultExercises() {
    return [
      Exercise(
        id: '1',
        name: 'Push-ups',
        category: 'Chest',
        description: 'Classic bodyweight exercise for chest, shoulders, and triceps',
        instructions: 'Start in plank position, lower body until chest nearly touches floor, push back up',
        difficulty: 'Beginner',
        muscleGroups: ['Chest', 'Shoulders', 'Triceps'],
      ),
      Exercise(
        id: '2',
        name: 'Squats',
        category: 'Legs',
        description: 'Fundamental lower body exercise',
        instructions: 'Stand with feet shoulder-width apart, lower until thighs parallel to floor, return to standing',
        difficulty: 'Beginner',
        muscleGroups: ['Quadriceps', 'Glutes', 'Hamstrings'],
      ),
      Exercise(
        id: '3',
        name: 'Bench Press',
        category: 'Chest',
        description: 'Primary chest building exercise',
        instructions: 'Lie on bench, lower barbell to chest, press up to full arm extension',
        difficulty: 'Intermediate',
        muscleGroups: ['Chest', 'Shoulders', 'Triceps'],
      ),
      Exercise(
        id: '4',
        name: 'Deadlifts',
        category: 'Back',
        description: 'Compound exercise for posterior chain',
        instructions: 'Stand with feet hip-width apart, bend at hips and knees to grip bar, stand up straight',
        difficulty: 'Advanced',
        muscleGroups: ['Back', 'Glutes', 'Hamstrings'],
      ),
      Exercise(
        id: '5',
        name: 'Pull-ups',
        category: 'Back',
        description: 'Upper body pulling exercise',
        instructions: 'Hang from bar with arms extended, pull body up until chin over bar, lower with control',
        difficulty: 'Intermediate',
        muscleGroups: ['Back', 'Biceps'],
      ),
      Exercise(
        id: '6',
        name: 'Plank',
        category: 'Core',
        description: 'Isometric core strengthening exercise',
        instructions: 'Hold push-up position on forearms, keep body straight from head to heels',
        difficulty: 'Beginner',
        muscleGroups: ['Core', 'Shoulders'],
      ),
    ];
  }
}
