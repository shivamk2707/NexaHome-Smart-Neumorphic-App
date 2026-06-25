import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../data/models/scene_model.dart';
import '../../devices/bloc/device_cubit.dart';

class SceneCubit extends Cubit<List<SceneModel>> {
  SceneCubit() : super(_initialScenes);

  static final List<SceneModel> _initialScenes = [
    const SceneModel(
      id: 's1',
      name: 'Movie Time',
      icon: Icons.movie,
      actions: [
        SceneAction(deviceId: 'd1', deviceName: 'Smart AC', targetIsOn: true),
        SceneAction(deviceId: 'd2', deviceName: 'Main Light', targetIsOn: false),
      ]
    ),
    const SceneModel(
      id: 's2',
      name: 'Dinner',
      icon: Icons.restaurant,
      actions: [
        SceneAction(deviceId: 'd2', deviceName: 'Main Light', targetIsOn: true),
      ]
    ),
    const SceneModel(
      id: 's3',
      name: 'Party',
      icon: Icons.celebration,
      actions: [
        SceneAction(deviceId: 'd2', deviceName: 'Main Light', targetIsOn: true),
        SceneAction(deviceId: 'd4', deviceName: 'Ceiling Fan', targetIsOn: true),
      ]
    ),
    const SceneModel(
      id: 's4',
      name: 'Leaving Home',
      icon: Icons.directions_walk,
      actions: [
        SceneAction(deviceId: 'd1', deviceName: 'Smart AC', targetIsOn: false),
        SceneAction(deviceId: 'd2', deviceName: 'Main Light', targetIsOn: false),
        SceneAction(deviceId: 'd3', deviceName: 'Smart Door', targetIsOn: true),
        SceneAction(deviceId: 'd4', deviceName: 'Ceiling Fan', targetIsOn: false),
        SceneAction(deviceId: 'd5', deviceName: 'Smart TV', targetIsOn: false),
      ]
    ),
  ];

  void addScene(SceneModel scene) {
    emit([...state, scene]);
  }

  void executeScene(String id, DeviceCubit deviceCubit) {
    final scene = state.firstWhere((s) => s.id == id);
    final devices = deviceCubit.state;

    for (var action in scene.actions) {
      // Find the device
      try {
        final device = devices.firstWhere((d) => d.id == action.deviceId);
        if (device.isOn != action.targetIsOn) {
          deviceCubit.toggleDevice(device.id);
        }
      } catch (e) {
        // Device not found, ignore
      }
    }
  }
}
