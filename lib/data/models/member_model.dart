class MemberModel {
  final String id;
  final String name;
  final String role;
  final String relation;
  final String? profileImageUrl;

  const MemberModel({
    required this.id,
    required this.name,
    required this.role,
    this.relation = 'Family',
    this.profileImageUrl,
  });

  MemberModel copyWith({
    String? id,
    String? name,
    String? role,
    String? relation,
    String? profileImageUrl,
  }) {
    return MemberModel(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      relation: relation ?? this.relation,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }
}
