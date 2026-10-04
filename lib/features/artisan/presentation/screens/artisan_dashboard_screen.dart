import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../state/artisan_dashboard_provider.dart';
import '../widgets/artisan_metric_card.dart';
import 'add_edit_product_screen.dart';
import 'artisan_orders_screen.dart';
import 'manage_products_screen.dart';

/// Assigned to: KUMARI R. P. G. D.
/// Branch: feature/artisan-management
class ArtisanDashboardScreen extends StatefulWidget {
  final String artisanId;

  const ArtisanDashboardScreen({Key? key, this.artisanId = 'sample_artisan_id'})
      : super(key: key);

  @override
  State<ArtisanDashboardScreen> createState() => _ArtisanDashboardScreenState();
}

class _ArtisanDashboardScreenState extends State<ArtisanDashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ArtisanDashboardProvider>().listenToArtisanProducts(widget.artisanId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Artisan Workshop Hub',
        showBackButton: false,
      ),
      body: Consumer<ArtisanDashboardProvider>(
        builder: (context, provider, _) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Shop Overview',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ArtisanMetricCard(
                      title: 'Active Products',
                      value: '${provider.activeListings}',
                      icon: Icons.inventory_2_outlined,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: ArtisanMetricCard(
                      title: 'Pending Orders',
                      value: '3',
                      icon: Icons.local_shipping_outlined,
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Quick Workshop Actions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ListTile(
                tileColor: AppColors.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: AppColors.border),
                ),
                leading: const CircleAvatar(
                  backgroundColor: AppColors.primaryLight,
                  child: Icon(Icons.add, color: Colors.white),
                ),
                title: const Text('Add New Craft Creation',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Publish pottery, batik, woodcraft listings'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddEditProductScreen(artisanId: widget.artisanId),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              ListTile(
                tileColor: AppColors.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: AppColors.border),
                ),
                leading: const CircleAvatar(
                  backgroundColor: AppColors.secondary,
                  child: Icon(Icons.list_alt, color: Colors.white),
                ),
                title: const Text('Manage Product Catalog',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Edit prices, update stock (${provider.totalListings} items)'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ManageProductsScreen(artisanId: widget.artisanId),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              ListTile(
                tileColor: AppColors.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: AppColors.border),
                ),
                leading: const CircleAvatar(
                  backgroundColor: AppColors.accent,
                  child: Icon(Icons.shopping_bag_outlined, color: Colors.white),
                ),
                title: const Text('Customer Craft Orders',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Fulfill, update status, and manage dispatches'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ArtisanOrdersScreen()),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
