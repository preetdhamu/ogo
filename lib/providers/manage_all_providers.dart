
import 'package:ogo/features/authentication/providers/auth_service_provider.dart';
import 'package:ogo/features/homepage/provider/home_page_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> allproviders = [
  
  ChangeNotifierProvider(create: (_) => AuthServiceProvider()),
  ChangeNotifierProvider(create: (_) => HomePageProvider()),
  // ChangeNotifierProvider(create: (_) => UserProvider()),
];
