import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../state/auth_provider.dart';

// I13 supporter home - cards open the existing Products / Orders tabs
class SupporterHomeScreen extends StatelessWidget {
  final ValueChanged<int> onOpenTab; // tab index: 1 products, 2 orders

  const SupporterHomeScreen({super.key, required this.onOpenTab});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final grant = auth.activeGrant;
    final firstName = (auth.currentUser?.displayName ?? '').split(' ').first;
    if (grant == null) return const SizedBox.shrink();

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('Hello $firstName',
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.textPrimary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('SUPPORTING',
                      style: TextStyle(
                          color: AppColors.secondaryLight,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1)),
                  const SizedBox(height: 4),
                  Text(grant.artisanName,
                      style: const TextStyle(
                          color: AppColors.onPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text('You can help with the following authorised activities:',
                style: TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 12),
            _ActivityCard(
              icon: Icons.inventory_2_outlined,
              title: 'Products',
              subtitle: 'Add, edit and update products',
              allowed: grant.scopes.products,
              onTap: () => onOpenTab(1),
            ),
            _ActivityCard(
              icon: Icons.receipt_long_outlined,
              title: 'Orders',
              subtitle: 'View and update order status',
              allowed: grant.scopes.orders,
              onTap: () => onOpenTab(2),
            ),
            _ActivityCard(
              icon: Icons.chat_bubble_outline,
              title: 'Order Communication',
              subtitle: 'Reply to customer queries related to authorised orders',
              allowed: grant.scopes.communication,
              onTap: () => onOpenTab(2), // chats are opened from an order
            ),
            const SizedBox(height: 12),
            const Text('Some account functions are not available in support mode.',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool allowed;
  final VoidCallback onTap;

  const _ActivityCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.allowed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        enabled: allowed,
        onTap: allowed ? onTap : null,
        leading: Icon(icon, color: allowed ? AppColors.primary : AppColors.textMuted),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(allowed ? subtitle : 'Not included in your access'),
        trailing: Icon(allowed ? Icons.chevron_right : Icons.lock_outline),
      ),
    );
  }
}
