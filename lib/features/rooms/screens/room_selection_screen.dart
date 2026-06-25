import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_button.dart';
import '../../../core/widgets/neumorphic_container.dart';
import '../bloc/room_cubit.dart';
import '../../../data/models/room_model.dart';

class RoomSelectionScreen extends StatefulWidget {
  const RoomSelectionScreen({super.key});

  @override
  State<RoomSelectionScreen> createState() => _RoomSelectionScreenState();
}

class _RoomSelectionScreenState extends State<RoomSelectionScreen> {
  void _showAddRoomSheet(BuildContext context) {
    final nameController = TextEditingController();
    IconData selectedIcon = Icons.weekend;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
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
                  Text('Add New Room', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
                  SizedBox(height: 24.h),
                  Text('Room Name', style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
                  SizedBox(height: 8.h),
                  NeumorphicContainer(
                    isPressed: true,
                    borderRadius: 16.r,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(border: InputBorder.none, hintText: 'e.g. Guest Room'),
                      style: AppTextStyles.bodyMedium(Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text('Icon', style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
                  SizedBox(height: 8.h),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [Icons.weekend, Icons.bed, Icons.kitchen, Icons.bathtub, Icons.tv, Icons.work, Icons.garage].map((icon) {
                        final isSelected = selectedIcon == icon;
                        return Padding(
                          padding: EdgeInsets.only(right: 16.w),
                          child: GestureDetector(
                            onTap: () => setSheetState(() => selectedIcon = icon),
                            child: NeumorphicContainer(
                              isPressed: isSelected,
                              shape: BoxShape.circle,
                              padding: EdgeInsets.all(16.w),
                              child: Icon(icon, color: isSelected ? AppColors.primary : AppColors.lightTextSecondary),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: NeumorphicButton(
                      onTap: () {
                        if (nameController.text.isNotEmpty) {
                          final newRoom = RoomModel(
                            id: 'r_${DateTime.now().millisecondsSinceEpoch}',
                            name: nameController.text,
                            icon: selectedIcon,
                          );
                          this.context.read<RoomCubit>().addRoom(newRoom);
                          Navigator.pop(context);
                        }
                      },
                      borderRadius: 16.r,
                      child: Center(
                        child: Text('Add Room', style: AppTextStyles.labelMedium(AppColors.primary)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddRoomSheet(context),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Rooms', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: BlocBuilder<RoomCubit, List<RoomModel>>(
            builder: (context, rooms) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: rooms.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.w,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, index) {
                  final room = rooms[index];
                  return NeumorphicButton(
                    onTap: () => context.push('/room_details/${room.id}'),
                    borderRadius: 24.r,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(room.icon, size: 48.w, color: AppColors.primary),
                        SizedBox(height: 16.h),
                        Text(
                          room.name,
                          style: AppTextStyles.labelMedium(Theme.of(context).colorScheme.onSurface),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          ),
        ),
      ),
    );
  }
}
