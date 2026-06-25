import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_button.dart';
import '../../../core/widgets/neumorphic_container.dart';
import '../bloc/member_cubit.dart';
import '../../../data/models/member_model.dart';

class HomeMembersScreen extends StatefulWidget {
  const HomeMembersScreen({super.key});

  @override
  State<HomeMembersScreen> createState() => _HomeMembersScreenState();
}

class _HomeMembersScreenState extends State<HomeMembersScreen> {
  final ImagePicker _picker = ImagePicker();

  void _showMemberSheet(BuildContext context, {MemberModel? member}) {
    final isEditing = member != null;
    final nameController = TextEditingController(text: member?.name ?? '');
    final relationController = TextEditingController(text: member?.relation ?? '');
    String role = member?.role ?? 'Member';
    String? profileImageUrl = member?.profileImageUrl;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return StatefulBuilder(builder: (context, setSheetState) {
          Future<void> _pickImage() async {
            try {
              final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                setSheetState(() => profileImageUrl = image.path);
              }
            } catch (e) {
              // Handle error, e.g. permission denied
            }
          }

          return Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
              left: 24.w,
              right: 24.w,
              top: 24.h,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(isEditing ? 'Edit Member' : 'Add Member', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
                SizedBox(height: 24.h),
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: NeumorphicContainer(
                      shape: BoxShape.circle,
                      width: 80.w,
                      height: 80.w,
                      padding: EdgeInsets.all(4.w),
                      child: ClipOval(
                        child: profileImageUrl != null
                            ? Image.file(File(profileImageUrl!), fit: BoxFit.cover)
                            : Icon(Icons.person, size: 40.w, color: AppColors.primary),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Center(child: Text('Tap to change photo', style: AppTextStyles.labelSmall(AppColors.lightTextSecondary))),
                SizedBox(height: 24.h),
                Text('Name', style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
                SizedBox(height: 8.h),
                NeumorphicContainer(
                  isPressed: true,
                  borderRadius: 16.r,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(border: InputBorder.none, hintText: 'Full Name'),
                    style: AppTextStyles.bodyMedium(Theme.of(context).colorScheme.onSurface),
                  ),
                ),
                SizedBox(height: 16.h),
                Text('Relation with Owner', style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
                SizedBox(height: 8.h),
                NeumorphicContainer(
                  isPressed: true,
                  borderRadius: 16.r,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: TextField(
                    controller: relationController,
                    decoration: const InputDecoration(border: InputBorder.none, hintText: 'e.g. Spouse, Child, Friend'),
                    style: AppTextStyles.bodyMedium(Theme.of(context).colorScheme.onSurface),
                  ),
                ),
                SizedBox(height: 16.h),
                Text('Role', style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
                SizedBox(height: 8.h),
                NeumorphicContainer(
                  isPressed: true,
                  borderRadius: 16.r,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: role,
                      isExpanded: true,
                      dropdownColor: Theme.of(context).colorScheme.surface,
                      items: ['Owner', 'Admin', 'Member'].map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
                      onChanged: (val) {
                        if (val != null) setSheetState(() => role = val);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                Row(
                  children: [
                    if (isEditing) ...[
                      Expanded(
                        child: NeumorphicButton(
                          onTap: () {
                            this.context.read<MemberCubit>().removeMember(member.id);
                            Navigator.pop(context);
                          },
                          borderRadius: 16.r,
                          child: Center(child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: Text('Remove', style: AppTextStyles.labelMedium(AppColors.error)),
                          )),
                        ),
                      ),
                      SizedBox(width: 16.w),
                    ],
                    Expanded(
                      flex: 2,
                      child: NeumorphicButton(
                        onTap: () {
                          if (nameController.text.isNotEmpty) {
                            final newMem = MemberModel(
                              id: isEditing ? member.id : 'm_${DateTime.now().millisecondsSinceEpoch}',
                              name: nameController.text,
                              role: role,
                              relation: relationController.text.isNotEmpty ? relationController.text : 'Family',
                              profileImageUrl: profileImageUrl,
                            );
                            if (isEditing) {
                              this.context.read<MemberCubit>().updateMember(newMem);
                            } else {
                              this.context.read<MemberCubit>().addMember(newMem);
                            }
                            Navigator.pop(context);
                          }
                        },
                        borderRadius: 16.r,
                        child: Center(child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: Text('Save', style: AppTextStyles.labelMedium(AppColors.primary)),
                        )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Home Members', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add, color: Theme.of(context).colorScheme.onSurface),
            onPressed: () => _showMemberSheet(context),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<MemberCubit, List<MemberModel>>(
          builder: (context, members) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              itemCount: members.length,
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                final member = members[index];
                return NeumorphicContainer(
                  borderRadius: 16.r,
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    children: [
                      NeumorphicContainer(
                        isPressed: true,
                        borderRadius: 24.r,
                        width: 48.w,
                        height: 48.w,
                        padding: EdgeInsets.all(4.w),
                        child: ClipOval(
                          child: member.profileImageUrl != null
                              ? Image.file(File(member.profileImageUrl!), fit: BoxFit.cover)
                              : Icon(Icons.person, color: AppColors.primary),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(member.name, style: AppTextStyles.labelMedium(Theme.of(context).colorScheme.onSurface)),
                            Text('${member.role} • ${member.relation}', style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit, color: AppColors.lightTextSecondary),
                        onPressed: () => _showMemberSheet(context, member: member),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
