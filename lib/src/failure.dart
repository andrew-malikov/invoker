import 'package:dartz/dartz.dart';

abstract class Failure {
  final String message;
  final Option<Failure> related;

  Failure(this.message, [Option<Failure> related])
      : related = related ?? None();
}
