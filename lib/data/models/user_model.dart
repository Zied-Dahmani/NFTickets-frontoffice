import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class User with _$User {

  const factory User({
    required String? id,
    required String? fullName,
    required List<String> followers,
    required List<String> following,
  }) = _User;

  factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);

}
