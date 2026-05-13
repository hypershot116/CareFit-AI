import 'package:flutter/material.dart';
import 'package:carefit_ai/theme/app_theme.dart';
import 'package:carefit_ai/models/user_profile.dart';
import 'package:carefit_ai/screens/result_screen.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  int _currentStep = 0;
  final _profile = UserProfile();
  final _formKeys = List.generate(5, (_) => GlobalKey<FormState>());

  final _ageCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _secondaryGoalsCtrl = TextEditingController();
  final _timelineCtrl = TextEditingController();
  final _currentRoutineCtrl = TextEditingController();
  final _injuriesCtrl = TextEditingController();
  final _healthCtrl = TextEditingController();
  final _medsCtrl = TextEditingController();
  final _favExercisesCtrl = TextEditingController();
  final _avoidExercisesCtrl = TextEditingController();

  final _stepTitles = [
    'Basic Info',
    'Goals',
    'Training Setup',
    'Health & Lifestyle',
    'Diet & Preferences',
  ];

  final _stepSubtitles = [
    'Tell us about yourself',
    'What do you want to achieve?',
    'How will you train?',
    'Your health profile',
    'Final details',
  ];

  final _stepIcons = ['👤', '🎯', '🏋️', '🏥', '🥗'];

  @override
  void dispose() {
    _ageCtrl.dispose();
    _heightCtrl.dispose();
    _weightCtrl.dispose();
    _secondaryGoalsCtrl.dispose();
    _timelineCtrl.dispose();
    _currentRoutineCtrl.dispose();
    _injuriesCtrl.dispose();
    _healthCtrl.dispose();
    _medsCtrl.dispose();
    _favExercisesCtrl.dispose();
    _avoidExercisesCtrl.dispose();
    super.dispose();
  }

  void _syncControllers() {
    _profile.age = _ageCtrl.text.trim();
    _profile.height = _heightCtrl.text.trim();
    _profile.weight = _weightCtrl.text.trim();
    _profile.secondaryGoals = _secondaryGoalsCtrl.text.trim();
    _profile.timeline = _timelineCtrl.text.trim();
    _profile.currentRoutine = _currentRoutineCtrl.text.trim();
    _profile.injuries = _injuriesCtrl.text.trim().isEmpty
        ? 'None'
        : _injuriesCtrl.text.trim();
    _profile.healthConditions = _healthCtrl.text.trim().isEmpty
        ? 'None'
        : _healthCtrl.text.trim();
    _profile.medications = _medsCtrl.text.trim().isEmpty
        ? 'None'
        : _medsCtrl.text.trim();
    _profile.favoriteExercises = _favExercisesCtrl.text.trim();
    _profile.exercisesToAvoid = _avoidExercisesCtrl.text.trim();
  }

  void _next() {
    if (_formKeys[_currentStep].currentState!.validate()) {
      _syncControllers();
      if (_currentStep < 4) {
        setState(() => _currentStep++);
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ResultScreen(profile: _profile)),
        );
      }
    }
  }

  void _back() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(
          '${_stepIcons[_currentStep]}  ${_stepTitles[_currentStep]}',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: _back,
        ),
      ),
      body: Column(
        children: [
          _buildProgressBar(),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: SingleChildScrollView(
                key: ValueKey(_currentStep),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKeys[_currentStep],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      ..._getStepFields(),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
          _buildNavButtons(),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Step ${_currentStep + 1} of 5',
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 12,
                ),
              ),
              Text(
                _stepSubtitles[_currentStep],
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: (_currentStep + 1) / 5,
              backgroundColor: AppTheme.surface,
              valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primary),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButtons() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.background,
        border: Border(
          top: BorderSide(color: AppTheme.surface.withOpacity(0.5)),
        ),
      ),
      child: Row(
        children: [
          if (_currentStep > 0) ...[
            Expanded(
              child: OutlinedButton(
                onPressed: _back,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.textSecondary,
                  side: const BorderSide(color: AppTheme.surface),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text('Back'),
              ),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _next,
              child: Text(
                _currentStep == 4 ? '🚀 Generate My Plan' : 'Next  →',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getStepFields() {
    switch (_currentStep) {
      case 0:
        return _step1();
      case 1:
        return _step2();
      case 2:
        return _step3();
      case 3:
        return _step4();
      case 4:
        return _step5();
      default:
        return [];
    }
  }

  // ─── Helper Widgets ───────────────────────────────────────────────

  Widget _sectionTitle(String text) => Padding(
    padding: const EdgeInsets.only(top: 8, bottom: 16),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppTheme.textPrimary,
      ),
    ),
  );

  Widget _field(
    String label,
    TextEditingController ctrl, {
    String? hint,
    TextInputType? keyboardType,
    bool required = true,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: ctrl,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: const TextStyle(color: AppTheme.textPrimary),
        decoration: InputDecoration(labelText: label, hintText: hint),
        validator: required
            ? (v) =>
                  (v == null || v.trim().isEmpty) ? '$label is required' : null
            : null,
      ),
    );
  }

  Widget _dropdown(
    String label,
    String value,
    List<String> items,
    void Function(String?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: value,
        style: const TextStyle(color: AppTheme.textPrimary, fontSize: 15),
        dropdownColor: AppTheme.surface,
        decoration: InputDecoration(labelText: label),
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _toggle(
    String title,
    String subtitle,
    bool value,
    void Function(bool) onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13),
        ),
        value: value,
        activeColor: AppTheme.primary,
        onChanged: onChanged,
      ),
    );
  }

  // ─── Step Fields ──────────────────────────────────────────────────

  List<Widget> _step1() => [
    _sectionTitle('👤 Basic Information'),
    _field(
      'Age',
      _ageCtrl,
      hint: 'e.g. 22',
      keyboardType: TextInputType.number,
    ),
    _dropdown('Gender', _profile.gender, [
      'Male',
      'Female',
      'Other',
    ], (v) => setState(() => _profile.gender = v!)),
    _field('Height', _heightCtrl, hint: "e.g. 5'10\" or 177 cm"),
    _field('Weight', _weightCtrl, hint: 'e.g. 75 kg or 165 lbs'),
    _dropdown('Body Type', _profile.bodyType, [
      '🦴 Skinny — Very lean, minimal muscle or fat',
      '🫠 Skinny-fat — Soft but not obviously overweight',
      '🧍 Average — Moderate build, some fat',
      '⚖️ Overweight — Noticeable excess body fat',
      '💪 Muscular — Good muscle mass, lean',
      '🔴 Obese — Significant excess body fat',
    ], (v) => setState(() => _profile.bodyType = v!)),
  ];

  List<Widget> _step2() => [
    _sectionTitle('🎯 Goals & Experience'),
    _dropdown(
      'Primary Goal',
      _profile.primaryGoal,
      [
        'Muscle Gain',
        'Fat Loss',
        'Body Recomposition',
        'Strength Development',
        'Endurance Improvement',
        'Athletic Performance',
        'General Health',
      ],
      (v) => setState(() => _profile.primaryGoal = v!),
    ),
    _field(
      'Secondary Goals',
      _secondaryGoalsCtrl,
      hint: 'e.g. Improve endurance, lose belly fat',
      required: false,
      maxLines: 2,
    ),
    _field(
      'Target Timeline',
      _timelineCtrl,
      hint: 'e.g. 3 months, 6 months',
      required: false,
    ),
    _dropdown(
      'Experience Level',
      _profile.experienceLevel,
      [
        'Beginner (<6 months)',
        'Intermediate (6-24 months)',
        'Advanced (>2 years)',
      ],
      (v) => setState(() => _profile.experienceLevel = v!),
    ),
    _field(
      'Current Routine',
      _currentRoutineCtrl,
      hint: 'Describe your current workout or write "None"',
      required: false,
      maxLines: 2,
    ),
  ];

  List<Widget> _step3() => [
    _sectionTitle('🏋️ Training Setup'),
    _dropdown(
      'Days Per Week',
      _profile.daysPerWeek,
      ['2', '3', '4', '5', '6'],
      (v) => setState(() => _profile.daysPerWeek = v!),
    ),
    _dropdown(
      'Session Duration',
      _profile.sessionDuration,
      ['30 minutes', '45 minutes', '60 minutes', '75 minutes', '90 minutes'],
      (v) => setState(() => _profile.sessionDuration = v!),
    ),
    _dropdown(
      'Equipment Access',
      _profile.equipment,
      ['Full commercial gym', 'Home gym with equipment', 'Bodyweight only'],
      (v) => setState(() => _profile.equipment = v!),
    ),
    _dropdown(
      'Training Style',
      _profile.trainingStyle,
      [
        'Bodybuilding-focused',
        'Strength-focused',
        'Athletic',
        'Minimal-time efficient',
        'Powerlifting-style',
        'Hybrid fitness',
      ],
      (v) => setState(() => _profile.trainingStyle = v!),
    ),
  ];

  List<Widget> _step4() => [
    _sectionTitle('🏥 Health & Lifestyle'),
    _dropdown('Occupation Type', _profile.occupation, [
      '🎓 Student',
      '💻 Desk job / Office worker',
      '🏠 Housewife / Homemaker',
      '🚶 Active job (on feet most of the day)',
      '🏗️ Labor-intensive work',
      '🩺 Healthcare worker',
      '🚗 Driver / Delivery',
      '👔 Business owner',
      '💼 Other',
    ], (v) => setState(() => _profile.occupation = v!),
    ),
    _dropdown(
      'Average Sleep',
      _profile.sleepDuration,
      ['Less than 6 hours', '6-7 hours', '7-8 hours', '8+ hours'],
      (v) => setState(() => _profile.sleepDuration = v!),
    ),
    _dropdown(
      'Stress Level',
      _profile.stressLevel,
      ['Low', 'Moderate', 'High'],
      (v) => setState(() => _profile.stressLevel = v!),
    ),
    _field(
      'Injuries or Limitations',
      _injuriesCtrl,
      hint: 'e.g. Lower back pain, knee issues — or write "None"',
      required: false,
      maxLines: 2,
    ),
    _field(
      'Health Conditions',
      _healthCtrl,
      hint: 'e.g. Diabetes, hypertension — or write "None"',
      required: false,
      maxLines: 2,
    ),
    _field(
      'Current Medications',
      _medsCtrl,
      hint: 'List any medications or write "None"',
      required: false,
    ),
  ];

  List<Widget> _step5() => [
    _sectionTitle('🥗 Diet & Preferences'),
    _dropdown('Diet Type', _profile.dietType, [
      'Non-vegetarian',
      'Vegetarian',
      'Vegan',
    ], (v) => setState(() => _profile.dietType = v!)),
    _toggle(
      'Include Nutrition Guidance',
      'Get calorie targets, macros & supplement tips',
      _profile.wantsNutrition,
      (v) => setState(() => _profile.wantsNutrition = v),
    ),
    _toggle(
      'Include Warm-up & Cool-down',
      'Get detailed warm-up and cool-down protocols',
      _profile.wantsWarmup,
      (v) => setState(() => _profile.wantsWarmup = v),
    ),
    _field(
      'Favorite Exercises',
      _favExercisesCtrl,
      hint: 'e.g. Bench press, pull-ups, squats',
      required: false,
      maxLines: 2,
    ),
    _field(
      'Exercises to Avoid',
      _avoidExercisesCtrl,
      hint: 'e.g. Heavy deadlifts due to back pain',
      required: false,
      maxLines: 2,
    ),
  ];
}
