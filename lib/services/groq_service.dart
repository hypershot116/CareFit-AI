import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:carefit_ai/models/user_profile.dart';
import 'package:carefit_ai/services/storage_service.dart';

class GroqService {
  static const String _baseUrl =
      'https://api.groq.com/openai/v1/chat/completions';
  static const String _model = 'llama-3.3-70b-versatile';

  final StorageService _storage = StorageService();

  // ─── Verify API Key ───────────────────────────────────────────────
  Future<void> verifyApiKey(String apiKey) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': _model,
        'max_tokens': 5,
        'messages': [
          {'role': 'user', 'content': 'Hi'},
        ],
      }),
    );

    if (response.statusCode == 200) {
      return; // Key is valid
    } else if (response.statusCode == 401) {
      throw Exception('Invalid API key. Please check and try again.');
    } else if (response.statusCode == 429) {
      throw Exception(
        'Rate limit reached. Your key is valid but try again in a moment.',
      );
    } else {
      throw Exception('Could not verify key. Status: ${response.statusCode}');
    }
  }

  // ─── Build Prompt ─────────────────────────────────────────────────
  String _buildPrompt(UserProfile p) {
    return '''
You are an experienced gym trainer, strength & conditioning coach, and exercise physiologist. Create a comprehensive, personalized fitness plan based on the following user profile:

**USER PROFILE:**
- Age: ${p.age}
- Gender: ${p.gender}
- Height: ${p.height}
- Weight: ${p.weight}
- Body Type: ${p.bodyType}
- Primary Goal: ${p.primaryGoal}
- Secondary Goals: ${p.secondaryGoals.isEmpty ? 'None' : p.secondaryGoals}
- Target Timeline: ${p.timeline.isEmpty ? 'Not specified' : p.timeline}
- Training Experience: ${p.experienceLevel}
- Current Routine: ${p.currentRoutine.isEmpty ? 'None' : p.currentRoutine}
- Days Per Week: ${p.daysPerWeek}
- Session Duration: ${p.sessionDuration}
- Equipment Access: ${p.equipment}
- Training Style: ${p.trainingStyle}
- Occupation: ${p.occupation}
- Sleep Duration: ${p.sleepDuration}
- Stress Level: ${p.stressLevel}
- Injuries/Limitations: ${p.injuries}
- Health Conditions: ${p.healthConditions}
- Medications: ${p.medications}
- Diet Type: ${p.dietType}
- Wants Nutrition Guidance: ${p.wantsNutrition ? 'Yes' : 'No'}
- Favorite Exercises: ${p.favoriteExercises.isEmpty ? 'None specified' : p.favoriteExercises}
- Exercises to Avoid: ${p.exercisesToAvoid.isEmpty ? 'None' : p.exercisesToAvoid}
- Wants Warm-up/Cool-down Guidance: ${p.wantsWarmup ? 'Yes' : 'No'}

Please provide a complete fitness plan with these sections:

## 1. Personal Profile Analysis
Summary of profile, goals, and key considerations.

## 2. Training Strategy Overview
- Recommended workout split and why
- Weekly schedule outline
- Training philosophy

## 3. Detailed Workout Plan
For each training day provide:
- Warm-up (if requested)
- Exercise name, sets, reps, rest time, muscles targeted, key form cues
- Cool-down (if requested)

## 4. Progressive Overload & Recovery
- Week by week progression strategy
- Deload recommendations
- Recovery tips

## 5. Cardio Recommendations
- Type, frequency, duration, intensity

${p.wantsNutrition ? '''## 6. Nutrition Guidance
- Estimated daily calorie target
- Protein, carbs, fat targets
- Meal timing basics
- Basic supplement suggestions''' : ''}

## 7. Lifestyle Optimization Tips
- Sleep, stress management, consistency strategies

## 8. Important Safety Notes & Disclaimer

Keep the plan practical, evidence-based, and sustainable. Use markdown formatting.
''';
  }

  // ─── Generate Plan ────────────────────────────────────────────────
  Future<String> generateFitnessPlan(UserProfile profile) async {
    final apiKey = await _storage.getApiKey();
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception(
        'No API key found. Please add your Groq API key in Settings.',
      );
    }

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': _model,
        'max_tokens': 4096,
        'temperature': 0.7,
        'messages': [
          {'role': 'user', 'content': _buildPrompt(profile)},
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'] as String;
    } else if (response.statusCode == 401) {
      throw Exception(
        'Invalid API key. Please check your Groq API key in Settings.',
      );
    } else if (response.statusCode == 429) {
      throw Exception(
        'Rate limit reached. Please wait a moment and try again.',
      );
    } else {
      throw Exception(
        'Failed to generate plan. Status: ${response.statusCode}',
      );
    }
  }
}
