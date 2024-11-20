import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:ogo/core/constants/colors.dart';
import 'package:ogo/core/services/local_storage_service.dart';

import 'package:ogo/features/authentication/providers/auth_service_provider.dart';
import 'package:ogo/features/homepage/provider/home_page_provider.dart';
import 'package:ogo/features/homepage/ui/all_movies.dart';
import 'package:ogo/features/homepage/widgets/like_movie_list.dart';
import 'package:ogo/features/homepage/widgets/main_content.dart';

import 'package:ogo/routes/app_routes.dart';
import 'package:ogo/routes/app_routes_home.dart';
import 'package:ogo/shared/widgets/custom_bottom_navigation.dart';
import 'package:ogo/shared/widgets/custom_button.dart';
import 'package:ogo/shared/widgets/custom_glass_morphism.dart';
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
        // backgroundColor: OAppColors.white,
        body: Consumer<HomePageProvider>(builder: (context, provider, _) {
          return selectedScreen(provider.selectedNavigationScreen);
        }),
        // bottomNavigationBar: const OBottomNavigation(),
        bottomNavigationBar: OGlassMorphism(
            width: MediaQuery.of(context).size.width,
            blur: 1,
            color: OAppColors.black,
            opacity: 0.1,
            // margin: const EdgeInsets.symmetric(
            //     horizontal: 12.0, vertical: 12.0),
            borderRadius: BorderRadius.circular(12),
            child: const OBottomNavigation()),
      ),
    );
  }

  Widget selectedScreen(int index) {
    switch (index) {
      case 0:
        return Consumer2<AuthServiceProvider, HomePageProvider>(
            builder: (context, provider, provider1, _) {
          return provider.load || provider1.load
              ? const Center(
                  child: CircularProgressIndicator(
                    color: OAppColors.red,
                  ),
                )
              : provider.showHomePageContent == true
                  ? provider1.selectGenre == true
                      ? const LikeMovies()
                      : const Navigator(
                          onGenerateRoute: OAppRoutesHome.generateRoute,
                        )
                  : Center(
                      child: OiconButtons(
                          child: Icon(Icons.logout),
                          onTap: () async {
                            await provider.authService.signOut();
                            Navigator.pushNamed(context, OAppRoutes.splash);
                          }),
                    );
        });

      case 1:
        return const AllMovies();
      case 2:
        return Container(
          color: OAppColors.gray,
        );

      case 3:
        return Container(
          color: OAppColors.green,
        );
      case 4:
        return Container(
            color: OAppColors.blue,
            child: Center(
              child: OiconButtons(
                  child: const Icon(Icons.logout),
                  onTap: () async {
                    await Provider.of<AuthServiceProvider>(context,
                            listen: false)
                        .authService
                        .signOut();
                    Navigator.pushNamed(context, OAppRoutes.splash);
                  }),
            ));

      default:
        return Center(
          child: OiconButtons(
              child: const Icon(Icons.logout),
              onTap: () async {
                await Provider.of<AuthServiceProvider>(context, listen: false)
                    .authService
                    .signOut();
                Navigator.pushNamed(context, OAppRoutes.splash);
              }),
        );
    }
  }
}
