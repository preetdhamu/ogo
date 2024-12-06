import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ogo/core/services/local_storage_service.dart';
import 'package:ogo/core/theme/app_theme.dart';
import 'package:ogo/providers/manage_all_providers.dart';
import 'package:ogo/routes/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    await OHiveName().openAllBoxes();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]).then((_) async {
      ///// Locking Screen to Portrait Mode Only
      await dotenv.load(fileName: '.env');

      String? apiKey = dotenv.env['API_KEY'];
      String? appId = dotenv.env['APP_ID'];
      String? messagingSenderId = dotenv.env['MESSAGE_SENDER_ID'];
      String? projectId = dotenv.env['PROJECT_ID'];
      String? storageBucket = dotenv.env['STORAGE_BUCKET'];

      if (apiKey != null &&
          appId != null &&
          messagingSenderId != null &&
          projectId != null &&
          storageBucket != null) {
        await Firebase.initializeApp(
          options: FirebaseOptions(
            apiKey: apiKey,
            appId: appId,
            messagingSenderId: messagingSenderId,
            projectId: projectId,
            storageBucket: storageBucket,
          ),
        ).then(
          (value) {
            print("Connected Successfully : ${value.isAutomaticDataCollectionEnabled}");
          },
        );
      } else {
        // ignore: avoid_print
        print("One or more environment variables are missing.");
        return;
      }
      runApp(MultiProvider(providers: allproviders, child: MyApp()));
    });
  } on Exception catch (e, s) {
    print("Error is : $e and $s");
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "OGO",
      navigatorKey: rootNavigatorKey,
      themeMode: ThemeMode.system,
      theme: OAppTheme.lightTheme, // For light Theme
      // darkTheme: OAppTheme.darkTheme ,  // for dark theme
      initialRoute: OAppRoutes.homepage,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: OAppRoutes.generateRoute,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('en'),
      supportedLocales: const [
        Locale('en'),
        Locale('hi'),
      ],
    );
  }
}
