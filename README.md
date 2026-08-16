# Shopora — Production-Level Flutter E-Commerce Application

[![Flutter](https://img.shields.io/badge/Flutter-3.0%2B-blue.svg)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Integrated-orange.svg)](https://firebase.google.com)
[![Riverpod](https://img.shields.io/badge/State-Riverpod-purple.svg)](https://riverpod.dev)
[![Clean Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture-green.svg)](https://clean-code-developer.com/)

**Shopora** is a complete, modern, production-level E-Commerce mobile application built using **Flutter and Firebase**. Designed with a premium **Electric Violet (`#6C4DF6`) + Coral Pink (`#FF6B8A`)** brand identity, it delivers a real-world shopping experience tailored for professional Flutter developer portfolios, GitHub showcases, CVs, and technical job interviews.

---

## 📱 Screenshots & Visual Design

- **Electric Violet (`#6C4DF6`)** primary brand elements and active navigation states.
- **Deep Violet (`#4B2DB3`)** gradients and headers.
- **Coral Pink (`#FF6B8A`)** accents for wishlist items, badges, and promotional highlights.
- **Soft Lavender White (`#F8F7FC`)** background with clean, rounded cards (16–24px border radius).

---

## ✨ Key Features

### 🛍️ Shopping Experience
* **Home Dashboard**: Promotional banners, categories, featured products carousel, best sellers grid, flash sales with countdown timer, and new arrivals.
* **Category Browsing**: Dedicated category browsing with product grids.
* **Real-time Search & Filters**: Search products by name, brand, or category with recent searches and suggestions.
* **Product Details**: Image carousel, thumbnail gallery, ratings & reviews, size/color variant selection, and stock status.
* **Cart & Wishlist**: Persistent shopping cart with quantity management, subtotal/discount/delivery calculations, and wishlist management.
* **Multi-Step Checkout**: Delivery address selection, shipping method, payment selection (Cash on Delivery, Credit/Debit Card, Digital Wallet), and order confirmation.
* **Order Tracking & History**: Vertical timeline tracking (Order Placed ➔ Confirmed ➔ Processing ➔ Shipped ➔ Delivered) and orders history by status tabs.
* **Reviews & Ratings**: Customer reviews, rating distribution, and star ratings.

### 👤 User & Admin
* **Authentication**: Firebase Authentication (Email/Password login/registration, forgot password, Google Sign-In, persistent auth).
* **User Profile**: Profile management, orders, wishlist, addresses, payment methods, notifications, settings, and dark mode.
* **Admin Panel**: Role-based access control (RBAC), store analytics (revenue, total products, orders, users), product CRUD, category management, order status fulfillment, and user management.
* **Push Notifications**: Firebase Cloud Messaging (FCM) integration and in-app notifications.

---

## 🛠️ Tech Stack

* **Framework**: Flutter (Dart)
* **State Management**: Flutter Riverpod
* **Backend & Database**: Firebase Auth, Cloud Firestore, Firebase Storage, Firebase Cloud Messaging, Firebase Analytics, Firebase Crashlytics
* **Navigation**: GoRouter & Navigator
* **UI Utilities**: Cached Network Image, Shimmer, Intl

---

## 🏛️ Architecture

**Clean Architecture** with feature-based modular structure:

```text
lib/
  core/
    constants/
    theme/
    routes/
    utils/
    errors/
    services/
  features/
    auth/
    home/
    products/
    categories/
    cart/
    wishlist/
    checkout/
    orders/
    reviews/
    profile/
    notifications/
    admin/
  shared/
    widgets/
    models/
  main.dart
```

---

## 🔥 Firebase Setup & Firestore Structure

### Collections
* `users` — User profiles and roles (`user` or `admin`)
* `products` — Product catalog, pricing, variants, and stock
* `categories` — Product categories and icons
* `orders` — Customer orders and fulfillment statuses
* `reviews` — Product reviews and star ratings
* `wishlists` — Saved product bookmarks
* `carts` — User shopping cart items
* `addresses` — Saved delivery addresses
* `notifications` — In-app notification center
* `banners` — Promotional marketing banners

---

## 🔒 Security Rules

Firestore (`firestore.rules`) and Storage (`storage.rules`) rules enforce strict Role-Based Access Control (RBAC):
- Users can only access and modify their own profile, cart, and wishlist.
- Only authorized admins (`role == 'admin'`) can create/update/delete products and categories, and manage order fulfillment.
- Public read access for product catalog and categories.

---

## 🚀 Installation & Running

1. **Clone the repository**:
   ```bash
   git clone https://github.com/RakibAkram5/Shopora.git
   cd Shopora
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the app**:
   ```bash
   flutter run
   ```

---

## 🔑 Demo & Admin Credentials

- **Regular User**: `rakib@shopora.com` / `password123`
- **Admin User**: `admin@shopora.com` / `password123` (Grants access to the Admin Dashboard and Management tools)

---

## 📄 License

This project is created for professional portfolio showcase and educational purposes.
