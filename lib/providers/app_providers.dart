// lib/providers/app_providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/product.dart';
import '../services/api_service.dart';

//  API Service Provider
final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

//  Products Provider
final productsProvider = FutureProvider<List<Product>>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  return apiService.fetchProducts();
});

//  Search Query Provider
final searchQueryProvider = StateProvider<String>((ref) => '');

//  Filtered Products Provider
final filteredProductsProvider = Provider<List<Product>>((ref) {
  final productsAsync = ref.watch(productsProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase();

  return productsAsync.when(
    data: (products) {
      if (query.isEmpty) return products;
      return products.where((p) => p.title.toLowerCase().contains(query)).toList();
    },
    loading: () => [],
    error: (_, __) => [],
  );
});

//Cart Provider
class CartNotifier extends StateNotifier<Map<int, int>> {
  CartNotifier() : super({});

  void addToCart(int productId) {
    state = {
      ...state,
      productId: (state[productId] ?? 0) + 1,
    };
  }

  void removeFromCart(int productId) {
    final newState = Map<int, int>.from(state);
    newState.remove(productId);
    state = newState;
  }

  void decreaseQuantity(int productId) {
    if (!state.containsKey(productId)) return;

    if (state[productId]! > 1) {
      state = {
        ...state,
        productId: state[productId]! - 1,
      };
    } else {
      removeFromCart(productId);
    }
  }

  int getQuantity(int productId) => state[productId] ?? 0;

  int get totalItems => state.values.fold(0, (sum, qty) => sum + qty);
}

final cartProvider = StateNotifierProvider<CartNotifier, Map<int, int>>((ref) {
  return CartNotifier();
});

//Wishlist Provider
class WishlistNotifier extends StateNotifier<Set<int>> {
  WishlistNotifier() : super({});

  void toggleWishlist(int productId) {
    if (state.contains(productId)) {
      state = Set.from(state)..remove(productId);
    } else {
      state = Set.from(state)..add(productId);
    }
  }

  bool isInWishlist(int productId) => state.contains(productId);
}

final wishlistProvider = StateNotifierProvider<WishlistNotifier, Set<int>>((ref) {
  return WishlistNotifier();
});