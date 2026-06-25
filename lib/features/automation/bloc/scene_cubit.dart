import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../data/models/scene_model.dart';
import '../../devices/bloc/device_cubit.dart';

class SceneCubit extends Cubit<List<SceneModel>> {
  SceneCubit() : super(_initialScenes);

  static final List<SceneModel> _initialScenes = [
    const SceneModel(id: 's1', name: 'Movie Time', icon: Icons.movie),
    const SceneModel(id: 's2', name: 'Dinner', icon: Icons.restaurant),
    const SceneModel(id: 's3', name: 'Party', icon: Icons.celebration),
    const SceneModel(id: 's4', name: 'Focus', icon: Icons.center_focus_strong),
  ];

  void addScene(SceneModel scene) {
    emit([...state, scene]);
  }

  void executeScene(String id, DeviceCubit deviceCubit) {
    final devices = deviceCubit.state;
    final scene = state.firstWhere((s) => s.id == id);

    if (scene.name.toLowerCase().contains('movie')) {
      for (var d in devices) {
        if (d.isOn) deviceCubit.toggleDevice(d.id);
      }
    } else if (scene.name.toLowerCase().contains('party')) {
      for (var d in devices) {
        if (!d.isOn) deviceCubit.toggleDevice(d.id);
      }
    } else {
      if (devices.isNotEmpty) {
        deviceCubit.toggleDevice(devices.first.id);
      }
    }
  }
}
