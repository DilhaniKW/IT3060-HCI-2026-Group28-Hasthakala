import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../state/favorites_provider.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key, required this.productId});
  final String productId;
  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>();
    final selected = favorites.contains(productId);
    return IconButton(
      tooltip: selected ? 'Remove from favorites' : 'Save to favorites',
      isSelected: selected,
      icon: Icon(selected ? Icons.favorite : Icons.favorite_border,
          color: selected ? AppColors.primary : AppColors.textSecondary),
      onPressed: favorites.busy
          ? null
          : () async {
              final saved = await favorites.toggle(productId);
              if (!context.mounted) return;
              if (!saved) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(favorites.error ??
                      'Could not save favorites. Try again.'),
                  action: favorites.error == null
                      ? null
                      : SnackBarAction(
                          label: 'Retry',
                          onPressed: () => favorites
                              .setAccount(favorites.account, reload: true)),
                ));
              }
            },
    );
  }
}
