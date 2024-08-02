import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/lyric.dart';
import '../providers/lyrics_provider.dart';
import '../utils/constants.dart';

class LyricsInputForm extends StatefulWidget {
  final Lyric? lyric;

  LyricsInputForm({this.lyric});

  @override
  _LyricsInputFormState createState() => _LyricsInputFormState();
}

class _LyricsInputFormState extends State<LyricsInputForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController lyricsController = TextEditingController();
  TextEditingController artistController = TextEditingController(text: 'Later');
  TextEditingController writerController = TextEditingController(text: 'Later');
  TextEditingController tunerController = TextEditingController(text: 'Later');
  String scale = 'C';
  int bpm = 50;
  int harmonium = 3;

  @override
  void initState() {
    super.initState();
    if (widget.lyric != null) {
      lyricsController.text = widget.lyric!.content;
      artistController.text = widget.lyric!.artist;
      writerController.text = widget.lyric!.writer;
      tunerController.text = widget.lyric!.tuner;
      scale = widget.lyric!.scale;
      bpm = widget.lyric!.bpm;
      harmonium = int.parse(widget.lyric!.harmonium);
    }
  }

  void clearFields() {
    lyricsController.clear();
    artistController.clear();
    writerController.clear();
    tunerController.clear();
    setState(() {
      scale = 'C';
      bpm = 50;
      harmonium = 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Card(
                shape: kCardShape,
                elevation: kCardElevation,
                color: kBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              value: harmonium,
                              onChanged: (newValue) {
                                setState(() {
                                  harmonium = newValue!;
                                });
                              },
                              items: List.generate(7, (index) => index + 3)
                                  .map<DropdownMenuItem<int>>((int value) {
                                return DropdownMenuItem<int>(
                                  value: value,
                                  child: Text(value.toString()),
                                );
                              }).toList(),
                              decoration: const InputDecoration(
                                labelText: 'Harmonium #',
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: scale,
                              onChanged: (newValue) {
                                setState(() {
                                  scale = newValue!;
                                });
                              },
                              items: [
                                'C',
                                'C# (or D♭)',
                                'D',
                                'D# (or E♭)',
                                'E',
                                'F',
                                'F# (or G♭)',
                                'G',
                                'G# (or A♭)',
                                'A',
                                'A# (or B♭)',
                                'B'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              decoration: const InputDecoration(
                                labelText: 'Pitch',
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              value: bpm,
                              onChanged: (newValue) {
                                setState(() {
                                  bpm = newValue!;
                                });
                              },
                              items: [50, 100, 150, 200].map<DropdownMenuItem<int>>((int value) {
                                return DropdownMenuItem<int>(
                                  value: value,
                                  child: Text(value.toString()),
                                );
                              }).toList(),
                              decoration: const InputDecoration(
                                labelText: 'BPM',
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: artistController,
                              decoration: const InputDecoration(
                                labelText: 'Artist',
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter artist';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: writerController,
                              decoration: const InputDecoration(
                                labelText: 'Writer',
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter writer';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: tunerController,
                              decoration: const InputDecoration(
                                labelText: 'Tuner',
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter tuner';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: lyricsController,
                        decoration: const InputDecoration(
                          labelText: 'Lyrics Content',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2.0),
                          ),
                        ),
                        maxLines: null,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter lyrics content';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final newLyric = Lyric(
                                  id: widget.lyric?.id ?? '',
                                  name: lyricsController.text.split(' ').take(3).join(' '),
                                  scale: scale,
                                  bpm: bpm,
                                  harmonium: harmonium.toString(),
                                  content: lyricsController.text,
                                  artist: artistController.text,
                                  writer: writerController.text,
                                  tuner: tunerController.text,
                                );
                                if (widget.lyric == null) {
                                  context.read<LyricsProvider>().addLyrics(newLyric);
                                } else {
                                  context.read<LyricsProvider>().updateLyrics(widget.lyric!.id, newLyric);
                                }
                                clearFields();
                                Navigator.pop(context);
                              }
                            },
                            child: Text(widget.lyric == null ? 'Add' : 'Update'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              clearFields();
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
