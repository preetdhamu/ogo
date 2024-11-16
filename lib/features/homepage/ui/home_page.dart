import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:ogo/core/constants/colors.dart';
import 'package:ogo/core/services/local_storage_service.dart';

import 'package:ogo/features/authentication/providers/auth_service_provider.dart';
import 'package:ogo/features/homepage/provider/home_page_provider.dart';
import 'package:ogo/features/homepage/widgets/like_movie_list.dart';
import 'package:ogo/features/homepage/widgets/main_content.dart';

import 'package:ogo/routes/app_routes.dart';
import 'package:ogo/shared/widgets/custom_button.dart';
import 'package:ogo/shared/widgets/custom_header.dart';
import 'package:ogo/shared/widgets/custom_icon_button.dart';
import 'package:ogo/shared/widgets/custom_log.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    HomePageProvider homePageProvider =
        Provider.of<HomePageProvider>(context, listen: false);
    
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await homePageProvider.initState(context);   
      },
    );

   
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {},
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(9, 14, 23, 1),
        body: Consumer2<AuthServiceProvider, HomePageProvider>(
            builder: (context, provider, provider1, _) {
          return provider.load || provider1.load
              ? const CircularProgressIndicator()
              : provider.showHomePageContent == true
                  ? provider1.selectGenre == true
                      ? const LikeMovies()
                      : const MainContent()
                  : Center(
                      child: OiconButtons(
                          child: Icon(Icons.logout),
                          onTap: () async {
                            await provider.authService.signOut();
                            Navigator.pushNamed(context, AppRoutes.splash);
                          }),
                    );
        }),
      ),
    );
  }
}
