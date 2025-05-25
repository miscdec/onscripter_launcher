import 'package:json_annotation/json_annotation.dart';
import 'package:onscripter_launcher/models/game_file.dart';

part 'onsyuri_index.g.dart';

@JsonSerializable()
class OnsyuriIndex {
  final String title;
  final String gamedir;
  final String savedir;
  final List<String> args;
  @JsonKey(defaultValue: "false")
  final String lazyload;
  final List<GameFile> files;

  const OnsyuriIndex({
    required this.title,
    required this.gamedir,
    required this.savedir,
    required this.args,
    this.lazyload = "false",
    required this.files,
  });

  factory OnsyuriIndex.fromJson(Map<String, dynamic> json) => _$OnsyuriIndexFromJson(json);
  Map<String, dynamic> toJson() => _$OnsyuriIndexToJson(this);

  OnsyuriIndex copyWith({
    String? title,
    String? gamedir,
    String? savedir,
    List<String>? args,
    String? lazyload,
    List<GameFile>? files,
  }) {
    return OnsyuriIndex(
      title: title ?? this.title,
      gamedir: gamedir ?? this.gamedir,
      savedir: savedir ?? this.savedir,
      args: args ?? this.args,
      lazyload: lazyload ?? this.lazyload,
      files: files ?? this.files,
    );
  }
} 