import 'package:flutter/material.dart';

class CookingStep {
  final int stepNumber;
  final String title;
  final String description;
  final int estimatedTime; // dakika
  final List<String> requiredTools;
  final List<String> tips;
  final String technique; // 'kavurma', 'haşlama', 'fırınlama', vs.
  final int difficulty; // 1-5
  final bool isCompleted;

  const CookingStep({
    required this.stepNumber,
    required this.title,
    required this.description,
    required this.estimatedTime,
    this.requiredTools = const [],
    this.tips = const [],
    this.technique = 'genel',
    this.difficulty = 1,
    this.isCompleted = false,
  });

  factory CookingStep.fromJson(Map<String, dynamic> json) {
    return CookingStep(
      stepNumber: (json['stepNumber'] as num?)?.toInt() ?? 1,
      title: json['title'] ?? 'Pişirme Adımı',
      description: json['description'] ?? '',
      estimatedTime: (json['estimatedTime'] as num?)?.toInt() ?? 5,
      requiredTools: List<String>.from(json['requiredTools'] ?? []),
      tips: List<String>.from(json['tips'] ?? []),
      technique: json['technique'] ?? 'genel',
      difficulty: (json['difficulty'] as num?)?.toInt() ?? 1,
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stepNumber': stepNumber,
      'title': title,
      'description': description,
      'estimatedTime': estimatedTime,
      'requiredTools': requiredTools,
      'tips': tips,
      'technique': technique,
      'difficulty': difficulty,
      'isCompleted': isCompleted,
    };
  }

  // Adım zorluğuna göre renk
  Color get difficultyColor {
    switch (difficulty) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.lightGreen;
      case 3:
        return Colors.orange;
      case 4:
        return Colors.deepOrange;
      case 5:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Zorluk seviyesi metni
  String get difficultyText {
    switch (difficulty) {
      case 1:
        return 'Çok Kolay';
      case 2:
        return 'Kolay';
      case 3:
        return 'Orta';
      case 4:
        return 'Zor';
      case 5:
        return 'Çok Zor';
      default:
        return 'Bilinmiyor';
    }
  }

  // Teknik ikonu
  IconData get techniqueIcon {
    switch (technique.toLowerCase()) {
      case 'kavurma':
        return Icons.local_fire_department;
      case 'haşlama':
        return Icons.water_drop;
      case 'fırınlama':
        return Icons.kitchen; 
      case 'doğrama':
        return Icons.content_cut; 
      case 'karıştırma':
        return Icons.rotate_right;
      case 'servis':
        return Icons.restaurant;
      case 'hazırlık':
        return Icons.timer_outlined; 
      case 'soğutma':
        return Icons.ac_unit;
      case 'bekletme':
        return Icons.schedule;
      default:
        return Icons.restaurant_menu;
    }
  }

  // Adımı tamamla
  CookingStep copyWithCompleted(bool completed) {
    return CookingStep(
      stepNumber: stepNumber,
      title: title,
      description: description,
      estimatedTime: estimatedTime,
      requiredTools: requiredTools,
      tips: tips,
      technique: technique,
      difficulty: difficulty,
      isCompleted: completed,
    );
  }

  @override
  String toString() {
    return 'CookingStep($stepNumber: $title - ${estimatedTime}dk)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CookingStep && other.stepNumber == stepNumber;
  }

  @override
  int get hashCode => stepNumber.hashCode;
}

// Cooking Step Collection Helper
class CookingStepCollection {
  final List<CookingStep> steps;

  const CookingStepCollection(this.steps);

  // Toplam süre
  int get totalTime => steps.fold(0, (sum, step) => sum + step.estimatedTime);

  // Tamamlanan adım sayısı
  int get completedSteps => steps.where((step) => step.isCompleted).length;

  // İlerleme yüzdesi
  double get progressPercentage {
    if (steps.isEmpty) return 0.0;
    return completedSteps / steps.length;
  }

  // Sonraki adım
  CookingStep? get nextStep {
    return steps.firstWhere(
      (step) => !step.isCompleted,
      orElse: () => steps.last,
    );
  }

  // Zorluk ortalaması
  double get averageDifficulty {
    if (steps.isEmpty) return 0.0;
    return steps.fold(0, (sum, step) => sum + step.difficulty) / steps.length;
  }

  // Gerekli araçlar listesi
  List<String> get allRequiredTools {
    Set<String> tools = {};
    for (CookingStep step in steps) {
      tools.addAll(step.requiredTools);
    }
    return tools.toList();
  }
}