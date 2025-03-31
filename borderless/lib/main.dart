import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/cart/cart_bloc.dart';
import 'blocs/products/products_bloc.dart';
import 'blocs/product_listing/product_listing_bloc.dart';
import 'blocs/wishlist/wishlist_bloc.dart';
import 'blocs/theme/theme.dart';
import 'blocs/checkout/checkout_bloc.dart';
import 'screens/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/sign_up_screen.dart';
import 'screens/home_screen.dart';
import 'screens/auth/email_verification_screen.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/auth/forgot_password_verification_screen.dart';
import 'screens/auth/new_password_screen.dart';
import 'screens/auth/password_success_screen.dart';
import 'screens/profile/profile_shipping_screen.dart';
import 'screens/profile/profile_payment_screen.dart';
import 'screens/checkout/shipping_screen.dart';
import 'screens/checkout/payment_screen.dart';
import 'screens/checkout/review_screen.dart';
import 'screens/order_tracking_screen.dart';
import 'screens/order_success_screen.dart';
import 'blocs/shipping/shipping_bloc.dart';
import 'screens/categories_screen.dart';
import 'screens/search_screen.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => CartBloc()),
        BlocProvider(create: (context) => ProductsBloc()),
        BlocProvider(create: (context) => ProductListingBloc()),
        BlocProvider(create: (context) => WishlistBloc()),
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => ShippingBloc()),
        BlocProvider(create: (context) => CheckoutBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Borderless',
            debugShowCheckedModeBanner: false,
            theme: context.read<ThemeBloc>().themeData,
            initialRoute: '/',
            routes: {
              '/': (context) => const SplashScreen(),
              '/login': (context) => const LoginScreen(),
              '/signup': (context) => const SignUpScreen(),
              '/home': (context) => const HomeScreen(),
              '/email-verification': (context) => const EmailVerificationScreen(),
              '/forgot-password': (context) => const ForgotPasswordScreen(),
              '/forgot-password-verification': (context) => const ForgotPasswordVerificationScreen(),
              '/new-password': (context) => const NewPasswordScreen(),
              '/password-success': (context) => const PasswordSuccessScreen(),
              '/shipping-address': (context) => const ProfileShippingScreen(),
              '/payment-method': (context) => const ProfilePaymentScreen(),
              '/checkout-shipping': (context) => const CheckoutShippingScreen(),
              '/checkout-payment': (context) => const CheckoutPaymentScreen(),
              '/checkout-review': (context) => const CheckoutReviewScreen(),
              '/categories': (context) => const CategoriesScreen(),
              '/search': (context) => const SearchScreen(),
              '/order-success': (context) {
                final orderId = ModalRoute.of(context)!.settings.arguments as String;
                return OrderSuccessScreen(orderId: orderId);
              },
              '/order-tracking': (context) {
                final orderId = ModalRoute.of(context)!.settings.arguments as String;
                return OrderTrackingScreen(orderId: orderId);
                debugPaintSizeEnabled = true;
              },
            },
          );
        },
      ),
    );
  }
}