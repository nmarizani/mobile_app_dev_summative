import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
<<<<<<< HEAD
import 'package:firebase_core/firebase_core.dart';
import 'core/theme/app_theme.dart';
import 'core/bloc/bloc_observer.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/bloc/auth/auth_event.dart';
import 'presentation/widgets/auth_guard.dart';
import 'presentation/pages/splash_page.dart';
import 'presentation/pages/onboarding/onboarding_page.dart';
import 'presentation/pages/auth/login_page.dart';
import 'presentation/pages/auth/signup_page.dart';
import 'presentation/pages/auth/forgot_password_page.dart';
import 'presentation/pages/auth/email_verification_page.dart';
import 'presentation/pages/auth/new_password_page.dart';
import 'presentation/pages/auth/password_success_page.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/business/business_dashboard_page.dart';
import 'presentation/pages/business/business_profile_page.dart';
import 'core/services/firebase_service.dart';
=======
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart'; // Added for Firebase initialization
import 'package:provider/provider.dart'; // Added for UserProvider
import 'blocs/auth/auth_bloc.dart';
import 'blocs/auth/auth_state.dart';
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
import 'services/auth_service.dart'; // Added for AuthService
import 'providers/user_provider.dart'; // Added for UserProvider
>>>>>>> f88d4b5c872e1630ba914e173971dd3fd14fc14b

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase

  // Initialize Firebase with configuration options
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "YOUR_API_KEY",
      authDomain: "YOUR_AUTH_DOMAIN",
      projectId: "YOUR_PROJECT_ID",
      storageBucket: "YOUR_STORAGE_BUCKET",
      messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
      appId: "YOUR_APP_ID",
    ),
  );

  await FirebaseService.initialize();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

<<<<<<< HEAD
  runApp(const MyApp());
=======
  // Set system overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  final authService = AuthService(); // Create AuthService instance

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()), // Provide UserProvider
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc(authService: authService)), // Pass AuthService
          BlocProvider(create: (context) => CartBloc()),
          BlocProvider(create: (context) => ProductsBloc()),
          BlocProvider(create: (context) => ProductListingBloc()),
          BlocProvider(create: (context) => WishlistBloc()),
          BlocProvider(create: (context) => ThemeBloc()),
          BlocProvider(create: (context) => ShippingBloc()),
          BlocProvider(create: (context) => CheckoutBloc()),
        ],
        child: const MyApp(),
      ),
    ),
  );
>>>>>>> f88d4b5c872e1630ba914e173971dd3fd14fc14b
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(CheckAuthStatusEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Borderless',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const SplashPage(),
          '/onboarding': (context) => const OnboardingPage(),
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignupPage(),
          '/forgot-password': (context) => const ForgotPasswordPage(),
          '/email-verification': (context) {
            final args =
                ModalRoute.of(context)!.settings.arguments
                    as Map<String, dynamic>;
            return EmailVerificationPage(
              email: args['email'] as String,
              isPasswordReset: args['isPasswordReset'] as bool,
            );
          },
          '/new-password': (context) {
            final email = ModalRoute.of(context)!.settings.arguments as String;
            return NewPasswordPage(email: email);
          },
          '/password-success': (context) => const PasswordSuccessPage(),
          '/home': (context) => const AuthGuard(child: HomePage()),
          '/business-dashboard':
              (context) => const AuthGuard(child: BusinessDashboardPage()),
          '/business-profile':
              (context) => const AuthGuard(child: BusinessProfilePage()),
        },
      ),
=======
    return BlocBuilder<ThemeBloc, ThemeState>(
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
            '/email-verification': (context) {
              final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>?;
              return EmailVerificationScreen(
                isForgotPassword: args?['isForgotPassword'] ?? false,
              );
            },
            '/forgot-password': (context) => const ForgotPasswordScreen(),
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
              final orderId =
              ModalRoute.of(context)!.settings.arguments as String;
              return OrderSuccessScreen(orderId: orderId);
            },
            '/order-tracking': (context) {
              final orderId =
              ModalRoute.of(context)!.settings.arguments as String;
              return OrderTrackingScreen(orderId: orderId);
            },
          },
        );
      },
>>>>>>> f88d4b5c872e1630ba914e173971dd3fd14fc14b
    );
  }
}