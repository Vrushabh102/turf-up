// // lib/main.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:turf_together/screens/events/event_details_screen.dart';
// import 'package:turf_together/screens/main_scaffold.dart';
// import 'package:turf_together/screens/onboarding/sign_up_screen.dart';
// import 'theme/app_theme.dart';
// import 'screens/onboarding/welcome_screen.dart';
// import 'screens/onboarding/login_screen.dart';
// import 'screens/games/game_detail_screen.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const TurfConnectApp());
// }

// class TurfConnectApp extends StatelessWidget {
//   const TurfConnectApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(390, 844), // Android recommended baseline (Pixel 6)
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: (context, child) {
//         final baseTheme = ThemeData(
//           useMaterial3: true,
//           colorScheme: AppTheme.colorScheme,
//           textTheme: GoogleFonts.interTextTheme(),
//           scaffoldBackgroundColor: Colors.white,
//           appBarTheme: AppBarTheme(
//             elevation: 0,
//             scrolledUnderElevation: 0,
//             backgroundColor: Colors.white,
//             foregroundColor: AppTheme.textPrimary,
//             centerTitle: true,
//             titleTextStyle: GoogleFonts.inter(
//               fontSize: 18.sp,
//               fontWeight: FontWeight.w600,
//               color: AppTheme.textPrimary,
//             ),
//           ),
//           inputDecorationTheme: AppTheme.inputDecorationTheme,
//         );
//         return MaterialApp(
//           title: 'TurfConnect',
//           debugShowCheckedModeBanner: false,
//           theme: baseTheme,
//           routes: {
//             '/': (_) => const WelcomeScreen(),
//             '/login': (_) => const LoginScreen(),
//             '/signup': (_) => const SignUpScreen(),
//             '/main': (_) => const MainScaffold(),
//           },
//           onGenerateRoute: (settings) {
//             if (settings.name == EventDetailScreen.routeName) {
//               final args = settings.arguments as Map<String, dynamic>;
//               return MaterialPageRoute(
//                 builder: (_) => EventDetailScreen(event: args['event']),
//               );
//             }
//             if (settings.name == GameDetailScreen.routeName) {
//               final args = settings.arguments as Map<String, dynamic>;
//               return MaterialPageRoute(
//                 builder: (_) => GameDetailScreen(game: args['game']),
//               );
//             }
//             return null;
//           },
//         );
//       },
//     );
//   }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:turf_together/constants/supabase_api_key.dart';
import 'package:turf_together/feature/auth/screens/sign_in_screen.dart';
import 'package:turf_together/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
    url: SupabaseApiKey.projectUrl,
    anonKey: SupabaseApiKey.anonKey,
  );
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // Android recommended size (360x800 dp)
      designSize: Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return ProviderScope(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SignUpFlow(),
          ),
        );
      },
    );
  }
}
