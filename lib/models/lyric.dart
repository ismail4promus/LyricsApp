import 'package:cloud_firestore/cloud_firestore.dart';

class Lyric {
  String id;
  String name;
  String scale;
  int bpm;
  String harmonium;
  String content;
  String artist;
  String writer;
  String tuner;

  Lyric({
    this.id = '',
    required this.name,
    required this.scale,
    required this.bpm,
    required this.harmonium,
    required this.content,
    required this.artist,
    required this.writer,
    required this.tuner,
  });

  factory Lyric.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Lyric(
      id: doc.id,
      name: data['name'] ?? '',
      scale: data['scale'] ?? '',
      bpm: data['bpm'] ?? 0,
      harmonium: data['harmonium'] ?? '',
      content: data['content'] ?? '',
      artist: data['artist'] ?? '',
      writer: data['writer'] ?? '',
      tuner: data['tuner'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'scale': scale,
      'bpm': bpm,
      'harmonium': harmonium,
      'content': content,
      'artist': artist,
      'writer': writer,
      'tuner': tuner,
    };
  }
}
