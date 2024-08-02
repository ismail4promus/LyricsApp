import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/lyric.dart';

class LyricsProvider extends ChangeNotifier {
  List<Lyric> lyricsList = [];
  List<Lyric> filteredLyricsList = [];

  final CollectionReference lyricsCollection = FirebaseFirestore.instance.collection('lyrics');

  LyricsProvider() {
    fetchLyrics();
  }

  Future<void> fetchLyrics() async {
    try {
      QuerySnapshot querySnapshot = await lyricsCollection.get();
      lyricsList = querySnapshot.docs.map((doc) => Lyric.fromFirestore(doc)).toList();
      filteredLyricsList = lyricsList;
      notifyListeners();
    } catch (e) {
      print('Error fetching lyrics: $e');
    }
  }

  Future<void> addLyrics(Lyric newLyric) async {
    try {
      DocumentReference docRef = await lyricsCollection.add(newLyric.toMap());
      newLyric.id = docRef.id;
      lyricsList.add(newLyric);
      filteredLyricsList = lyricsList;
      notifyListeners();
    } catch (e) {
      print('Error adding lyrics: $e');
    }
  }

  Future<void> updateLyrics(String id, Lyric updatedLyric) async {
    try {
      await lyricsCollection.doc(id).update(updatedLyric.toMap());
      final index = lyricsList.indexWhere((lyric) => lyric.id == id);
      if (index != -1) {
        lyricsList[index] = updatedLyric;
        filteredLyricsList = lyricsList;
        notifyListeners();
      }
    } catch (e) {
      print('Error updating lyrics: $e');
    }
  }

  Future<void> deleteLyrics(String id) async {
    try {
      await lyricsCollection.doc(id).delete();
      lyricsList.removeWhere((lyric) => lyric.id == id);
      filteredLyricsList = lyricsList;
      notifyListeners();
    } catch (e) {
      print('Error deleting lyrics: $e');
    }
  }

  void filterLyrics(String query) {
    if (query.isEmpty) {
      filteredLyricsList = lyricsList;
    } else {
      filteredLyricsList = lyricsList
          .where((lyric) =>
      lyric.name.toLowerCase().contains(query.toLowerCase()) ||
          lyric.scale.toLowerCase().contains(query.toLowerCase()) ||
          lyric.bpm.toString().contains(query))
          .toList();
    }
    notifyListeners();
  }
}
