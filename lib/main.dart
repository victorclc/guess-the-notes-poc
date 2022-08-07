import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piano/piano.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late NotePosition _currentNote;
  String displayText = "Guess the note";

  @override
  void initState() {
    super.initState();
    _currentNote = _createRandomNote();
  }

  NotePosition _createRandomNote() {
    final random = Random();
    return NotePosition(
        note: Note.values[random.nextInt(Note.values.length)],
        octave: 4,
        accidental: Accidental.None);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        title: 'Piano Demo',
        home: CupertinoPageScaffold(
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.maxFinite,
                child: ClefImage(
                  clef: Clef.Treble,
                  noteRange: NoteRange.forClefs([Clef.Treble]),
                  noteImages: [
                    NoteImage(
                      notePosition: _currentNote,
                    ),
                    // NoteImage(
                    //   notePosition: NotePosition(note: Note.E, octave: 4),
                    // ),
                    // NoteImage(
                    //   notePosition: NotePosition(note: Note.C, octave: 4),
                    // ),
                  ],
                  clefColor: Colors.black,
                  noteColor: Colors.blue,
                ),
              ),
              // Container(
              //   height: 200,
              //   width: double.maxFinite,
              //   child: ClefImage(
              //     clef: Clef.Bass,
              //     noteRange: NoteRange.forClefs([Clef.Bass]),
              //     noteImages: [
              //       NoteImage(
              //         notePosition: NotePosition(note: Note.B, octave: 3),
              //       ),
              //       // NoteImage(
              //       //   notePosition: NotePosition(note: Note.E, octave: 4),
              //       // ),
              //       // NoteImage(
              //       //   notePosition: NotePosition(note: Note.C, octave: 4),
              //       // ),
              //     ],
              //     clefColor: Colors.black,
              //     noteColor: Colors.blue,
              //   ),
              // ),
              Center(
                child: Text(displayText),
              ),
              SizedBox(
                height: 220,
              ),
              Expanded(
                child: InteractivePiano(
                  highlightedNotes: [NotePosition(note: Note.D, octave: 3)],
                  naturalColor: Colors.white,
                  accidentalColor: Colors.black,
                  keyWidth: 40,
                  noteRange: NoteRange.forClefs([Clef.Treble]),
                  onNotePositionTapped: (position) {
                    if (position == _currentNote) {
                      setState(() {
                        _currentNote = _createRandomNote();
                        displayText = "Nice job!";
                      });
                    } else {
                      setState(() {
                        displayText = "Wrong!";
                      });
                    }
                    resetText();
                    // Use an audio library like flutter_midi to play the sound
                  },
                ),
              ),
            ],
          ),
        ));
  }

  void resetText() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      displayText = "Guess the note";
    });
  }
}
