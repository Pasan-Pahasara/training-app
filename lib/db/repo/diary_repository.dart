import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_app/ui/diary_home_page/diary_home_page_state.dart';

import '../model/diary_card_entry.dart';

class DiaryRepository {
  final CollectionReference diaryCollection =
      FirebaseFirestore.instance.collection('diary');

  Future<void> addDiaryCardEntry(DiaryCardEntryModel diaryCardEntry) async {
    log(diaryCardEntry.toString());
    await diaryCollection.add({
      'title': diaryCardEntry.title,
      'description': diaryCardEntry.description,
      'username': diaryCardEntry.username,
    }).then(
      (value) => print('Diary card entry added'),
    );
  }

  Future<List<DiaryCardEntry>> getDiaryCardEntries() async {
    QuerySnapshot querySnapshot = await diaryCollection.get();
    return querySnapshot.docs
        .map(
          (doc) => DiaryCardEntry(
            title: doc['title'],
            description: doc['description'],
            username: doc['username'],
          ),
        )
        .toList();
  }
}
