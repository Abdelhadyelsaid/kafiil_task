class DependenciesModel {
  DependenciesModel({
    required this.status,
    required this.success,
    required this.data,
  });
  late final int status;
  late final bool success;
  late final Data data;

  DependenciesModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    success = json['success'];
    data = Data.fromJson(json['data']);
  }

}

class Data {
  Data({
    required this.types,
    required this.tags,
    required this.socialMedia,
  });
  late final List<Types> types;
  late final List<DependTags> tags;
  late final List<SocialMedia> socialMedia;

  Data.fromJson(Map<String, dynamic> json){
    types = List.from(json['types']).map((e)=>Types.fromJson(e)).toList();
    tags = List.from(json['tags']).map((e)=>DependTags.fromJson(e)).toList();
    socialMedia = List.from(json['social_media']).map((e)=>SocialMedia.fromJson(e)).toList();
  }
}

class Types {
  Types({
    required this.value,
    required this.label,
  });
  late final int value;
  late final String label;

  Types.fromJson(Map<String, dynamic> json){
    value = json['value']??0;
    label = json['label']??'';
  }
}

class DependTags {
  DependTags({
    required this.value,
    required this.label,
  });
  late final int value;
  late final String label;

  DependTags.fromJson(Map<String, dynamic> json){
    value = json['value']??0;
    label = json['label']??'';
  }
}

class SocialMedia {
  SocialMedia({
    required this.value,
    required this.label,
  });
  late final String value;
  late final String label;

  SocialMedia.fromJson(Map<String, dynamic> json){
    value = json['value']??0;
    label = json['label']??'';
  }
}