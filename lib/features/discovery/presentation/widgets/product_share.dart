import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/shared_models/product_model.dart';
import '../../../../core/utils/currency_formatter.dart';

String productShareText(ProductModel product) => [
      '${product.title} — Hasthakala',
      CurrencyFormatter.formatLKR(product.priceLkr),
      if (product.artisanName.isNotEmpty) 'By ${product.artisanName}',
      if (product.district.isNotEmpty) 'Origin: ${product.district}',
      'Product ID: ${product.id}',
    ].join('\n');

Future<void> showProductShare(
    BuildContext context, ProductModel product) async {
  final text = productShareText(product);
  await showModalBottomSheet<void>(
    context: context,
    useSafeArea: true,
    builder: (sheetContext) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Share this craft',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              SelectableText(text),
              const SizedBox(height: 16),
              const Text('Copy these details to paste into a message.'),
              const SizedBox(height: 12),
              FilledButton.icon(
                  icon: const Icon(Icons.copy),
                  label: const Text('Copy product details'),
                  onPressed: () async {
                    try {
                      await Clipboard.setData(ClipboardData(text: text));
                      if (!sheetContext.mounted) return;
                      Navigator.pop(sheetContext);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Product details copied')));
                      }
                    } catch (_) {
                      if (sheetContext.mounted) {
                        ScaffoldMessenger.of(sheetContext).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Could not copy. Select the text and try again.')));
                      }
                    }
                  }),
            ])),
  );
}
