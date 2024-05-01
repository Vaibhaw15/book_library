import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../libraryModel/libraryModels.dart';
import 'libraryState.dart';

class LibraryCubit extends Cubit<LibraryState>{
  LibraryCubit(): super(LibraryInitialState());
  LibraryModels? lib;
  List<ReadingLogEntries>? data;
  List<bool> isRead = [];


  Future<void> loadBooks() async {
    try {
      emit(LibraryLoadingState(true));
      String jsonString = await rootBundle.loadString('assets/book.json');
        lib = LibraryModels.fromJson(json.decode(jsonString));
        data = lib?.readingLogEntries;
        isRead = List.generate(data!.length, (index) => false);
        emit(LibraryLoadedState(data,isRead));
    } catch (error) {
      print('Error loading books: $error');
    }
  }


  void search(String text){
    data = [];
    for (var element in lib!.readingLogEntries!) {
      if(element.work!.title!.toLowerCase().contains(text)){
        data!.add(element);
        emit(LibraryLoadedState(data,isRead));
      }
    }

  }

  void clear(){
    data = lib?.readingLogEntries;
    emit(LibraryLoadedState(data,isRead));
  }

  void toggleStatus(int idx) {
      isRead[idx] = !isRead[idx];
    emit(LibraryLoadedState(data,isRead));
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}
