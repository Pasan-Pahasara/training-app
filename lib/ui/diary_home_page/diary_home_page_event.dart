import 'package:flutter/material.dart';

@immutable
abstract class DiaryHomeScreenEvent {}

class SubmitNewButtonPressed extends DiaryHomeScreenEvent {}

class SubmitButtonPressed extends DiaryHomeScreenEvent {
  final String username;
  final String title;
  final String description;
  SubmitButtonPressed({
    required this.username,
    required this.title,
    required this.description,
  });
}

class GetAllDiaryCardsEntries extends DiaryHomeScreenEvent {}
