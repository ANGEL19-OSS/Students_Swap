import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentswap/seller/seller_controller.dart';

class EditProfileDialog extends StatelessWidget {
  const EditProfileDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final SellerController controller = Get.find<SellerController>();

    final nameCtrl =
        TextEditingController(text: controller.user?.username ?? '');
    final phoneCtrl =
        TextEditingController(text: controller.profile.ph_no);
    final studentIdCtrl =
        TextEditingController(text: controller.user?.studentId ?? '');
    final yearCtrl =
        TextEditingController(text: controller.profile.year);
    final roomNoCtrl =
        TextEditingController(text: controller.profile.room_no);
    final deptCtrl =
        TextEditingController(text: controller.profile.dept_name);

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Edit Profile",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Divider(color: Colors.grey.shade300),
              const SizedBox(height: 12),
    
              _inputField(
                controller: nameCtrl,
                label: "Name",
                icon: Icons.person,
              ),
    
              _inputField(
                controller: studentIdCtrl,
                label: "Student ID",
                icon: Icons.badge,
              ),
    
              _inputField(
                controller: phoneCtrl,
                label: "Phone",
                icon: Icons.phone,
                keyboard: TextInputType.phone,
              ),
    
              _inputField(
                controller: yearCtrl,
                label: "Year",
                icon: Icons.school,
                keyboard: TextInputType.number,
              ),
    
              _inputField(
                controller: roomNoCtrl,
                label: "Room No",
                icon: Icons.meeting_room,
              ),
    
              _inputField(
                controller: deptCtrl,
                label: "Department",
                icon: Icons.apartment,
              ),
    
              const SizedBox(height: 20),
    
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final imagePath =
                            controller.pickedprofimg ??
                            controller.profile.image;
    
                        controller.UpdateProfile(
                          nameCtrl.text.trim(),
                          studentIdCtrl.text.trim(),
                          phoneCtrl.text.trim(),
                          roomNoCtrl.text.trim(),
                          yearCtrl.text.trim(),
                          deptCtrl.text.trim(),
                          imagePath,
                        );
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Save"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboard = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(    
        controller: controller,
        keyboardType: keyboard,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}
