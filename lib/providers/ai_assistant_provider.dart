import 'package:flutter/foundation.dart';
import '../services/openai_service.dart';

class ChatMessage {

  ChatMessage({
    required this.content,
    required this.isUser,
    required this.timestamp,
    this.isTyping = false,
  });
  final String content;
  final bool isUser;
  final DateTime timestamp;
  final bool isTyping;
}

class AIAssistantProvider extends ChangeNotifier {

  AIAssistantProvider() {
    _initializeChat();
  }
  final List<ChatMessage> _messages = [];
  final List<Map<String, String>> _conversationHistory = [];
  bool _isLoading = false;
  bool _isConnected = true;

  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;
  bool get isConnected => _isConnected;

  void _initializeChat() {
    _messages.add(ChatMessage(
      content: "Hello! I'm your personal fitness AI assistant. I'm here to help you with workouts, nutrition, motivation, and achieving your fitness goals. How can I assist you today? 💪",
      isUser: false,
      timestamp: DateTime.now(),
    ));
  }

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    // Add user message
    _messages.add(ChatMessage(
      content: message,
      isUser: true,
      timestamp: DateTime.now(),
    ));

    // Add typing indicator
    _messages.add(ChatMessage(
      content: 'AI is thinking...',
      isUser: false,
      timestamp: DateTime.now(),
      isTyping: true,
    ));

    _isLoading = true;
    notifyListeners();

    try {
      // Send to OpenAI
      final response = await OpenAIService.sendMessage(message, _conversationHistory);
      
      // Remove typing indicator
      _messages.removeWhere((msg) => msg.isTyping);

      // Add AI response
      _messages.add(ChatMessage(
        content: response,
        isUser: false,
        timestamp: DateTime.now(),
      ));

      // Update conversation history
      _conversationHistory.add({'role': 'user', 'content': message});
      _conversationHistory.add({'role': 'assistant', 'content': response});

      // Keep conversation history manageable (last 10 exchanges)
      if (_conversationHistory.length > 20) {
        _conversationHistory.removeRange(0, _conversationHistory.length - 20);
      }

      _isConnected = true;
    } catch (e) {
      // Remove typing indicator
      _messages.removeWhere((msg) => msg.isTyping);

      // Add error message
      _messages.add(ChatMessage(
        content: "I'm having trouble connecting right now. Let me give you a helpful response: ${_getOfflineResponse(message)}",
        isUser: false,
        timestamp: DateTime.now(),
      ));

      _isConnected = false;
    }

    _isLoading = false;
    notifyListeners();
  }

  String _getOfflineResponse(String message) {
    final lowerMessage = message.toLowerCase();
    
    if (lowerMessage.contains('workout') || lowerMessage.contains('exercise')) {
      return 'For a great workout, try: 1) 5-min warm-up, 2) Strength exercises (3 sets of 8-12 reps), 3) Cardio (15-20 mins), 4) Cool down with stretching.';
    } else if (lowerMessage.contains('nutrition') || lowerMessage.contains('diet')) {
      return 'Focus on balanced nutrition: lean proteins, complex carbs, healthy fats, plenty of vegetables, and 8+ glasses of water daily.';
    } else if (lowerMessage.contains('motivation')) {
      return "Remember: Progress over perfection! Every workout counts, no matter how small. You're building lifelong healthy habits! 🌟";
    } else {
      return "I'm here to help with your fitness journey! Ask me about workouts, nutrition, or motivation anytime.";
    }
  }

  Future<void> analyzeWorkoutData(Map<String, dynamic> workoutData) async {
    _isLoading = true;
    notifyListeners();

    try {
      final analysis = await OpenAIService.analyzeWorkoutData(workoutData);
      
      _messages.add(ChatMessage(
        content: '📊 Workout Analysis:\n\n$analysis',
        isUser: false,
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      _messages.add(ChatMessage(
        content: 'Great workout! Your consistency is key to achieving your fitness goals. Keep up the excellent work!',
        isUser: false,
        timestamp: DateTime.now(),
      ));
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> generateWorkoutPlan(String fitnessLevel, String goals, List<String> preferredExercises) async {
    _isLoading = true;
    notifyListeners();

    try {
      final plan = await OpenAIService.generateWorkoutPlan(fitnessLevel, goals, preferredExercises);
      
      _messages.add(ChatMessage(
        content: '🏋️ Your Personalized Workout Plan:\n\n$plan',
        isUser: false,
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      _messages.add(ChatMessage(
        content: "Here's a balanced workout plan: 3-4 sessions per week, combining strength training (2x), cardio (2x), and flexibility work. Start with bodyweight exercises and progress gradually!",
        isUser: false,
        timestamp: DateTime.now(),
      ));
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearChat() {
    _messages.clear();
    _conversationHistory.clear();
    _initializeChat();
    notifyListeners();
  }

  void sendQuickAction(String action) {
    switch (action) {
      case 'workout_tips':
        sendMessage('Give me some quick workout tips for today');
        break;
      case 'nutrition_advice':
        sendMessage('What should I eat to support my fitness goals?');
        break;
      case 'motivation':
        sendMessage('I need some motivation to stay consistent with my fitness routine');
        break;
      case 'progress_check':
        sendMessage('How can I track my fitness progress effectively?');
        break;
    }
  }
}
