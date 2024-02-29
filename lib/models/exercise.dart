class Exercise {
  late String name;
  late String primaryMuscle;
  late String? equipment;
  late String level;
  late String force;
  late String mechanic;
  late List<String> secondaryMuscles;
  late List<String> instructions;
  late String category;
  late List<String> images;

  Exercise({
    required this.name,
    required this.primaryMuscle,
    required this.equipment,
    required this.level,
    required this.mechanic,
    required this.force,
    required this.secondaryMuscles,
    required this.instructions,
    required this.category,
    required this.images,
  });
}
