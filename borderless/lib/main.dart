import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
