// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get home => 'Home';

  @override
  String get cart => 'Cart';

  @override
  String get favorites => 'Favorites';

  @override
  String get notifications => 'Notifications';

  @override
  String get search => 'Search for your favorite drink...';

  @override
  String get addToCart => 'Add to Cart';

  @override
  String get goToCart => 'Go to Cart';

  @override
  String get orderNow => 'Order Now';

  @override
  String get checkout => 'Checkout';

  @override
  String get total => 'Total';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get deliveryFee => 'Delivery Fee';

  @override
  String get orderNotes => 'Order Notes';

  @override
  String get specialInstructions => 'Any special requests? e.g. less sugar...';

  @override
  String get placeOrder => 'Place Order';

  @override
  String get signOut => 'Sign Out';

  @override
  String get limitedOffer => 'LIMITED OFFER';

  @override
  String get noProductsFound => 'No products found';

  @override
  String get filterByCategory => 'Filter by Category';

  @override
  String get applyFilter => 'Apply Filter';

  @override
  String get all => 'All';

  @override
  String get name => 'Name';

  @override
  String get enterName => 'Enter your name';

  @override
  String get phone => 'Phone Number';

  @override
  String get enterPhone => 'Enter your phone number';

  @override
  String get address => 'Delivery Address';

  @override
  String get enterAddress => 'Enter your delivery address';

  @override
  String get minimum => 'Minimum';

  @override
  String get medium => 'Medium';

  @override
  String get single => 'Single';

  @override
  String get doubleSize => 'Double';

  @override
  String get size => 'Size';

  @override
  String get orderSummary => 'Order Summary';

  @override
  String get specialDeal => 'SPECIAL DEAL';

  @override
  String get rating => 'Rating';

  @override
  String get reviews => 'reviews';

  @override
  String get removeFromFavorites => 'Remove from favorites';

  @override
  String get switchToArabic => 'عربي';

  @override
  String get switchToEnglish => 'English';

  @override
  String helloUser(String name) {
    return 'Hello, $name!';
  }

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get retry => 'Retry';

  @override
  String get productNotFound => 'Product not found';

  @override
  String get itemAdded => 'Item added to cart';

  @override
  String get orderPlaced => 'Order placed successfully!';

  @override
  String get requiredField => 'This field is required';

  @override
  String get invalidPhone => 'Please enter a valid phone number';

  @override
  String minCharacters(int count) {
    return 'Minimum $count characters required';
  }

  @override
  String get onboardingTitle => 'Coffee so good, your taste buds will love it.';

  @override
  String get onboardingSubtitle =>
      'The best grain, the finest roast, the powerful flavor.';

  @override
  String get welcome => 'Welcome,';

  @override
  String get user => 'User';

  @override
  String get signOutConfirmation => 'Are you sure you want to sign out?';

  @override
  String get cancel => 'Cancel';

  @override
  String get ok => 'OK';

  @override
  String get orderItems => 'Order Items';
}
