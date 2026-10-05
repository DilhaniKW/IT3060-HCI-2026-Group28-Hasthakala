import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/empty_state_view.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../state/artisan_dashboard_provider.dart';
import '../widgets/product_inventory_tile.dart';
import 'add_edit_product_screen.dart';

/// Assigned to: KUMARI R. P. G. D.
/// Branch: feature/artisan-management
class ManageProductsScreen extends StatelessWidget {
  final String artisanId;

  const ManageProductsScreen({Key? key, required this.artisanId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Craft Inventory',
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: AppColors.primary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddEditProductScreen(artisanId: artisanId),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<ArtisanDashboardProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const LoadingIndicator(message: 'Loading inventory...');
          }

          if (provider.myProducts.isEmpty) {
            return EmptyStateView(
              icon: Icons.inventory_2_outlined,
              title: 'No products in catalogue',
              description: 'Start showcasing your handicraft to customers worldwide.',
              actionButtonText: 'Add First Product',
              onActionPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddEditProductScreen(artisanId: artisanId),
                  ),
                );
              },
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.myProducts.length,
            itemBuilder: (context, index) {
              final product = provider.myProducts[index];
              return ProductInventoryTile(
                product: product,
                onEdit: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddEditProductScreen(
                        artisanId: artisanId,
                        productToEdit: product,
                      ),
                    ),
                  );
                },
                onDelete: () {
                  // Trigger delete confirmation dialog
                },
              );
            },
          );
        },
      ),
    );
  }
}
