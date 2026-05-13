class UserProfile {
  String age;
  String gender;
  String height;
  String weight;
  String bodyType;
  String primaryGoal;
  String secondaryGoals;
  String timeline;
  String experienceLevel;
  String currentRoutine;
  String daysPerWeek;
  String sessionDuration;
  String equipment;
  String trainingStyle;
  String occupation;
  String sleepDuration;
  String stressLevel;
  String injuries;
  String healthConditions;
  String medications;
  String dietType;
  bool wantsNutrition;
  String favoriteExercises;
  String exercisesToAvoid;
  bool wantsWarmup;

  UserProfile({
    this.age = '',
    this.gender = 'Male',
    this.height = '',
    this.weight = '',
    this.bodyType = '🧍 Average — Moderate build, some fat',
    this.primaryGoal = 'Muscle Gain',
    this.secondaryGoals = '',
    this.timeline = '',
    this.experienceLevel = 'Beginner (<6 months)',
    this.currentRoutine = '',
    this.daysPerWeek = '4',
    this.sessionDuration = '60 minutes',
    this.equipment = 'Full commercial gym',
    this.trainingStyle = 'Bodybuilding-focused',
    this.occupation = '🎓 Student',
    this.sleepDuration = '7-8 hours',
    this.stressLevel = 'Moderate',
    this.injuries = 'None',
    this.healthConditions = 'None',
    this.medications = 'None',
    this.dietType = 'Non-vegetarian',
    this.wantsNutrition = true,
    this.favoriteExercises = '',
    this.exercisesToAvoid = '',
    this.wantsWarmup = true,
  });
}
