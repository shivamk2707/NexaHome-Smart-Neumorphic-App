import 'package:flutter/material.dart';

enum DeviceType { ac, light, fan, lock, tv, camera }

class DeviceModel {
  final String id;
  final String name;
  final String roomId;
  final DeviceType type;
  final IconData icon;
  final bool isOn;

  // Specific properties
  final double? temperature;
  final double? brightness;
  final double? speed;
  final bool? isLocked;

  const DeviceModel({
    required this.id,
    required this.name,
    required this.roomId,
    required this.type,
    required this.icon,
    this.isOn = false,
    this.temperature,
    this.brightness,
    this.speed,
    this.isLocked,
  });

  DeviceModel copyWith({
    String? id,
    String? name,
    String? roomId,
    DeviceType? type,
    IconData? icon,
    bool? isOn,
    double? temperature,
    double? brightness,
    double? speed,
    bool? isLocked,
  }) {
    return DeviceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      roomId: roomId ?? this.roomId,
      type: type ?? this.type,
      icon: icon ?? this.icon,
      isOn: isOn ?? this.isOn,
      temperature: temperature ?? this.temperature,
      brightness: brightness ?? this.brightness,
      speed: speed ?? this.speed,
      isLocked: isLocked ?? this.isLocked,
    );
  }
}
