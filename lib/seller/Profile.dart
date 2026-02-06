import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentswap/seller/seller_controller.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final SellerController controller = Get.find<SellerController>();

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Change profile'),
                    content: const Text(
                        'Do you want to change or remove profile picture?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          controller.isSetImage.value = false;
                          Get.back();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          controller.isSetImage.value = true;
                          controller.changeprofile();
                          Get.back();
                        },
                        child: const Text('Change'),
                      ),
                    ],
                  ),
                );
              },
              child: Center(
                child: Obx(() {
                  ImageProvider? imageProvider;

                  if (controller.isSetImage.value &&
                      controller.pickedprofimg != null) {
                    imageProvider =
                        FileImage(File(controller.pickedprofimg!));
                  } else if (controller.profile.image.isNotEmpty) {
                    imageProvider =
                        FileImage(File(controller.profile.image));
                  }

                  return CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: imageProvider,
                    child: imageProvider == null
                        ? const Icon(Icons.person, size: 45)
                        : null,
                  );
                }),
              ),
            ),
          ),

          const SizedBox(height: 8),

          _profileCard(
            icon: Icons.person,
            title: "Personal Details",
            onTap: () {
              // Navigate to edit details
            },
          ),

          Obx(() => _profileCard(
                icon: Icons.inventory,
                title: "My Listings",
                trailing: Text(
                  controller.products.length.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                onTap: () {
                  // Navigate to listings screen
                },
              )),
          _profileCard(
            icon: Icons.star,
            title: "Ratings",
            trailing:
                const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),

          const SizedBox(height: 12),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                // Logout logic
              },
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
  Widget _profileCard({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing:
            trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
