import '../discovery_labels.dart';
import '../../../../core/localization/tr.dart';
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
import '../state/artisan_search_provider.dart';
import '../widgets/artisan_search_results.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen(
      {super.key,
      this.initialCategory,
      this.openFilters = false,
      this.search,
      this.loadArtisans});
  final ArtisanLoader? loadArtisans;
  final String? initialCategory;
  final bool openFilters;
  final DiscoverySearch? search;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  late final SearchFilterProvider _provider;
  ArtisanSearchProvider? _artisanProvider;
  bool _showArtisans = false;

  void _changeMode(bool artisans) {
    if (artisans == _showArtisans) return;
    if (artisans) {
      if (_artisanProvider == null) {
        _artisanProvider = ArtisanSearchProvider(load: widget.loadArtisans);
        _artisanProvider!.setCategory(widget.initialCategory);
        _artisanProvider!.refresh();
      }
      _artisanProvider!.setQuery(_controller.text);
    } else {
      _provider.performSearch(query: _controller.text);
    }
    setState(() => _showArtisans = artisans);
  }

  void _queryChanged(String value, {bool submit = false}) {
    if (_showArtisans) {
      _artisanProvider!.setQuery(value);
      setState(() {});
    } else if (submit) {
      _provider.performSearch(query: value);
    } else {
      _provider.updateQuery(value);
    }
  }

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
    _artisanProvider?.dispose();
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
                onChanged: _queryChanged,
                onSubmitted: (value) => _queryChanged(value, submit: true),
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: context.tr(_showArtisans
                      ? 'discovery_artisans_hint'
                      : 'discovery_search'),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _controller.text.isEmpty
                      ? null
                      : IconButton(
                          tooltip: context.tr('discovery_clear_search'),
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _controller.clear();
                            _queryChanged('', submit: true);
                          },
                        ),
                ),
              ),
              actions: [
                IconButton(
                    tooltip: context.tr('discovery_saved_action'),
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const FavoritesScreen()))),
                if (!_showArtisans)
                  IconButton(
                      tooltip: context.tr('discovery_filter_action'),
                      onPressed: _openFilters,
                      icon: const Icon(Icons.tune)),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(56),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: SegmentedButton<bool>(
                    segments: [
                      ButtonSegment(
                          value: false,
                          label: Text(context.tr('discovery_products_tab'))),
                      ButtonSegment(
                          value: true,
                          label: Text(context.tr('discovery_artisans_tab'))),
                    ],
                    selected: {_showArtisans},
                    onSelectionChanged: (selected) =>
                        _changeMode(selected.single),
                  ),
                ),
              ),
            ),
            body: _showArtisans
                ? ArtisanSearchResults(provider: _artisanProvider!)
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: 40,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: CraftCategories.all.length + 1,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(width: 8),
                                itemBuilder: (_, index) {
                                  final category = index == 0
                                      ? null
                                      : CraftCategories.all[index - 1];
                                  return CraftCategoryChip(
                                    label: category == null
                                        ? context.tr('discovery_all_crafts')
                                        : discoveryCategoryLabel(
                                            context, category.key),
                                    isSelected: provider.selectedCategory ==
                                        category?.key,
                                    onTap: () =>
                                        provider.setCategory(category?.key),
                                  );
                                },
                              )),
                          const SizedBox(height: 12),
                          Row(children: [
                            Expanded(
                                child: Text(
                                    provider.isSearching
                                        ? context.tr('discovery_searching')
                                        : context.tr('discovery_results',
                                            {'count': '${results.length}'}),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold))),
                            if (provider.hasFilters)
                              TextButton(
                                  onPressed: provider.clearFilters,
                                  child: Text(
                                      context.tr('discovery_clear_filters'))),
                          ]),
                          if (provider.selectedDistrict != null ||
                              provider.maxPrice != null)
                            Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text([
                                  if (provider.selectedDistrict != null)
                                    discoveryOriginLabel(
                                        context, provider.selectedDistrict!),
                                  if (provider.maxPrice != null)
                                    context.tr('discovery_up_to', {
                                      'price':
                                          provider.maxPrice!.toStringAsFixed(2)
                                    }),
                                ].join(' · '))),
                          Padding(
                            padding: const EdgeInsets.only(top: 12, bottom: 12),
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: context.tr('discovery_sort'),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<DiscoverySort>(
                                  key: const ValueKey('discovery-sort'),
                                  isExpanded: true,
                                  value: provider.sort,
                                  items: [
                                    for (final sort in DiscoverySort.values)
                                      DropdownMenuItem(
                                        value: sort,
                                        child: Text(context
                                            .tr('discovery_sort_${sort.name}')),
                                      ),
                                  ],
                                  onChanged: (sort) {
                                    if (sort != null) provider.setSort(sort);
                                  },
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: provider.isSearching
                                ? LoadingIndicator(
                                    message:
                                        context.tr('discovery_searching_long'))
                                : provider.errorMessage != null
                                    ? EmptyStateView(
                                        icon: Icons.cloud_off,
                                        title:
                                            context.tr('discovery_load_error'),
                                        description:
                                            context.tr('discovery_retry_help'),
                                        actionButtonText:
                                            context.tr('discovery_retry'),
                                        onActionPressed: provider.performSearch)
                                    : results.isEmpty
                                        ? EmptyStateView(
                                            icon: Icons.search_off,
                                            title: context
                                                .tr('discovery_no_results'),
                                            description: context.tr(
                                                'discovery_no_results_help'))
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
                                              itemBuilder: (_, index) =>
                                                  ProductCard(
                                                key:
                                                    ValueKey(results[index].id),
                                                product: results[index],
                                                onTap: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            ProductDetailsScreen(
                                                                product: results[
                                                                    index]))),
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
