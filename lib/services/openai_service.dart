import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';

class OpenAIService {
  static const String _baseUrl = 'https://api.openai.com/v1';
  static String get _apiKey => AppConfig.openAIApiKey;

  static Future<String> sendMessage(String message, List<Map<String, String>> conversationHistory) async {
    try {
      // Prepare the messages for the API
      final List<Map<String, String>> messages = [
        {
          'role': 'system',
          'content': '''
You are a knowledgeable and motivating fitness AI assistant integrated into a fitness tracking app. Your role is to:

1. Provide personalized workout recommendations based on user data
2. Offer nutrition advice and meal planning suggestions
3. Motivate users to achieve their fitness goals
4. Answer fitness-related questions with evidence-based information
5. Analyze workout progress and suggest improvements
6. Provide real-time feedback on exercise form and techniques
7. Help with injury prevention and recovery advice

Always maintain an encouraging, professional, and supportive tone. Focus on helping users achieve their fitness goals safely and effectively.'''
        },
        ...conversationHistory,
        {'role': 'user', 'content': message}
      ];

      final response = await http.post(
        Uri.parse('$_baseUrl/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': messages,
          'max_tokens': AppConfig.maxTokens,
          'temperature': AppConfig.temperature,
          'top_p': 1.0,
          'frequency_penalty': 0.0,
          'presence_penalty': 0.0,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'].toString().trim();
      } else {
        print('OpenAI API Error: ${response.statusCode} - ${response.body}');
        return _getFallbackResponse(message);
      }
    } catch (e) {
      print('OpenAI Service Error: $e');
      return _getFallbackResponse(message);
    }
  }

  static String _getFallbackResponse(String message) {
    final lowerMessage = message.toLowerCase();
    
    if (lowerMessage.contains('workout') || lowerMessage.contains('exercise')) {
      return "I'd love to help you with your workout! Here are some general tips: Start with a warm-up, focus on proper form, and listen to your body. What specific type of workout are you interested in?";
    } else if (lowerMessage.contains('nutrition') || lowerMessage.contains('diet')) {
      return 'Nutrition is key to fitness success! Focus on whole foods, adequate protein, and staying hydrated. What are your current nutrition goals?';
    } else if (lowerMessage.contains('motivation') || lowerMessage.contains('tired')) {
      return "Remember, every small step counts toward your fitness journey! Consistency is more important than perfection. You've got this! 💪";
    } else if (lowerMessage.contains('progress') || lowerMessage.contains('results')) {
      return 'Progress takes time and consistency. Track your workouts, celebrate small wins, and trust the process. What progress have you noticed so far?';
    } else {
      return "I'm here to help you with your fitness journey! Feel free to ask me about workouts, nutrition, motivation, or any fitness-related questions. How can I assist you today?";
    }
  }

  static Future<String> analyzeWorkoutData(Map<String, dynamic> workoutData) async {
    try {
      final analysisPrompt = '''
      Analyze this workout data and provide insights:
      
      Workout Data: ${jsonEncode(workoutData)}
      
      Please provide:
      1. Performance analysis
      2. Areas for improvement
      3. Recommended next steps
      4. Motivational feedback
      
      Keep the response concise and actionable.
      ''';

      return await sendMessage(analysisPrompt, []);
    } catch (e) {
      return 'Great workout session! Keep maintaining this consistency. Consider tracking your progress to see improvements over time.';
    }
  }

  static Future<String> generateWorkoutPlan(String fitnessLevel, String goals, List<String> preferredExercises) async {
    try {
      final planPrompt = '''
      Create a personalized workout plan with these details:
      
      Fitness Level: $fitnessLevel
      Goals: $goals
      Preferred Exercises: ${preferredExercises.join(', ')}
      
      Please provide:
      1. A structured workout routine
      2. Sets and reps recommendations
      3. Weekly schedule
      4. Progressive overload suggestions
      
      Keep it practical and achievable.
      ''';

      return await sendMessage(planPrompt, []);
    } catch (e) {
      return "I'd recommend starting with a balanced routine including cardio, strength training, and flexibility work. Aim for 3-4 sessions per week and gradually increase intensity.";
    }
  }
}
