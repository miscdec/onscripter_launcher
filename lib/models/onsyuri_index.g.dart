// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onsyuri_index.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OnsyuriIndex _$OnsyuriIndexFromJson(Map<String, dynamic> json) => OnsyuriIndex(
      title: json['title'] as String,
      gamedir: json['gamedir'] as String,
      savedir: json['savedir'] as String,
      args: (json['args'] as List<dynamic>).map((e) => e as String).toList(),
      lazyload: json['lazyload'] as String? ?? 'false',
      files: (json['files'] as List<dynamic>)
          .map((e) => GameFile.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OnsyuriIndexToJson(OnsyuriIndex instance) =>
    <String, dynamic>{
      'title': instance.title,
      'gamedir': instance.gamedir,
      'savedir': instance.savedir,
      'args': instance.args,
      'lazyload': instance.lazyload,
      'files': instance.files,
    };
