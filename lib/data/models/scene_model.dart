import 'package:flutter/material.dart';

class SceneAction {
  final String deviceId;
  final String deviceName;
  final bool targetIsOn;

  const SceneAction({
    required this.deviceId,
    required this.deviceName,
    required this.targetIsOn,
  });
}

class SceneModel {
  final String id;
  final String name;
  final IconData icon;
  final List<SceneAction> actions;

  const SceneModel({
    required this.id,
    required this.name,
    required this.icon,
    this.actions = const [],
  });
}
