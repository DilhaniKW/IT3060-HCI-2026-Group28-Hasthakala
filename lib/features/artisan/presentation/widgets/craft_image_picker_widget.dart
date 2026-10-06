import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class CraftImagePickerWidget extends StatelessWidget {
  final List<String> imageUrls;
  final VoidCallback onPickImage;

  const CraftImagePickerWidget({
    Key? key,
    required this.imageUrls,
    required this.onPickImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Craft Photographs',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 90,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              GestureDetector(
                onTap: onPickImage,
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border, style: BorderStyle.solid),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_photo_alternate_outlined, color: AppColors.primary),
                      SizedBox(height: 4),
                      Text('Upload', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
              ),
              ...imageUrls.map((url) => Container(
                    width: 90,
                    height: 90,
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
