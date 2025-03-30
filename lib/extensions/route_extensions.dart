import 'package:flutter/material.dart';

extension RouteExtensions on Route {
  bool get isRoot => settings.name == "/";
}
