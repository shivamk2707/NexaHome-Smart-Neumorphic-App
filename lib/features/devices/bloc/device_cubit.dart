import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../data/models/device_model.dart';

class DeviceCubit extends Cubit<List<DeviceModel>> {
  DeviceCubit() : super(_initialDevices);

  static final List<DeviceModel> _initialDevices = [
    const DeviceModel(id: 'd1', name: 'Smart AC', roomId: 'r1', type: DeviceType.ac, icon: Icons.ac_unit, isOn: true, temperature: 24.0),
    const DeviceModel(id: 'd2', name: 'Main Light', roomId: 'r1', type: DeviceType.light, icon: Icons.lightbulb_outline, isOn: false, brightness: 75.0),
    const DeviceModel(id: 'd3', name: 'Smart Door', roomId: 'r0', type: DeviceType.lock, icon: Icons.lock, isOn: true, isLocked: true),
    const DeviceModel(id: 'd4', name: 'Ceiling Fan', roomId: 'r1', type: DeviceType.fan, icon: Icons.air, isOn: false, speed: 2.0),
    const DeviceModel(id: 'd5', name: 'Smart TV', roomId: 'r1', type: DeviceType.tv, icon: Icons.tv, isOn: true),
  ];

  void toggleDevice(String id) {
    final updated = state.map((d) {
      if (d.id == id) {
        return d.copyWith(isOn: !d.isOn);
      }
      return d;
    }).toList();
    emit(updated);
  }

  void updateDevice(DeviceModel updatedDevice) {
    final updated = state.map((d) {
      if (d.id == updatedDevice.id) {
        return updatedDevice;
      }
      return d;
    }).toList();
    emit(updated);
  }

  void addDevice(DeviceModel newDevice) {
    emit([...state, newDevice]);
  }
}
