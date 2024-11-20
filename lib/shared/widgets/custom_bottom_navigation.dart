import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ogo/core/constants/colors.dart';
import 'package:ogo/features/authentication/providers/auth_service_provider.dart';
import 'package:ogo/features/homepage/provider/home_page_provider.dart';
import 'package:ogo/shared/widgets/custom_header.dart';
import 'package:provider/provider.dart';

class OBottomNavigation extends StatelessWidget {
  const OBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageProvider>(builder: (context, provider, _) {
      return (Provider.of<AuthServiceProvider>(context, listen: false)
                      .showHomePageContent ==
                  true &&
              provider.selectGenre == false)
          ? NavigationBarTheme(
              data: NavigationBarThemeData(
                labelTextStyle: WidgetStateTextStyle.resolveWith(
                  (states) {
                    if (states.contains(WidgetState.selected)) {
                      return const TextStyle(
                        color: OAppColors.secondary,
                      );
                    }

                    return const TextStyle(color: OAppColors.gray);
                  },
                ),
                //   labelTextStyle: WidgetStateProperty.all(
                // const TextStyle(
                //   fontSize: 12.0,
                //   color: Colors.white,
                // ),)
              ),
              child: NavigationBar(
                height: 80,
                elevation: 0,
                backgroundColor: Colors.transparent,
                indicatorColor: OAppColors.secondary,
                selectedIndex: provider.selectedNavigationScreen,
                onDestinationSelected: (index) => provider.selectScreen(index),
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Iconsax.home),
                    label: "Home",
                  ),
                  NavigationDestination(
                      icon: Icon(Iconsax.search_normal), label: "Explore"),
                  NavigationDestination(icon: Icon(Iconsax.radio), label: "Tv"),
                  NavigationDestination(
                      icon: Icon(Iconsax.fatrows), label: "Favorite"),
                  NavigationDestination(
                      icon: Icon(Iconsax.profile), label: "Account"),
                ],
              ),
            )
          : const SizedBox.shrink();
    });
  }
}
