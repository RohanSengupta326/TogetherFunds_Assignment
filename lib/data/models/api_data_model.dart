// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ApiDataModel {
  ApiDataModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image_url,
  });

  final int id;
  final String title;
  final String description;
  final String image_url;
  //

  // JSON seriealization & deserialization

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'image_url': image_url,
    };
  }

  factory ApiDataModel.fromMap(Map<String, dynamic> map) {
    return ApiDataModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      image_url: map['image_url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiDataModel.fromJson(String source) =>
      ApiDataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
