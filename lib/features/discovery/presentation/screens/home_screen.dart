import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/shared_models/product_model.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../state/discovery_provider.dart';
import '../state/search_filter_provider.dart';
import '../widgets/craft_category_chip.dart';
import '../widgets/master_artisan_spotlight_card.dart';
import '../widgets/product_card.dart';
import '../widgets/provenance_guarantee_card.dart';
import '../widgets/search_filter_bottom_sheet.dart';
import 'product_details_screen.dart';
import 'public_artisan_profile_screen.dart';
import 'search_screen.dart';

/// Assigned to: JAYAWARDANA V. K. A.
/// Branch: feature/buyer-discovery
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;

  final List<Map<String, dynamic>> _categories = [
    {'label': 'All Crafts', 'icon': Icons.grid_view},
    {'label': 'Pottery & Clay', 'icon': Icons.local_florist},
    {'label': 'Woodcarving', 'icon': Icons.carpenter},
    {'label': 'Batik & Weave', 'icon': Icons.texture},
    {'label': 'Brass Casting', 'icon': Icons.hardware},
  ];

  // High-fidelity fallback sample products matching Stitch Canvas
  final List<ProductModel> _sampleProducts = [
    ProductModel(
      id: 'sample_1',
      artisanId: 'artisan_sunil',
      artisanName: 'Sunil K.',
      title: 'Heritage Jug',
      description:
          'Organic raw unglazed terracotta water jug, handmade with rustic ridged grooves and earthen textures in Kelaniya pottery studio.',
      priceLkr: 2400.0,
      category: 'Pottery & Clay',
      materials: 'Terracotta Clay',
      district: 'Kelaniya',
      rating: 4.9,
      reviewCount: 24,
      imageUrls: [
        'https://images.unsplash.com/photo-1578749556568-bc2c40e68b61?auto=format&fit=crop&q=80&w=600',
      ],
    ),
    ProductModel(
      id: 'sample_2',
      artisanId: 'artisan_kamal',
      artisanName: 'Kamal P.',
      title: 'Raksha Mask',
      description:
          'Intricately hand-carved traditional Sri Lankan Gurulu Raksha demon mask with vivid natural mineral pigments.',
      priceLkr: 3200.0,
      category: 'Traditional Masks',
      materials: 'Kaduru Wood',
      district: 'Ambalangoda',
      rating: 4.8,
      reviewCount: 19,
      imageUrls: [
        'https://images.unsplash.com/photo-1584727638096-042c45049ebe?auto=format&fit=crop&q=80&w=600',
      ],
    ),
    ProductModel(
      id: 'sample_3',
      artisanId: 'artisan_nimali',
      artisanName: 'Nimali F.',
      title: 'Coconut Bowl',
      description:
          'Finely polished natural coconut shell dessert bowl treated with pure wild kitul oil for smooth tactile finish.',
      priceLkr: 1200.0,
      category: 'Woodcarving',
      materials: 'Coconut Shell & Kitul Oil',
      district: 'Kurunegala',
      rating: 4.7,
      reviewCount: 15,
      imageUrls: [
        'https://images.unsplash.com/photo-1610701596007-11502861dcfa?auto=format&fit=crop&q=80&w=600',
      ],
    ),
    ProductModel(
      id: 'sample_4',
      artisanId: 'artisan_nalini',
      artisanName: 'Nalini A.',
      title: 'Dumbara Mat',
      description:
          'Traditional Sri Lankan Dumbara handwoven reed table mat with intricate geometric patterns crafted on pit-loom.',
      priceLkr: 1800.0,
      category: 'Batik & Weave',
      materials: 'Nidi Grass & Dye',
      district: 'Kandy',
      rating: 5.0,
      reviewCount: 31,
      imageUrls: [
        'https://images.unsplash.com/photo-1606744824163-985d376605aa?auto=format&fit=crop&q=80&w=600',
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DiscoveryProvider>().listenToFeaturedProducts();
    });
  }

  void _openFilterBottomSheet() {
    final searchFilterProvider = Provider.of<SearchFilterProvider>(context, listen: false);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SearchFilterBottomSheet(provider: searchFilterProvider),
    );
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
            icon: const Icon(Icons.search, color: AppColors.textPrimary, size: 22),
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
                icon: const Icon(Icons.favorite_border, color: AppColors.textPrimary, size: 22),
                onPressed: () {},
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
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined, color: AppColors.textPrimary, size: 22),
                onPressed: () {},
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '2',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
          final displayProducts = provider.featuredProducts.isNotEmpty
              ? provider.featuredProducts
              : _sampleProducts;

          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async {
              provider.listenToFeaturedProducts();
            },
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              children: [
                // Search Input with Filter Trigger
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const SearchScreen()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: Colors.black.withOpacity(0.05)),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF1C1917).withOpacity(0.05),
                                blurRadius: 12,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.search, size: 20, color: AppColors.primary),
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
                    itemCount: _categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final item = _categories[index];
                      return CraftCategoryChip(
                        label: item['label'],
                        icon: item['icon'],
                        isSelected: _selectedCategoryIndex == index,
                        onTap: () {
                          setState(() {
                            _selectedCategoryIndex = index;
                          });
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // Master Artisan Spotlight Card
                MasterArtisanSpotlightCard(
                  onViewWorkshop: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PublicArtisanProfileScreen(
                          artisanId: 'artisan_sunil',
                        ),
                      ),
                    );
                  },
                  onFeaturedProductTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailsScreen(
                          product: _sampleProducts.first,
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
                            Icon(Icons.auto_awesome, size: 14, color: AppColors.secondary),
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
                          MaterialPageRoute(builder: (_) => const SearchScreen()),
                        );
                      },
                      child: Row(
                        children: const [
                          Text(
                            'Explore 84+',
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
                    child: LoadingIndicator(message: 'Loading authentic crafts...'),
                  )
                else
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                              builder: (_) => ProductDetailsScreen(product: product),
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
