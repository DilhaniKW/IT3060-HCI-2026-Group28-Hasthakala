import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/shared_models/support_models.dart';

/// The three I13 permission toggles + the locked "Sensitive account functions" row . Used by Add Support
/// User and Support User Details so both stay consistent.
class SupportScopeToggles extends StatelessWidget {
  final SupportScopes scopes;
  final ValueChanged<SupportScopes>? onChanged; // null = read-only

  const SupportScopeToggles({super.key, required this.scopes, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ToggleRow(
          title: 'Manage products',
          subtitle: 'Add, edit and update products',
          value: scopes.products,
          onChanged: onChanged == null
              ? null
              : (v) => onChanged!(scopes.copyWith(products: v)),
        ),
        _ToggleRow(
          title: 'Manage orders',
          subtitle: 'View and update order status',
          value: scopes.orders,
          onChanged: onChanged == null
              ? null
              : (v) => onChanged!(scopes.copyWith(orders: v)),
        ),
        _ToggleRow(
          title: 'Respond to customers',
          subtitle: 'Reply to messages about orders',
          value: scopes.communication,
          onChanged: onChanged == null
              ? null
              : (v) => onChanged!(scopes.copyWith(communication: v)),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.divider,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            children: [
              Icon(Icons.lock_outline, size: 20, color: AppColors.textSecondary),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sensitive account functions',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    Text('Owner only', style: TextStyle(color: AppColors.textSecondary)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;

  const _ToggleRow({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        activeThumbColor: AppColors.onPrimary,
        activeTrackColor: AppColors.accent,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: const TextStyle(color: AppColors.textSecondary)),
      ),
    );
  }
}
