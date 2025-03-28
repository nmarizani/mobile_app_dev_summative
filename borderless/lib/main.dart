import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/cart/cart_bloc.dart';
import 'blocs/products/products_bloc.dart';
import 'screens/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/sign_up_screen.dart';
import 'screens/auth/email_verification_screen.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/auth/forgot_password_verification_screen.dart';
import 'screens/auth/new_password_screen.dart';
import 'screens/auth/password_success_screen.dart';
import 'screens/shipping_address_screen.dart';
import 'screens/payment_method_screen.dart';

void main() {
  runApp(const MyApp());
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
      ],
      child: MaterialApp(
        title: 'Borderless',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.black,
            primary: Colors.black,
          ),
          textTheme: GoogleFonts.interTextTheme(),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignUpScreen(),
          '/home': (context) => const HomeScreen(),
          '/email-verification': (context) => const EmailVerificationScreen(),
          '/forgot-password': (context) => const ForgotPasswordScreen(),
          '/forgot-password-verification': (context) =>
              const ForgotPasswordVerificationScreen(),
          '/new-password': (context) => const NewPasswordScreen(),
          '/password-success': (context) => const PasswordSuccessScreen(),
          '/shipping-address': (context) => const ShippingAddressScreen(),
          '/payment-method': (context) => const PaymentMethodScreen(),
        },
      ),
    );
  }
}
