import 'package:flutter/material.dart';
import '../models/lyric.dart';
import '../widgets/lyrics_input_form.dart';

class LyricsInputScreen extends StatelessWidget {
  final Lyric? lyric;

  LyricsInputScreen({this.lyric});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(lyric == null ? 'Add Lyrics' : 'Update Lyrics'),
        backgroundColor: Colors.blueAccent,
      ),
      body: LyricsInputForm(lyric: lyric),
    );
  }
}
