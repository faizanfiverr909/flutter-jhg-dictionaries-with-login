import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_guitar/chords_library/chord_library_model.dart';

class ChordLibrary {
  Future<List<dynamic>>
      getDictionary() async {
    final dynamicList =<dynamic>[];
    final chordLibraryList = <ChordLibraryModel>[];
    final rootList = <String>[];
    final tonalityList = <String>[];
    final data = await rootBundle
        .loadString('assets/dictionary/restructured_chordlibrary.json');
    final jsonResult = json.decode(data) as Map<String, dynamic>;
    final values = jsonResult.values;
    for (final value in values) {
      final edges = value['variations'] as List<dynamic>;
      final chordsList = <Chord>[];
      for (final edge in edges) {
        chordsList.add(Chord(edge['p'] as String, edge['f'] as String));
      }
      final root = value['root'] as String;
      final tonality = value['tonality'] as String;
      final scale = root + tonality;

      if (root.isNotEmpty && !rootList.contains(root)) {
        rootList.add(root);
      }
      if (tonality.isNotEmpty && !tonalityList.contains(tonality)) {
        tonalityList.add(tonality);
      }

      chordLibraryList.add(
        ChordLibraryModel(
          scale.trim(),
          value['root'] as String,
          value['tonality'] as String,
          chordsList,
        ),
      );
    }

    dynamicList..add(chordLibraryList)
    ..add(rootList)
    ..add(tonalityList);

    return dynamicList;
  }
}
