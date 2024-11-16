import 'package:flutter/material.dart';
import 'package:ogo/core/constants/assets.dart';
import 'package:ogo/core/constants/colors.dart';
import 'package:ogo/features/authentication/data/auth_api.dart';
import 'package:ogo/features/authentication/providers/auth_service_provider.dart';
import 'package:ogo/features/homepage/provider/home_page_provider.dart';
import 'package:ogo/features/homepage/ui/home_page.dart';
import 'package:ogo/routes/app_routes.dart';
import 'package:ogo/shared/widgets/custom_button.dart';
import 'package:ogo/shared/widgets/custom_icon_button.dart';
import 'package:ogo/shared/widgets/custom_log.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../shared/widgets/custom_header.dart';

class LikeMovies extends StatefulWidget {
  const LikeMovies({
    super.key,
  });

  @override
  State<LikeMovies> createState() => _LikeMoviesState();
}

class _LikeMoviesState extends State<LikeMovies> {
  @override
  void initState() {
    super.initState();
    Oshowlog1("${AuthAPI.userdetails.toString()}");
    Oshowlog1("Calling other api's ");
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        try {
          HomePageProvider provider =
              Provider.of<HomePageProvider>(context, listen: false);
          provider.checkLikeGenre().then(
            (value) {
              if (value == true) {
                provider.getGenre();
              }
            },
          );
        } on Exception catch (e) {
          Oshowlog1(e.toString());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthServiceProvider, HomePageProvider>(
      builder: (context, authProvider, homeProvider, _) {
        return homeProvider.load == true
            ? const CircularProgressIndicator()
            : Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        actions: [
                          GestureDetector(
                            onTap: () async {
                              await authProvider.authService.signOut().then(
                                (value) {
                                  if (value) {
                                    Navigator.pushReplacementNamed(
                                        context, AppRoutes.splash);
                                  } else {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(),
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.logout_outlined,
                                size: 16.0,
                                color: OAppColors.white,
                              ),
                            ),
                          )
                        ],
                        floating: true,
                        expandedHeight: 150.0,
                        pinned: true,
                        backgroundColor: OAppColors.black.withOpacity(0.8),
                        flexibleSpace: FlexibleSpaceBar(
                          title: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.0),
                            child: Oheader(
                              text: 'Pick What You\'d Like to Watch',
                              fontSize: 18,
                              glow: true,
                              lines: 2,
                              color: OAppColors.white,
                            ),
                          ),
                          centerTitle: true,
                          background: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                OImage.splashImage,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 15,
                                      blurStyle: BlurStyle.inner,
                                      spreadRadius: 10,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final genre =
                                homeProvider.likeMovieModel?.genres?[index];
                            return Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (genre?.selected == true) {
                                        genre?.selected = false;
                                      } else {
                                        genre?.selected = true;
                                      }
                                    });
                                    Oshowlog1("Clicked $index");
                                  },
                                  child: Container(
                                    height: 100,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 8.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: genre?.selected == true
                                          ? Border.all(
                                              color: OAppColors.secondary,
                                              width: 1.0)
                                          : null,
                                      image: DecorationImage(
                                          opacity: 0.7,
                                          filterQuality: FilterQuality.medium,
                                          image: AssetImage('${genre?.image}'),
                                          fit: BoxFit.cover),
                                    ),
                                    child: Center(
                                      child: OiconButtons(
                                          // extra: false,
                                          child: Oheader(
                                            text: genre?.name ?? '',
                                            fontSize: 14,
                                          ),
                                          onTap: null),
                                    ),
                                  ),
                                ),
                                genre?.selected == true
                                    ? const Positioned(
                                        top: 15,
                                        right: 15,
                                        child: Icon(
                                          Icons.check_circle,
                                          color: OAppColors.secondary,
                                          size: 14,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            );
                          },
                          childCount:
                              homeProvider.likeMovieModel?.genres?.length ?? 0,
                        ),
                      ),
                    ],
                  ),
                  homeProvider.showNextButton() == true
                      ? Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Obutton(
                              text: "Next",
                              color: OAppColors.secondry2,
                              onPressed: () async {
                                homeProvider.saveLikeGenre();
                              },
                              textColor: Colors.white,
                              borderRadius: 12.0,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              );
      },
    );
  }
}
