import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';

import '../../../../core/widgets/loading_indicator.dart';
import '../state/discovery_provider.dart';
import '../../../../core/constants/craft_categories.dart';
import '../../../../core/widgets/empty_state_view.dart';
import '../widgets/craft_category_chip.dart';
import '../widgets/master_artisan_spotlight_card.dart';
import '../widgets/product_card.dart';
import '../widgets/discovery_cart_action.dart';
import '../widgets/provenance_guarantee_card.dart';
import 'product_details_screen.dart';
import 'public_artisan_profile_screen.dart';
import 'search_screen.dart';
import 'favorites_screen.dart';

/// Assigned to: JAYAWARDANA V. K. A.
/// Branch: feature/buyer-discovery
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<DiscoveryProvider>().listenToFeaturedProducts();
    });
  }

  void _openFilterBottomSheet() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const SearchScreen(openFilters: true),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background.withOpacity(0.95),
        elevation: 0,
        scrolledUnderElevation: 1,
        titleSpacing: 16,
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.account_balance_outlined,
                size: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Hasthakala',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    height: 1.1,
                  ),
                ),
                Text(
                  'HOME / DISCOVERY',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search,
                color: AppColors.textPrimary, size: 22),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              );
            },
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.favorite_border,
                    color: AppColors.textPrimary, size: 22),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const FavoritesScreen())),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const DiscoveryCartAction(),
          const SizedBox(width: 4),
          const CircleAvatar(
            radius: 15,
            backgroundColor: AppColors.primary,
            child: Icon(Icons.person, size: 18, color: Colors.white),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Consumer<DiscoveryProvider>(
        builder: (context, provider, _) {
          final displayProducts = provider.featuredProducts;

          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async {
              await provider.listenToFeaturedProducts();
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              children: [
                // Search Input with Filter Trigger
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SearchScreen()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 11),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                                color: Colors.black.withOpacity(0.05)),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xFF1C1917).withOpacity(0.05),
                                blurRadius: 12,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.search,
                                  size: 20, color: AppColors.primary),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Search pottery, masks, cane, brass...',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: _openFilterBottomSheet,
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEE7E3),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.tune,
                          size: 20,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Horizontal Category Scroll Chips
                SizedBox(
                  height: 38,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: CraftCategories.all.length + 1,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final category =
                          index == 0 ? null : CraftCategories.all[index - 1];
                      return CraftCategoryChip(
                        label: category?.label ?? 'All Crafts',
                        isSelected: index == 0,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SearchScreen(
                                    initialCategory: category?.key),
                              ));
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // Master Artisan Spotlight Card
                if (displayProducts.isNotEmpty)
                  MasterArtisanSpotlightCard(
                    product: displayProducts.first,
                    onViewWorkshop: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PublicArtisanProfileScreen(
                            artisanId: displayProducts.first.artisanId,
                          ),
                        ),
                      );
                    },
                    onFeaturedProductTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailsScreen(
                            product: displayProducts.first,
                          ),
                        ),
                      );
                    },
                  ),
                const SizedBox(height: 24),

                // Section Header: Curated Masterpieces
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.auto_awesome,
                                size: 14, color: AppColors.secondary),
                            SizedBox(width: 4),
                            Text(
                              'RARE & HANDCRAFTED',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: AppColors.secondary,
                                letterSpacing: 0.6,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Curated Masterpieces',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SearchScreen()),
                        );
                      },
                      child: Row(
                        children: const [
                          Text(
                            'Explore all',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondary,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            size: 18,
                            color: AppColors.secondary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Product Grid / Loading State
                if (provider.isLoading)
                  const Padding(
                    padding: EdgeInsets.all(40.0),
                    child: LoadingIndicator(
                        message: 'Loading authentic crafts...'),
                  )
                else if (provider.errorMessage != null)
                  EmptyStateView(
                      icon: Icons.cloud_off,
                      title: 'Unable to load crafts',
                      description: 'Check your connection and try again.',
                      actionButtonText: 'Retry',
                      onActionPressed: provider.listenToFeaturedProducts)
                else if (displayProducts.isEmpty)
                  const EmptyStateView(
                      icon: Icons.storefront,
                      title: 'No crafts yet',
                      description: 'New artisan creations will appear here.')
                else
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.70,
                    ),
                    itemCount: displayProducts.length,
                    itemBuilder: (context, index) {
                      final product = displayProducts[index];
                      return ProductCard(
                        product: product,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ProductDetailsScreen(product: product),
                            ),
                          );
                        },
                      );
                    },
                  ),
                const SizedBox(height: 24),

                // Provenance Guarantee Trust Panel
                const ProvenanceGuaranteeCard(),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
