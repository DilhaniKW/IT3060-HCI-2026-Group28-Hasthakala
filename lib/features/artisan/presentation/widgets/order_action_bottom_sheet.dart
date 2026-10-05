import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/shared_models/order_model.dart';
import '../../../../core/widgets/custom_button.dart';

class OrderActionBottomSheet extends StatelessWidget {
  final OrderModel order;
  final ValueChanged<OrderStatus> onStatusChanged;

  const OrderActionBottomSheet({
    Key? key,
    required this.order,
    required this.onStatusChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Update Order #${order.id}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text('Customer Shipping Details:',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          Text(order.shippingAddress, style: const TextStyle(color: AppColors.textSecondary)),
          Text('Tel: ${order.contactPhone}', style: const TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 16),
          const Text('Set Craft Progress:',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: OrderStatus.values.map((status) {
              final isCurrent = order.status == status;
              return ChoiceChip(
                label: Text(status.name.toUpperCase()),
                selected: isCurrent,
                selectedColor: AppColors.primary,
                labelStyle: TextStyle(color: isCurrent ? Colors.white : AppColors.textPrimary),
                onSelected: (selected) {
                  if (selected) {
                    onStatusChanged(status);
                    Navigator.pop(context);
                  }
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Close',
            isOutlined: true,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
