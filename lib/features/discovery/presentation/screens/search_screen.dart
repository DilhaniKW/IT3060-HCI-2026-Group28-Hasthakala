import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/shared_models/product_model.dart';
import '../../../../core/widgets/empty_state_view.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../state/search_filter_provider.dart';
import '../widgets/craft_category_chip.dart';
import '../widgets/product_card.dart';
import '../widgets/search_filter_bottom_sheet.dart';
import 'product_details_screen.dart';

/// Assigned to: JAYAWARDANA V. K. A.
/// Branch: feature/buyer-discovery
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedCategoryIndex = 0;

  final List<String> _categories = [
    'All Crafts',
    'Pottery',
    'Woodcarving',
    'Batik',
    'Brassware',
    'Masks',
  ];

  final List<ProductModel> _exploreSampleProducts = [
    ProductModel(
      id: 'sample_1',
      artisanId: 'artisan_sunil',
      artisanName: 'Sunil K.',
      title: 'Heritage Jug',
      description: 'Organic raw unglazed terracotta water jug.',
      priceLkr: 2400.0,
      category: 'Pottery',
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
      description: 'Intricately hand-carved traditional Sri Lankan Gurulu Raksha demon mask.',
      priceLkr: 3200.0,
      category: 'Masks',
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
      description: 'Finely polished natural coconut shell dessert bowl.',
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
      description: 'Traditional Sri Lankan Dumbara handwoven reed table mat.',
      priceLkr: 1800.0,
      category: 'Batik',
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
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchFilterProvider(),
      child: Consumer<SearchFilterProvider>(
        builder: (context, provider, _) {
          final results = provider.searchResults.isNotEmpty
              ? provider.searchResults
              : _exploreSampleProducts;

          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: AppColors.background,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                onPressed: () => Navigator.pop(context),
              ),
              title: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.black.withOpacity(0.05)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1C1917).withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) {
                    provider.performSearch(query: val);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search pottery, masks, cane, brass...',
                    hintStyle: const TextStyle(fontSize: 13, color: AppColors.textMuted),
                    prefixIcon: const Icon(Icons.search, size: 20, color: AppColors.primary),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 18, color: AppColors.textMuted),
                            onPressed: () {
                              _searchController.clear();
                              provider.performSearch(query: '');
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => SearchFilterBottomSheet(provider: provider),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 16),
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEEE7E3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.tune, size: 18, color: AppColors.primary),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Categories Bar
                  SizedBox(
                    height: 36,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final catName = _categories[index];
                        return CraftCategoryChip(
                          label: catName,
                          isSelected: _selectedCategoryIndex == index,
                          onTap: () {
                            setState(() => _selectedCategoryIndex = index);
                            if (catName == 'All Crafts') {
                              provider.setCategory(null);
                            } else {
                              provider.setCategory(catName);
                            }
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Results Heading Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Curated Crafts (${results.length})',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      if (provider.selectedCategory != null ||
                          provider.selectedDistrict != null)
                        TextButton(
                          onPressed: () => provider.clearFilters(),
                          child: const Text(
                            'Clear Filters',
                            style: TextStyle(fontSize: 12, color: AppColors.primary),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Results Grid / State
                  Expanded(
                    child: provider.isSearching
                        ? const LoadingIndicator(message: 'Searching authentic crafts...')
                        : results.isEmpty
                            ? const EmptyStateView(
                                icon: Icons.search_off,
                                title: 'No crafts found',
                                description: 'Try adjusting your search query or filters.',
                              )
                            : GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  childAspectRatio: 0.70,
                                ),
                                itemCount: results.length,
                                itemBuilder: (context, index) {
                                  final product = results[index];
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
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
