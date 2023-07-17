import 'package:flutter/material.dart';

@immutable
abstract class LoginPageEvents {}

class BindChangeClickEvent extends LoginPageEvents {
  final String name;

  BindChangeClickEvent({
    required this.name,
  });
}

class SetRandomTempNameEvent extends LoginPageEvents {
  SetRandomTempNameEvent();
}
