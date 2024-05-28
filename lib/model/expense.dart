import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Categories { food, work, travel, leisure }

const categoryIcons = {
  Categories.food: Icons.lunch_dining,
  Categories.work: Icons.work,
  Categories.travel: Icons.movie,
  Categories.leisure: Icons.flight_takeoff
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Categories category;
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  String get formettedDate {
    final formatter = DateFormat.yMd();
    return formatter.format(date);
  }
}
