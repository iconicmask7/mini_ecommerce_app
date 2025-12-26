// lib/screens/wishlist_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/app_providers.dart';
import '../widgets/product_card.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlistIds = ref.watch(wishlistProvider);
    final productsAsync = ref.watch(productsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Wishlist')),
      body: productsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('Error loading wishlist')),
        data: (products) {
          final wishlistProducts = products
              .where((p) => wishlistIds.contains(p.id))
              .toList();

          if (wishlistProducts.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 60, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No items in wishlist', style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

          // Reusing Grid Layout logic for consistency
          return LayoutBuilder(
            builder: (context, constraints) {
              int gridCount = constraints.maxWidth > 600 ? 4 : 2;

              return GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridCount,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: wishlistProducts.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: wishlistProducts[index]);
                },
              );
            },
          );
        },
      ),
    );
  }
}