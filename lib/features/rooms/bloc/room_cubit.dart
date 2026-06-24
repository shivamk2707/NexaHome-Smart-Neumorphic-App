import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../data/models/room_model.dart';

class RoomCubit extends Cubit<List<RoomModel>> {
  RoomCubit() : super(_initialRooms);

  static final List<RoomModel> _initialRooms = [
    const RoomModel(id: 'r1', name: 'Living Room', icon: Icons.weekend),
    const RoomModel(id: 'r2', name: 'Bedroom', icon: Icons.bed),
    const RoomModel(id: 'r3', name: 'Kitchen', icon: Icons.kitchen),
    const RoomModel(id: 'r4', name: 'Bathroom', icon: Icons.bathtub),
  ];

  void addRoom(RoomModel newRoom) {
    emit([...state, newRoom]);
  }
}
