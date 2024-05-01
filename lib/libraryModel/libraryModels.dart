class LibraryModels {
  LibraryModels({
      this.page, 
      this.numFound, 
      this.readingLogEntries,});

  LibraryModels.fromJson(dynamic json) {
    page = json['page'];
    numFound = json['numFound'];
    if (json['reading_log_entries'] != null) {
      readingLogEntries = [];
      json['reading_log_entries'].forEach((v) {
        readingLogEntries?.add(ReadingLogEntries.fromJson(v));
      });
    }
  }
  num? page;
  num? numFound;
  List<ReadingLogEntries>? readingLogEntries;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    map['numFound'] = numFound;
    if (readingLogEntries != null) {
      map['reading_log_entries'] = readingLogEntries?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ReadingLogEntries {
  ReadingLogEntries({
      this.work, 
      this.loggedEdition, 
      this.loggedDate,});

  ReadingLogEntries.fromJson(dynamic json) {
    work = json['work'] != null ? Work.fromJson(json['work']) : null;
    loggedEdition = json['logged_edition'];
    loggedDate = json['logged_date'];
  }
  Work? work;
  dynamic loggedEdition;
  String? loggedDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (work != null) {
      map['work'] = work?.toJson();
    }
    map['logged_edition'] = loggedEdition;
    map['logged_date'] = loggedDate;
    return map;
  }

}

class Work {
  Work({
      this.title, 
      this.key, 
      this.authorKeys, 
      this.authorNames, 
      this.firstPublishYear, 
      this.lendingEditionS, 
      this.editionKey, 
      this.coverId, 
      this.coverEditionKey,});

  Work.fromJson(dynamic json) {
    title = json['title'];
    key = json['key'];
    authorKeys = json['author_keys'] != null ? json['author_keys'].cast<String>() : [];
    authorNames = json['author_names'] != null ? json['author_names'].cast<String>() : [];
    firstPublishYear = json['first_publish_year'];
    lendingEditionS = json['lending_edition_s'];
    editionKey = json['edition_key'] != null ? json['edition_key'].cast<String>() : [];
    coverId = json['cover_id'];
    coverEditionKey = json['cover_edition_key'];
  }
  String? title;
  String? key;
  List<String>? authorKeys;
  List<String>? authorNames;
  num? firstPublishYear;
  dynamic lendingEditionS;
  List<String>? editionKey;
  num? coverId;
  String? coverEditionKey;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['key'] = key;
    map['author_keys'] = authorKeys;
    map['author_names'] = authorNames;
    map['first_publish_year'] = firstPublishYear;
    map['lending_edition_s'] = lendingEditionS;
    map['edition_key'] = editionKey;
    map['cover_id'] = coverId;
    map['cover_edition_key'] = coverEditionKey;
    return map;
  }

}