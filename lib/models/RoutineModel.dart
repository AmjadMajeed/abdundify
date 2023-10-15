import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyRoutine {
  final DateTime date;
  final String routine;

  DailyRoutine({required this.date, required this.routine});

  // Convert DailyRoutine to a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'routine': routine,
    };
  }

  // Create a factory method to create DailyRoutine from JSON Map
  factory DailyRoutine.fromJson(Map<String, dynamic> json) {
    return DailyRoutine(
      date: DateTime.parse(json['date']),
      routine: json['routine'],
    );
  }
}
