import 'package:freezed_annotation/freezed_annotation.dart';

part 'person.freezed.dart';

@freezed
class Person with _$Person {
  factory Person({
    required int id,
    required String name,
    required int age,
  }) = _Person;

  Person._();
  int get nameLength => name.length;
}
