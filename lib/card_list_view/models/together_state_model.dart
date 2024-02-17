// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../../data/models/api_data_model.dart';
import '../../repository/models/together_repository_model.dart';

class TogetherStateModel extends Equatable {
  final int id;
  final String title;
  final String description;
  final String image_url;
  TogetherStateModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image_url,
  });

  TogetherStateModel copyWith({
    int? id,
    String? title,
    String? description,
    String? image_url,
  }) {
    return TogetherStateModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      image_url: image_url ?? this.image_url,
    );
  }

  @override
  List<Object> get props => [id, title, description, image_url];
}
