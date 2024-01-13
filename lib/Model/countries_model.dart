class CountryModel {
  CountryModel({
    required this.status,
    required this.success,
    required this.data,
    required this.pagination,
  });
  late final int status;
  late final bool success;
  late final List<Data> data;
  late final Pagination pagination;

  CountryModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    success = json['success'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
    pagination = Pagination.fromJson(json['pagination']);
  }
}

class Data {
  Data({
    required this.id,
    required this.countryCode,
    required this.name,
    required this.capital,
  });
  late final int id;
  late final String countryCode;
  late final String name;
  late final String capital;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id']??0;
    countryCode = json['country_code']??'';
    name = json['name']??'';
    capital = json['capital']??'';
  }
}

class Pagination {
  Pagination({
    required this.count,
    required this.total,
    required this.perPage,
    required this.currentPage,
    required this.totalPages,
    required this.links,
  });
  late final int count;
  late final int total;
  late final int perPage;
  late final int currentPage;
  late final int totalPages;
  late final Links links;

  Pagination.fromJson(Map<String, dynamic> json){
    count = json['count']??0;
    total = json['total']??0;
    perPage = json['perPage']??0;
    currentPage = json['currentPage']??0;
    totalPages = json['totalPages'??0];
    links = Links.fromJson(json['links']);
  }
}

class Links {
  Links({
    required this.next,
  });
  late final String next;

  Links.fromJson(Map<String, dynamic> json){
    next = json['next']??'';
  }
}