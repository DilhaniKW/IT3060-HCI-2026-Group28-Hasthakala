import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/craft_categories.dart';
import '../../../../core/widgets/empty_state_view.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../state/search_filter_provider.dart';
import '../widgets/craft_category_chip.dart';
import '../widgets/product_card.dart';
import '../widgets/search_filter_bottom_sheet.dart';
import 'product_details_screen.dart';
import 'favorites_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen(
      {super.key, this.initialCategory, this.openFilters = false, this.search});
  final String? initialCategory;
  final bool openFilters;
  final DiscoverySearch? search;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  late final SearchFilterProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = SearchFilterProvider(search: widget.search);
    _provider.setCategory(widget.initialCategory);
    if (widget.openFilters) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _openFilters();
      });
    }
  }

  void _openFilters() {
    FocusScope.of(context).unfocus();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SearchFilterBottomSheet(provider: _provider),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider.value(
        value: _provider,
        child: Consumer<SearchFilterProvider>(builder: (context, provider, _) {
          final results = provider.searchResults;
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              automaticallyImplyLeading: Navigator.of(context).canPop(),
              title: TextField(
                controller: _controller,
                onChanged: provider.updateQuery,
                onSubmitted: (value) => provider.performSearch(query: value),
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'Search crafts...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _controller.text.isEmpty
                      ? null
                      : IconButton(
                          tooltip: 'Clear search',
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _controller.clear();
                            provider.performSearch(query: '');
                          },
                        ),
                ),
              ),
              actions: [
                IconButton(
                    tooltip: 'Saved crafts',
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const FavoritesScreen()))),
                IconButton(
                    tooltip: 'Filter crafts',
                    onPressed: _openFilters,
                    icon: const Icon(Icons.tune)),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: 40,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: CraftCategories.all.length + 1,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemBuilder: (_, index) {
                            final category = index == 0
                                ? null
                                : CraftCategories.all[index - 1];
                            return CraftCategoryChip(
                              label: category?.label ?? 'All Crafts',
                              isSelected:
                                  provider.selectedCategory == category?.key,
                              onTap: () => provider.setCategory(category?.key),
                            );
                          },
                        )),
                    const SizedBox(height: 12),
                    Row(children: [
                      Expanded(
                          child: Text(
                              provider.isSearching
                                  ? 'Searching crafts...'
                                  : 'Curated Crafts (${results.length})',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))),
                      if (provider.hasFilters)
                        TextButton(
                            onPressed: provider.clearFilters,
                            child: const Text('Clear Filters')),
                    ]),
                    if (provider.selectedDistrict != null ||
                        provider.maxPrice != null)
                      Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text([
                            if (provider.selectedDistrict != null)
                              provider.selectedDistrict!,
                            if (provider.maxPrice != null)
                              'Up to LKR ${provider.maxPrice!.toStringAsFixed(2)}',
                          ].join(' · '))),
                    Expanded(
                      child: provider.isSearching
                          ? const LoadingIndicator(
                              message: 'Searching authentic crafts...')
                          : provider.errorMessage != null
                              ? EmptyStateView(
                                  icon: Icons.cloud_off,
                                  title: 'Unable to load crafts',
                                  description: provider.errorMessage!,
                                  actionButtonText: 'Retry',
                                  onActionPressed: provider.performSearch)
                              : results.isEmpty
                                  ? const EmptyStateView(
                                      icon: Icons.search_off,
                                      title: 'No crafts found',
                                      description:
                                          'Try another search or clear your filters.')
                                  : RefreshIndicator(
                                      onRefresh: provider.performSearch,
                                      child: GridView.builder(
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 12,
                                                mainAxisSpacing: 12,
                                                childAspectRatio: .70),
                                        itemCount: results.length,
                                        itemBuilder: (_, index) => ProductCard(
                                          key: ValueKey(results[index].id),
                                          product: results[index],
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      ProductDetailsScreen(
                                                          product:
                                                              results[index]))),
                                        ),
                                      ),
                                    ),
                    ),
                  ]),
            ),
          );
        }),
      );
}
