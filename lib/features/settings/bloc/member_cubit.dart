import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/member_model.dart';

class MemberCubit extends Cubit<List<MemberModel>> {
  MemberCubit() : super(_initialMembers);

  static final List<MemberModel> _initialMembers = [
    const MemberModel(id: 'm1', name: 'Alex Johnson', role: 'Owner'),
    const MemberModel(id: 'm2', name: 'Sarah Johnson', role: 'Admin'),
    const MemberModel(id: 'm3', name: 'Guest', role: 'Member'),
  ];

  void addMember(MemberModel member) {
    emit([...state, member]);
  }

  void updateMember(MemberModel updatedMember) {
    final updatedList = state.map((m) {
      if (m.id == updatedMember.id) return updatedMember;
      return m;
    }).toList();
    emit(updatedList);
  }

  void removeMember(String id) {
    final updatedList = state.where((m) => m.id != id).toList();
    emit(updatedList);
  }
}
