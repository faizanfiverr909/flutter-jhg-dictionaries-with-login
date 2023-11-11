import 'dart:ffi';

import 'package:flutter_guitar/chords_library/chord_library_list.dart';
import 'package:flutter_guitar/chords_library/chord_library_model.dart';
import 'package:flutter_guitar/guitar_play/data/item_model.dart';
import 'package:get/get.dart';

class GuitarController extends GetxController {
  List<ChordLibraryModel> chordLibraryList = [];
  RxList<ChordLibraryModel> matchedChords = <ChordLibraryModel>[].obs;
  RxList<String> scales = <String>[].obs;
  ChordLibrary? chordLibrary;
  RxString dropdownCategoryValue = ''.obs;
  RxString dropdownRootValue = ''.obs;
  RxString dropdownTonalityValue = ''.obs;

  // for  managing next and previous click events
  RxInt mainListCurrentIndex = 0.obs;
  RxInt subListCurrentIndex = 0.obs;
  RxBool isLeftClicked = false.obs;


  // for explore  section
  RxList<String> rootList = <String>[].obs;
  RxList<String> tonalityList = <String>[].obs;

  RxString currentScale = ''.obs;
  List<int> keyMatchedResponse = [];
  RxInt tabItem = 0.obs;
  RxList<int> toFindList = <int>[].obs;
  RxList<int> activeStringList = <int>[].obs;
  RxBool isFinding = false.obs;
  RxBool matchFound = false.obs;
  RxBool isRestoring = false.obs;
  RxBool addingKeyNote = false.obs;
  RxBool isListLoading = false.obs;
  RxBool isNewScaleLoading = false.obs;

  RxList<RxList<Item>> itemsList = <RxList<Item>>[].obs;

  List<String> categories = [
    'Chords',
    'Scales',
    'Arpeggios',
  ].obs;

  RxList<String> keysList = <String>[].obs;

  // [
  // 'A',
  // 'A#',
  // 'B',
  // 'C',
  // 'C#',
  // 'D',
  // 'D#',
  // 'E',
  // 'F',
  // 'F#',
  // 'G',
  // 'G#',
  // ].obs;

  RxList<RxList<Item>> refrenceList = [
    [
      Item(value: 0.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 1.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 2.obs, dot: ''.obs, hasDark: false.obs),
      Item(
        value: 3.obs,
        dot: ''.obs,
        hasDark: false.obs,
      ),
      Item(value: 4.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 5.obs, dot: ''.obs, hasDark: false.obs),
    ].obs,
  ].obs;

  // Strings And tabs list
  RxList<RxList<Item>> mainList = [
    [
      Item(value: 0.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 1.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 2.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 3.obs, dot: ''.obs, hasDark: false.obs,),
      Item(value: 4.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 5.obs, dot: ''.obs, hasDark: false.obs),
    ].obs,
    [
      Item(value: 0.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 1.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 2.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 3.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 4.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 5.obs, dot: ''.obs, hasDark: false.obs),
    ].obs,
    [
      Item(value: 0.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 1.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 2.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 3.obs, dot: ''.obs, hasDark: true.obs),
      Item(value: 4.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 5.obs, dot: ''.obs, hasDark: false.obs),
    ].obs,
    [
      Item(value: 0.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 1.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 2.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 3.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 4.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 5.obs, dot: ''.obs, hasDark: false.obs),
    ].obs,
    [
      Item(value: 0.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 1.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 2.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 3.obs, dot: ''.obs, hasDark: true.obs),
      Item(value: 4.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 5.obs, dot: ''.obs, hasDark: false.obs),
    ].obs,
    [
      Item(value: 0.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 1.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 2.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 3.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 4.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 5.obs, dot: ''.obs, hasDark: false.obs),
    ].obs,
    [
      Item(value: 0.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 1.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 2.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 3.obs, dot: ''.obs, hasDark: true.obs),
      Item(value: 4.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 5.obs, dot: ''.obs, hasDark: false.obs),
    ].obs,
    [
      Item(value: 0.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 1.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 2.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 3.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 4.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 5.obs, dot: ''.obs, hasDark: false.obs),
    ].obs,
    [
      Item(value: 0.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 1.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 2.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 3.obs, dot: ''.obs, hasDark: true.obs),
      Item(value: 4.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 5.obs, dot: ''.obs, hasDark: false.obs),
    ].obs,
    [
      Item(value: 0.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 1.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 2.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 3.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 4.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 5.obs, dot: ''.obs, hasDark: false.obs),
    ].obs,
    [
      Item(value: 0.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 1.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 2.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 3.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 4.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 5.obs, dot: ''.obs, hasDark: false.obs),
    ].obs,
    [
      Item(value: 0.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 1.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 2.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 3.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 4.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 5.obs, dot: ''.obs, hasDark: false.obs),
    ].obs,
    [
      Item(value: 0.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 1.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 2.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 3.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 4.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 5.obs, dot: ''.obs, hasDark: false.obs),
    ].obs,
    [
      Item(value: 0.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 1.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 2.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 3.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 4.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 5.obs, dot: ''.obs, hasDark: false.obs),
    ].obs,
    [
      Item(value: 0.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 1.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 2.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 3.obs, dot: ''.obs, hasDark: true.obs),
      Item(value: 4.obs, dot: ''.obs, hasDark: false.obs),
      Item(value: 5.obs, dot: ''.obs, hasDark: false.obs),
    ].obs,
  ].obs;

  @override
  void onInit() {
    super.onInit();
    isLeftClicked.value = false;
    ChordLibrary().getDictionary().then(
          (value) => {
            chordLibraryList = value[0] as List<ChordLibraryModel>,
            rootList.value = value[1] as List<String>,
            tonalityList.value = value[2] as List<String>,
            keysList.value = rootList,
            scales.value = tonalityList,
          },
        );
  }

  Future<void> fetchDefaultLists() async {
    isListLoading(true);

    itemsList.clear();
    toFindList.clear();
    activeStringList.clear();
    itemsList.assignAll(mainList);
    update();
    isListLoading(false);

    return;
  }

  Future<void> fetchScalesList() async {
    // scales.clear();
    // for (var i = 0; i < allChords.length; i++) {
    //   scales.add('${allChords[i]['set'][0]['scale']}');
    // }
    // print("length>>> ${allChords.length}");
  }

  Future<void> setToDefault() async {
    isRestoring(true);
    for (var i = 0; i < itemsList.length; i++) {
      for (var a = 0; a < 6; a++) {
        if ((itemsList[i][a].dot == 'o'.obs) ||
            (itemsList[i][a].dot == 'x'.obs)) {
          itemsList[i][a].dot = ''.obs;
        }
      }
    }

    isRestoring(false);

    update();
  }

  Future<void> addNotes({required int pos, required int index}) async {
    addingKeyNote(true);
    matchFound(false);
    print('pos $pos::::index $index');

    if (itemsList[pos][index].dot.value != 'o' &&
        !activeStringList.contains(index)) {
      activeStringList.add(index);

      itemsList[pos][index].dot.value = 'o';
      toFindList.add(
        pos == 0 ? pos : pos + 1,
      );
    } else if (itemsList[pos][index].dot.value == 'o') {
      itemsList[pos][index].dot.value = '';
      activeStringList.remove(index);

      toFindList.remove(
        pos == 0 ? pos : pos + 1,
      );

      itemsList.refresh();
      toFindList.refresh();
      activeStringList.refresh();
    }
    update();
    print('toFindList ${toFindList}:::${activeStringList}');
    addingKeyNote(false);
  }

  Future<void> addToFind(int key, int index) async {
    print('toFindList ${toFindList}:::${activeStringList}');
  }

  Future<void> findMatch() async {
    if (dropdownCategoryValue.value.isNotEmpty) {
      if (tabItem.value == 0) {
        final stringToMatch = _getFilteredString(toFindList.toString());

        if (stringToMatch.isEmpty) {
          return;
        }
        final mapStringFret = <int, int>{};
        for (var i = 0; i < activeStringList.length; i++) {
          mapStringFret.addIf(true, activeStringList[i], toFindList[i]);
        }

        switch (dropdownCategoryValue.value) {
          case 'Chords':
            isFinding(true);
            matchedChords.clear();
            for (var j = 0; j < chordLibraryList.length; j++) {
              final dictionary = chordLibraryList[j];
              final chordsList = <Chord>[];
              for (final chord in dictionary.variationsList) {
                if (!(chord.p.contains('16') &&
                    chord.p.contains('17') &&
                    chord.p.contains('18') &&
                    chord.p.contains('19') &&
                    chord.p.contains('20'))) {
                  var foundLength = 0;
                  final pList = chord.p.split(',');
                  final mapStringFretKeys = mapStringFret.keys;
                  try {
                    for (final key in mapStringFretKeys) {
                      if (pList[key] != 'x' &&
                          pList[key] != 'X' &&
                          int.parse(pList[key]) == mapStringFret[key]) {
                        foundLength += 1;
                      }
                    }

                    if (foundLength == mapStringFretKeys.length) {
                      chordsList.add(chord);
                    }
                  } catch (error) {
                    print("exp==${chord.p}");
                    print(error);
                  }
                }
              }
              if (chordsList.isNotEmpty) {
                matchedChords.add(
                  ChordLibraryModel(
                      chordLibraryList[j].scale,
                      chordLibraryList[j].root,
                      chordLibraryList[j].tonality,
                      chordsList),
                );
              }
            }

            if (matchedChords.isNotEmpty) {
              matchFound(true);
              mainListCurrentIndex.value = 0;
              subListCurrentIndex.value = 0;
              currentScale.value = matchedChords[0].scale;
              giveSuggestion(
                  matchedChords[0].variationsList[0].p, matchedChords[0].scale);

              if (matchedChords[0].variationsList.length > 0) {
                subListCurrentIndex++;
              }
              update(matchedChords);
            }

            isFinding(false);
            break;
          case 'Scales':
            break;
          case 'Arpeggios':
            break;
        }
      } else {
        switch (dropdownCategoryValue.value) {
          case 'Chords':
            if (dropdownRootValue.value.isNotEmpty &&
                dropdownTonalityValue.value.isNotEmpty) {
              refrenceList();
              isFinding(true);
              var exploreMatchList = <ChordLibraryModel>[];
              await getExploreMatchList().then(
                (value) => {
                  exploreMatchList = value,
                },
              );

              if (exploreMatchList.isNotEmpty) {
                for (var j = 0; j < exploreMatchList.length; j++) {
                  final dictionary = exploreMatchList[j];
                  final chordsList = <Chord>[];
                  for (final chord in dictionary.variationsList) {
                    if (!(chord.p.contains('16') ||
                        chord.p.contains('17') ||
                        chord.p.contains('18') ||
                        chord.p.contains('19') ||
                        chord.p.contains('20'))) {
                      try {
                        chordsList.add(chord);
                      } catch (error) {
                        print("exp==${chord.p}");
                        print(error);
                      }
                    }
                  }
                  if (chordsList.isNotEmpty) {
                    matchedChords.add(
                      ChordLibraryModel(
                        exploreMatchList[j].scale,
                        exploreMatchList[j].root,
                        exploreMatchList[j].tonality,
                        chordsList,
                      ),
                    );
                  }
                }

                if (matchedChords.isNotEmpty) {
                  matchFound(true);
                  mainListCurrentIndex.value = 0;
                  subListCurrentIndex.value = 0;
                  currentScale.value = matchedChords[0].scale;
                  giveSuggestion(matchedChords[0].variationsList[0].p,
                      matchedChords[0].scale);

                  if (matchedChords[0].variationsList.length > 0) {
                    subListCurrentIndex++;
                  }
                  update(matchedChords);
                }

                isFinding(false);
              } else {
                isFinding(false);
                matchFound(false);
              }
            }
            break;
          case 'Scales':
            break;
          case 'Arpeggios':
            break;
        }
      }
    }
  }

  Future<List<ChordLibraryModel>> getExploreMatchList() async {
    final chordExploreList = <ChordLibraryModel>[];
    final String scale =
        dropdownRootValue.value.trim() + dropdownTonalityValue.value.trim();
    for (var i = 0; i < chordLibraryList.length; i++) {
      final chord = chordLibraryList[i];
      if (chord.scale == scale) {
        chordExploreList.add(chord);
      }
    }

    return chordExploreList;
  }

  Future<void> giveSuggestion(String? p, String scale) async {
    await setToDefault();
    await fetchDefaultLists();
    try {
      if (p != null) {
        final list = p.split(',');
        for (var i = 0; i < list.length; i++) {
          if ((list[i] != 'x') && (list[i] != 'X')) {
            itemsList[int.parse(list[i]) == 0 ? 0 : int.parse(list[i]) - 1][i]
                .dot = 'o'.obs;
          }
        }
        currentScale.value = scale;
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> setTabItem(int tabId) async {
    tabItem.value = tabId;
    refreshLists();
  }

  void setCategoryValue(String? value) {
    if (value != null) {
      dropdownCategoryValue.value = value;
      switch (value) {
        case 'Chords':
          keysList.value = rootList;
          scales.value = tonalityList;
          break;
        case 'Scales':
          break;
        case 'Arpeggios':
          break;
      }
    }
  }

  void setDropdownRootValue(String value) {
    dropdownRootValue.value = value;
  }

  void setDropdownTonalityValue(String value) {
    dropdownTonalityValue.value = value;
  }

  Future<void> refreshLists() async {
    activeStringList.clear;
    matchedChords.clear();
    await setToDefault();
    matchFound(false);
    await fetchScalesList();
    await fetchDefaultLists();
    mainListCurrentIndex.value = 0;
    subListCurrentIndex.value = 0;
  }

  String _getFilteredString(String str) {
    str = str.replaceAll('[', '');
    str = str.replaceAll(']', '');
    str = str.replaceAll(' ', '');
    return str;
  }

  Future<void> onClickNext() async {
    if ((mainListCurrentIndex.value >= 0) &&
        (mainListCurrentIndex.value < matchedChords.length)) {
      if ((subListCurrentIndex.value >= 0) &&
          (subListCurrentIndex.value <
              matchedChords[mainListCurrentIndex.value]
                  .variationsList
                  .length)) {
        await giveSuggestion(
          matchedChords[mainListCurrentIndex.value]
              .variationsList[subListCurrentIndex.value]
              .p,
          matchedChords[mainListCurrentIndex.value].scale,
        );
        // print(
        //     "plus_first_bloc==subindex==${subListCurrentIndex.value}== mainindex==${mainListCurrentIndex.value} == listsize==${matchedChords[mainListCurrentIndex.value].variationsList[subListCurrentIndex.value]}");
        subListCurrentIndex.value++;
        isLeftClicked.value = true;
      } else {
        if (mainListCurrentIndex.value < matchedChords.length - 1) {
          mainListCurrentIndex.value++;
          subListCurrentIndex.value = 0;
          if (mainListCurrentIndex.value < matchedChords.length) {
            await giveSuggestion(
              matchedChords[mainListCurrentIndex.value]
                  .variationsList[subListCurrentIndex.value]
                  .p,
              matchedChords[mainListCurrentIndex.value].scale,
            );
            // print(
            //     "plus_second_bloc==subindex==${subListCurrentIndex.value}== mainindex==${mainListCurrentIndex.value} == listsize==${matchedChords[mainListCurrentIndex.value].variationsList[subListCurrentIndex.value]}");
            subListCurrentIndex.value++;
            isLeftClicked.value = true;
          }
        }
      }
    }
  }

  Future<void> onClickPrevious() async {
    if ((mainListCurrentIndex.value >= 0) &&
        (mainListCurrentIndex.value < matchedChords.length)) {
      if (isLeftClicked.value && subListCurrentIndex.value > 0) {
        subListCurrentIndex.value--;
        isLeftClicked.value = false;
      }

      if (subListCurrentIndex.value == 0 &&
          mainListCurrentIndex.value > 0 &&
          mainListCurrentIndex.value < matchedChords.length) {
        mainListCurrentIndex.value--;
        subListCurrentIndex.value =
            matchedChords[mainListCurrentIndex.value].variationsList.length;
      }

      if (subListCurrentIndex.value > 0) {
        subListCurrentIndex.value--;
      }

      await giveSuggestion(
        matchedChords[mainListCurrentIndex.value]
            .variationsList[subListCurrentIndex.value]
            .p,
        matchedChords[mainListCurrentIndex.value].scale,
      );
      // print(
      //     "minus_firstbloc==subindex==${subListCurrentIndex.value}== mainindex==${mainListCurrentIndex.value} == listsize==${matchedChords[mainListCurrentIndex.value].variationsList[subListCurrentIndex.value]}");
      if (subListCurrentIndex.value == 0 && mainListCurrentIndex.value == 0) {
        subListCurrentIndex.value =
            matchedChords[mainListCurrentIndex.value].variationsList.length;
      }
    }
  }
}
