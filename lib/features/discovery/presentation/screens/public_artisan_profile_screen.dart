import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/craft_categories.dart';
import '../../../../core/shared_models/product_model.dart';
import '../../../../core/shared_models/artisan_profile_model.dart';
import '../../../../core/widgets/empty_state_view.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../data/datasources/discovery_remote_datasource.dart';
import '../../data/discovery_filters.dart';
import '../widgets/product_card.dart';
import '../widgets/discovery_cart_action.dart';
import 'product_details_screen.dart';

class PublicArtisanProfileScreen extends StatefulWidget {
  const PublicArtisanProfileScreen(
      {super.key,
      required this.artisanId,
      this.loadProfile,
      this.loadProducts});
  final String artisanId;
  final Future<ArtisanProfileModel?> Function(String)? loadProfile;
  final Future<List<ProductModel>> Function(String)? loadProducts;
  @override
  State<PublicArtisanProfileScreen> createState() =>
      _PublicArtisanProfileScreenState();
}

class _PublicArtisanProfileScreenState
    extends State<PublicArtisanProfileScreen> {
  ArtisanProfileModel? _artisan;
  List<ProductModel> _products = [];
  bool _loading = true;
  String? _error;
  int _request = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(covariant PublicArtisanProfileScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.artisanId != widget.artisanId) _load();
  }

  Future<void> _load() async {
    final request = ++_request;
    final artisanId = widget.artisanId;
    setState(() {
      _loading = true;
      _error = null;
      _artisan = null;
      _products = [];
    });
    try {
      final source = widget.loadProfile == null || widget.loadProducts == null
          ? DiscoveryRemoteDataSource()
          : null;
      final artisan =
          await (widget.loadProfile ?? source!.getArtisanProfile)(artisanId);
      final products = artisan == null
          ? <ProductModel>[]
          : await (widget.loadProducts ??
              source!.getArtisanProducts)(artisanId);
      if (!mounted || request != _request) return;
      setState(() {
        _artisan = artisan;
        _products = products
            .where((p) => p.artisanId == artisanId && p.isAvailable)
            .toList();
      });
    } catch (_) {
      if (!mounted || request != _request) return;
      setState(() => _error = 'Check your connection and try again.');
    } finally {
      if (mounted && request == _request) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final artisan = _artisan;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
          title: const Text('Artisan Studio'),
          actions: const [DiscoveryCartAction()]),
      body: _loading
          ? const LoadingIndicator(message: 'Loading artisan studio...')
          : _error != null
              ? EmptyStateView(
                  icon: Icons.cloud_off,
                  title: 'Unable to load artisan',
                  description: _error!,
                  actionButtonText: 'Retry',
                  onActionPressed: _load)
              : artisan == null
                  ? const EmptyStateView(
                      icon: Icons.person_off_outlined,
                      title: 'Artisan not found',
                      description: 'This public studio is not available.')
                  : RefreshIndicator(
                      onRefresh: _load,
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(color: AppColors.border)),
                            child: Column(children: [
                              ClipOval(
                                  child: artisan.photoUrl?.isNotEmpty == true
                                      ? Image.network(artisan.photoUrl!,
                                          width: 88,
                                          height: 88,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) =>
                                              const Icon(Icons.person,
                                                  size: 88))
                                      : const Icon(Icons.storefront,
                                          size: 88, color: AppColors.primary)),
                              const SizedBox(height: 12),
                              Text(
                                  artisan.displayName.isEmpty
                                      ? 'Artisan studio'
                                      : artisan.displayName,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                              if (artisan.craftType.trim().isNotEmpty)
                                Text(
                                    CraftCategories.labelFor(
                                        discoveryCategoryKey(
                                            artisan.craftType)!),
                                    style: const TextStyle(
                                        color: AppColors.primary)),
                              if (artisan.location.isNotEmpty)
                                Text(artisan.location),
                              if (artisan.verified)
                                const Chip(
                                    avatar: Icon(Icons.verified,
                                        color: AppColors.accent),
                                    label: Text('Verified artisan')),
                            ]),
                          ),
                          const SizedBox(height: 24),
                          const Text('Artisan Journey & Heritage',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(
                              artisan.about.isEmpty
                                  ? 'This artisan has not added a story yet.'
                                  : artisan.about,
                              style: const TextStyle(
                                  height: 1.5, color: AppColors.textSecondary)),
                          const SizedBox(height: 24),
                          Text('Workshop Masterpieces (${_products.length})',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),
                          if (_products.isEmpty)
                            const EmptyStateView(
                                icon: Icons.storefront,
                                title: 'No crafts listed yet',
                                description:
                                    'Check back for new creations from this artisan.')
                          else
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 12,
                                      childAspectRatio: .70),
                              itemCount: _products.length,
                              itemBuilder: (_, index) => ProductCard(
                                  key: ValueKey(_products[index].id),
                                  product: _products[index],
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ProductDetailsScreen(
                                              product: _products[index])))),
                            ),
                        ],
                      )),
    );
  }
}
