import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ogo/core/theme/app_theme.dart';
import 'package:ogo/providers/manage_all_providers.dart';
import 'package:ogo/routes/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: allproviders, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "OGO",
      themeMode: ThemeMode.system,
      theme: OAppTheme.lightTheme, // For light Theme
      // darkTheme: OAppTheme.darkTheme ,  // for dark theme
      initialRoute: AppRoutes.register,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.generateRoute,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale('en'),
      supportedLocales: [
        Locale('en'),
        Locale('hi'),
      ],
    );
  }
}
