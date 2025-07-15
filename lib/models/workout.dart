class Exercise {

  Exercise({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.instructions,
    required this.difficulty,
    required this.muscleGroups,
    this.imagePath = '',
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      description: json['description'],
      instructions: json['instructions'],
      difficulty: json['difficulty'],
      muscleGroups: List<String>.from(json['muscleGroups']),
      imagePath: json['imagePath'] ?? '',
    );
  }
  final String id;
  final String name;
  final String category;
  final String description;
  final String instructions;
  final String difficulty;
  final List<String> muscleGroups;
  final String imagePath;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
      'instructions': instructions,
      'difficulty': difficulty,
      'muscleGroups': muscleGroups,
      'imagePath': imagePath,
    };
  }
}

class WorkoutSet {

  WorkoutSet({
    required this.reps,
    required this.weight,
    this.duration = 0,
    this.completed = false,
  });

  factory WorkoutSet.fromJson(Map<String, dynamic> json) {
    return WorkoutSet(
      reps: json['reps'],
      weight: json['weight'].toDouble(),
      duration: json['duration'] ?? 0,
      completed: json['completed'] ?? false,
    );
  }
  final int reps;
  final double weight;
  final int duration; // in seconds for time-based exercises
  final bool completed;

  Map<String, dynamic> toJson() {
    return {
      'reps': reps,
      'weight': weight,
      'duration': duration,
      'completed': completed,
    };
  }
}

class WorkoutExercise {

  WorkoutExercise({
    required this.exercise,
    required this.sets,
  });

  factory WorkoutExercise.fromJson(Map<String, dynamic> json) {
    return WorkoutExercise(
      exercise: Exercise.fromJson(json['exercise']),
      sets: (json['sets'] as List)
          .map((set) => WorkoutSet.fromJson(set))
          .toList(),
    );
  }
  final Exercise exercise;
  final List<WorkoutSet> sets;

  Map<String, dynamic> toJson() {
    return {
      'exercise': exercise.toJson(),
      'sets': sets.map((set) => set.toJson()).toList(),
    };
  }
}

class Workout {

  Workout({
    required this.id,
    required this.name,
    required this.date,
    required this.exercises,
    this.duration = 0,
    this.notes = '',
    this.completed = false,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['id'],
      name: json['name'],
      date: DateTime.parse(json['date']),
      exercises: (json['exercises'] as List)
          .map((ex) => WorkoutExercise.fromJson(ex))
          .toList(),
      duration: json['duration'] ?? 0,
      notes: json['notes'] ?? '',
      completed: json['completed'] ?? false,
    );
  }
  final String id;
  final String name;
  final DateTime date;
  final List<WorkoutExercise> exercises;
  final int duration; // in minutes
  final String notes;
  final bool completed;

  int get totalSets => exercises.fold(0, (sum, ex) => sum + ex.sets.length);
  
  double get totalWeight => exercises.fold(0, (sum, ex) => 
    sum + ex.sets.fold(0.0, (setSum, set) => setSum + (set.weight * set.reps)));

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date': date.toIso8601String(),
      'exercises': exercises.map((ex) => ex.toJson()).toList(),
      'duration': duration,
      'notes': notes,
      'completed': completed,
    };
  }
}
