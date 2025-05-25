import 'package:json_annotation/json_annotation.dart';

part 'game_file.g.dart';

@JsonSerializable()
class GameFile {
  final String path;
  final String url;

  const GameFile({
    required this.path,
    required this.url,
  });

  factory GameFile.fromJson(Map<String, dynamic> json) => _$GameFileFromJson(json);
  Map<String, dynamic> toJson() => _$GameFileToJson(this);

  GameFile copyWith({
    String? path,
    String? url,
  }) {
    return GameFile(
      path: path ?? this.path,
      url: url ?? this.url,
    );
  }
} 