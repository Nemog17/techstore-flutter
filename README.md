# TechStore Flutter App

This repository contains a simplified Flutter application that demonstrates the basic structure of an online store for computer components. It includes a user catalog, product details, cart management and a minimal admin panel.

## Features

- **GoRouter** based navigation
- **Riverpod** for state management
- Basic authentication distinguishing normal users and admins
- API integration with the [Fake Store API](https://fakestoreapi.com)
- Payment processing using the [Stripe API](https://stripe.com/docs/api)
- Separate screens for catalog, product details, cart, payment and administration

The app is not fully functional but serves as a starting point for further development.

## Configuration

Set the `STRIPE_SECRET_KEY` compile-time variable when building the app to enable Stripe payments:

```bash
flutter run --dart-define=STRIPE_SECRET_KEY=<your_secret_key>
```

