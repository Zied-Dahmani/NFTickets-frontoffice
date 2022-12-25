// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Event _$$_EventFromJson(Map<String, dynamic> json) => _$_Event(
      id: json['id'],
      name: json['name'] as String,
      image: json['image'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      description: json['description'] as String,
    );

Map<String, dynamic> _$$_EventToJson(_$_Event instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'dateTime': instance.dateTime.toIso8601String(),
      'description': instance.description,
    };
