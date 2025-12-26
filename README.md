# 🛍️ Mini E-Commerce App

A premium, responsive Flutter application developed as a machine task demonstration. This project showcases modern Android/iOS development practices, utilizing **Riverpod** for robust state management and a clean **MVVM-style architecture**.

---

## 📱 Features

* **Product Discovery:** Fetch and display products from [FakeStore API](https://fakestoreapi.com/) with loading and error states.
* **Smart Search:** Real-time filtering of products by name.
* **Product Details:** Rich detail view with high-quality cached images, ratings, and descriptions.
* **Shopping Cart:** Persistent cart functionality (Add, Remove, Adjust Quantity) with live total calculation.
* **Wishlist:** Ability to favorite items for later viewing.
* **Responsive Design:** Adaptive grid layouts that switch between 2-column (Mobile) and 4-column (Tablet/Landscape) modes.

---

## 🛠️ Tech Stack & Architecture

This project is built with scalability and maintainability in mind, following "Senior Developer" standards.

* **Framework:** Flutter (Dart)
* **State Management:** [Flutter Riverpod](https://riverpod.dev/) (Using `StateNotifier` & `Provider`)
* **Networking:** `http` package with a dedicated Service layer.
* **Image Caching:** `cached_network_image` for performance optimization.
* **Typography:** `google_fonts` (Poppins) for a modern aesthetic.
* **Architecture:** Feature-based folder structure separation (Models, Providers, Services, Screens).

### 📂 Folder Structure
```text
lib/
├── models/         # Data classes (Product, Rating)
├── providers/      # Riverpod state managers (Cart, Wishlist, API)
├── screens/        # UI Pages (Product List, Details, Cart)
├── services/       # API networking logic
├── widgets/        # Reusable UI components (ProductCard)
└── main.dart       # App entry point and Theme config