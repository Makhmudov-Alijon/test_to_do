import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TaskModel {
  String title;
  String? color;
  String? date;
  String id;

  TaskModel(this.id, this.title, this.color, this.date);

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);
}
