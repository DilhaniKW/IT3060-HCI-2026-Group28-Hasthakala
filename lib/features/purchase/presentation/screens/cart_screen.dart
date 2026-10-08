import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/tr.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/empty_state_view.dart';
import '../state/cart_provider.dart';
import '../widgets/cart_item_tile.dart';

/// Assigned to: DISSANAYAKE D. M. S. D. (Member 2)
/// Feature: Buyer Purchase & Checkout (I06)
/// Branch: feature/buyer-purchase
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          context.tr('my_cart'),
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, _) {
          if (cart.cartItems.isEmpty) {
            return EmptyStateView(
              icon: Icons.shopping_bag_outlined,
              title: context.tr('cart_empty_title'),
              description: context.tr('cart_empty_desc'),
              actionButtonText: context.tr('discover_crafts'),
              onActionPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.home,
                  (route) => false,
                );
              },
            );
          }

          return Column(
            children: [
              // Items List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: cart.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cart.cartItems[index];
                    return CartItemTile(
                      item: item,
                      onQuantityChanged: (newQty) {
                        cart.updateQuantity(item.productId, newQty);
                      },
                      onRemove: () {
                        cart.removeItem(item.productId);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(context.tr('item_removed')),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              // Price Breakdown Box (bottom, sticky)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 12,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Subtotal
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            context.tr('subtotal'),
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            CurrencyFormatter.formatLKR(cart.subtotalLkr),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Islandwide Delivery (flat Rs. 450)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            context.tr('islandwide_delivery'),
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            CurrencyFormatter.formatLKR(cart.deliveryFeeLkr),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Artisan Packaging (flat Rs. 200)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            context.tr('artisan_packaging'),
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            CurrencyFormatter.formatLKR(cart.packagingFeeLkr),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Divider(color: AppColors.border, height: 1),
                      ),

                      // Total Price (bold, larger)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            context.tr('total'),
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            CurrencyFormatter.formatLKR(cart.totalLkr),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Action Button: Proceed to Checkout
                      CustomButton(
                        text: '${context.tr('proceed_to_checkout')} (${cart.totalItemCount})',
                        onPressed: () {
                          Navigator.of(context).pushNamed(AppRoutes.checkout);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
