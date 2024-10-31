
import 'package:ogo/features/authentication/providers/auth_service_provider.dart';
import 'package:ogo/features/splash/providers/splash_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> allproviders = [
  ChangeNotifierProvider(create: (_) => SplashProvider()),
  ChangeNotifierProvider(create: (_) => AuthServiceProvider()),
  // ChangeNotifierProvider(create: (_) => UserProvider()),
];
