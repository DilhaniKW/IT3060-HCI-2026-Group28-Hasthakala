import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/shared_models/order_model.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/empty_state_view.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../state/artisan_orders_provider.dart';
import '../widgets/order_action_bottom_sheet.dart';

/// Assigned to: KUMARI R. P. G. D.
/// Branch: feature/artisan-management
class ArtisanOrdersScreen extends StatefulWidget {
  const ArtisanOrdersScreen({Key? key}) : super(key: key);

  @override
  State<ArtisanOrdersScreen> createState() => _ArtisanOrdersScreenState();
}

class _ArtisanOrdersScreenState extends State<ArtisanOrdersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ArtisanOrdersProvider>().listenToOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Customer Orders'),
      body: Consumer<ArtisanOrdersProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const LoadingIndicator(message: 'Loading orders...');
          }

          if (provider.incomingOrders.isEmpty) {
            return const EmptyStateView(
              icon: Icons.local_shipping_outlined,
              title: 'No pending orders',
              description: 'When buyers purchase your craft items, orders appear here.',
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.incomingOrders.length,
            itemBuilder: (context, index) {
              final order = provider.incomingOrders[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Order #${order.id}',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            order.status.name.toUpperCase(),
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('Buyer: ${order.buyerName}'),
                    Text('Total: ${CurrencyFormatter.formatLKR(order.totalAmountLkr)}',
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        icon: const Icon(Icons.edit, size: 16),
                        label: const Text('Manage Fulfillment'),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) => OrderActionBottomSheet(
                              order: order,
                              onStatusChanged: (newStatus) {
                                provider.changeOrderStatus(order.id, newStatus);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
