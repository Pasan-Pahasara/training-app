import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_app/db/model/diary_card_entry.dart';
import 'package:training_app/db/repo/diary_repository.dart';
import 'package:training_app/ui/diary_home_page/diary_home_page_event.dart';
import 'package:training_app/ui/diary_home_page/diary_home_page_state.dart';

class DiaryHomeScreenBloc
    extends Bloc<DiaryHomeScreenEvent, DiaryHomeScreenState> {
  final DiaryRepository _diaryRepository = DiaryRepository();

  DiaryHomeScreenBloc() : super(DiaryHomeScreenState.initialState) {
    on<SubmitNewButtonPressed>(_onSubmitNewButtonPressed);
    on<SubmitButtonPressed>(_onSubmitButtonPressed);
    on<GetAllDiaryCardsEntries>(_getAllDiaryCardsEntries);
  }

  void _onSubmitNewButtonPressed(
    SubmitNewButtonPressed event,
    Emitter<DiaryHomeScreenState> emit,
  ) {
    emit(
      state.clone(isSubmitting: true),
    );
  }

  Future<void> _onSubmitButtonPressed(
    SubmitButtonPressed event,
    Emitter<DiaryHomeScreenState> emit,
  ) async {
    final title = event.title.trim();
    final description = event.description.trim();
    final username = event.username.trim();

    print('title name user: $username');
    if (title.isNotEmpty && description.isNotEmpty) {
      final newCardEntry = DiaryCardEntryModel(
          title: title, description: description, username: username);
      await _diaryRepository.addDiaryCardEntry(newCardEntry);
      emit(
        state.clone(entries: await _getAllEvent(), isSubmitting: false),
      );
    }
  }

  Future<List<DiaryCardEntry>> _getAllEvent() async {
    List<QueryDocumentSnapshot> docs =
        await _diaryRepository.getDiaryCardEntries();
    return docs
        .map(
          (e) => DiaryCardEntry(
            title: e['title'],
            description: e['description'],
            username: e['username'],
          ),
        )
        .toList();
  }

  Future<FutureOr<void>> _getAllDiaryCardsEntries(
      GetAllDiaryCardsEntries event, Emitter<DiaryHomeScreenState> emit) async {
    emit(
      state.clone(
        entries: await _getAllEvent(),
      ),
    );
  }
}
