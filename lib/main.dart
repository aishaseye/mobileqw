import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:qualywatchmobile/l10n/app_localizations.dart';

import 'core/constants/app_theme.dart';
import 'core/constants/app_constants.dart';
import 'core/routing/app_router.dart';
import 'core/routing/navigation_service.dart';
import 'presentation/providers/language_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Configure system UI
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const QualyWatchApp());
}

class QualyWatchApp extends StatelessWidget {
  const QualyWatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        // Add other providers here as needed
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return MaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,

            // Navigation key for NavigationService
            navigatorKey: NavigationService.navigatorKey,

            // Localization configuration
            locale: languageProvider.currentLocale,
            supportedLocales: languageProvider.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            // Theme configuration
            theme: AppTheme.lightTheme,

            // Routing configuration
            initialRoute: AppRouter.splash,
            onGenerateRoute: AppRouter.generateRoute,

            // Builder for additional configurations
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: const TextScaler.linear(1.0), // Prevent text scaling
                ),
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}