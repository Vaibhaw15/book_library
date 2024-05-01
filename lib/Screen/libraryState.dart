import '../libraryModel/libraryModels.dart';

abstract class LibraryState{
  LibraryState() : super();
}

class LibraryInitialState extends LibraryState{
  LibraryInitialState() : super();
}

class LibraryLoadingState extends LibraryState{
  final bool loaderVisibility;
  LibraryLoadingState(this.loaderVisibility) : super();

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LibraryLoadingState &&
        o.loaderVisibility == loaderVisibility;
  }

  @override
  int get hashCode => loaderVisibility.hashCode;
}

class LibraryLoadedState extends LibraryState{
  List<ReadingLogEntries>? data;
  List<bool> isRead = [];
  LibraryLoadedState(this.data,this.isRead) : super();
}