// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) => ReportModel(
      chartId: json['chat_id'] as String,
      text: json['text'] as String,
    );

Map<String, dynamic> _$ReportModelToJson(ReportModel instance) =>
    <String, dynamic>{
      'chat_id': instance.chartId,
      'text': instance.text,
    };
