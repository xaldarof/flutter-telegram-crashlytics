import 'package:json_annotation/json_annotation.dart';

part 'report_model.g.dart';

@JsonSerializable()
class ReportModel {
  @JsonKey(name: 'chat_id')
  String chartId;
  @JsonKey(name: 'text')
  String text;

  ReportModel({
    required this.chartId,
    required this.text,
  });

  Map<String, dynamic> toJson() => _$ReportModelToJson(this);
}
