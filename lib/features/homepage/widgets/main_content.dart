import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ogo/core/constants/api_endpoints.dart';
import 'package:ogo/core/constants/assets.dart';
import 'package:ogo/core/constants/colors.dart';
import 'package:ogo/core/constants/typography.dart';

import 'package:ogo/features/authentication/providers/auth_service_provider.dart';
import 'package:ogo/features/homepage/provider/home_page_provider.dart';
import 'package:ogo/features/homepage/ui/home_page.dart';

import 'package:ogo/routes/app_routes.dart';
import 'package:ogo/routes/app_routes_home.dart';
import 'package:ogo/shared/widgets/custom_button.dart';
import 'package:ogo/shared/widgets/custom_glass_morphism.dart';
import 'package:ogo/shared/widgets/custom_grid_view_unequal.dart';
import 'package:ogo/shared/widgets/custom_icon_button.dart';
import 'package:ogo/shared/widgets/custom_log.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

import '../../../shared/widgets/custom_header.dart';

class MainContent extends StatefulWidget {
  const MainContent({
    super.key,
  });

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  int currentPage = 0;
  Timer? _timer;
  int totalItems = 0;
  int maxVisibleDots = 5;
  int startIndex = 0;

  int visibleDotsCount = 5;

  final PageController _pageController = PageController(viewportFraction: 0.4);
  @override
  void initState() {
    currentPage = 0;
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        try {
          HomePageProvider provider =
              Provider.of<HomePageProvider>(context, listen: false);

          if (!provider.load) {
            List<Future> items = [];
            items.add(provider.getNowPlayingMovies());
            items.add(provider.getTopRatingMovies());
            items.add(provider.getNowPlayingTv());
            if (provider.selectGenre == false) {
              items.add(provider.getGenre());
            }
            Oshowlog("asdadasdcxcvbghfghf", "${items.length}");
            await Future.wait(items);
          }
        } on Exception catch (e) {
          Oshowlog1("$e");
        }

        startAutoScrolling();
      },
    );
  }

  void startAutoScrolling() {
    HomePageProvider provider =
        Provider.of<HomePageProvider>(context, listen: false);

    // Auto-scroll functionality
    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) {
        if (_pageController.hasClients) {
          final maxPages = provider.topRatingMovies.length;

          if (maxPages > 0) {
            if (provider.hasMoreTopMovies == true &&
                currentPage == maxPages - 5 &&
                !provider.topratingMoviesload) {
              provider
                  .getTopRatingMovies(
                      pageNumber: provider.incrementPageCountTopMovies())
                  .whenComplete(
                () {
                  Oshowlog1("Completed Loading New Data");
                  setState(() {});
                },
              );
            }
            currentPage = currentPage + 1;
            _pageController.animateToPage(
              currentPage,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthServiceProvider, HomePageProvider>(
      builder: (context, authProvider, homeProvider, _) {
        return homeProvider.load ||
                authProvider.load ||
                homeProvider.nowplayingmovieload ||
                homeProvider.getgenrebool
            ? const Center(
                child: CircularProgressIndicator(
                color: red,
              ))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 480,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: 400,
                                width: MediaQuery.of(context).size.width,
                                child: CachedNetworkImage(
                                  progressIndicatorBuilder:
                                      (context, url, progress) => Center(
                                    child: CircularProgressIndicator(
                                        value: progress.progress),
                                  ),
                                  errorWidget: (context, url, error) {
                                    return Image.asset(
                                      OImage.defaultImage,
                                      fit: BoxFit.fitWidth,
                                      height: 400,
                                    );
                                  },
                                  fadeInDuration:
                                      const Duration(milliseconds: 300),
                                  fadeOutDuration:
                                      const Duration(milliseconds: 300),
                                  imageUrl:
                                      "${OAppEndPoints.baseUrlfromDBImage}${homeProvider.topRatingMovies[currentPage].posterPath}",
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Positioned(
                                top: 50,
                                right: 10,
                                child: OiconButtons(
                                    child: const Icon(
                                      Icons.logout,
                                      color: OAppColors.white,
                                      size: 13,
                                    ),
                                    onTap: () async {
                                      await authProvider.authService.signOut();
                                      Navigator.pushNamed(
                                          context, OAppRoutes.splash);
                                    }),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                child: OGlassMorphism(
                                  width: MediaQuery.of(context).size.width,
                                  blur: 1,
                                  color: OAppColors.black,
                                  opacity: 0.1,
                                  borderRadius: BorderRadius.circular(12),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 18,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                  color: red,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                            const SizedBox(width: 5),
                                            Oheader(
                                              overflow: TextOverflow.ellipsis,
                                              text:
                                                  "${homeProvider.topRatingMovies[currentPage].voteAverage}",
                                              glow: true,
                                              fontSize: 14,
                                              color: OAppColors.white,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Oheader(
                                          overflow: TextOverflow.ellipsis,
                                          text: homeProvider
                                                  .topRatingMovies[currentPage]
                                                  .title ??
                                              '',
                                          glow: true,
                                          fontSize: 20,
                                          color: OAppColors.white,
                                          fontWeight: FontWeight.w800,
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Obutton(
                                              text: "Watch Now",
                                              color: OAppColors.secondry2,
                                              onPressed: () {},
                                              textColor: Colors.white,
                                              borderRadius: 62.0,
                                              width: 160,
                                              height: 35,
                                            ),
                                            const SizedBox(width: 10),
                                            OiconButtons(
                                                child: const Icon(
                                                  Icons.bookmark_border_rounded,
                                                  size: 20,
                                                  color: Colors.white,
                                                ),
                                                onTap: () {}),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          homeProvider.topRatingMovies.isNotEmpty
                              ? SizedBox(
                                  height: 65,
                                  child: PageView.builder(
                                    controller: _pageController,
                                    scrollDirection: Axis.horizontal,
                                    onPageChanged: (value) {
                                      setState(() {
                                        currentPage = value;
                                      });
                                    },
                                    itemCount: homeProvider
                                            .topRatingMovies.length +
                                        (homeProvider.hasMoreTopMovies ? 1 : 0),
                                    itemBuilder: (context, index) {
                                      if (index <
                                          homeProvider.topRatingMovies.length) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pushNamed(
                                                    OAppRoutes.moviedetail,
                                                    arguments: homeProvider
                                                        .topRatingMovies[index]
                                                        .id);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2.0, horizontal: 5.0),
                                            child: Container(
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  color: const Color.fromRGBO(
                                                      34, 68, 131, 0.698),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0)),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(7.0),
                                                child: CachedNetworkImage(
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              progress) =>
                                                          Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                            value: progress
                                                                .progress),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) {
                                                    return Image.asset(
                                                      OImage.defaultImage,
                                                      fit: BoxFit.cover,
                                                    );
                                                  },
                                                  fadeInDuration:
                                                      const Duration(
                                                          milliseconds: 300),
                                                  fadeOutDuration:
                                                      const Duration(
                                                          milliseconds: 300),
                                                  imageUrl:
                                                      "${OAppEndPoints.baseUrlfromDBImage}${homeProvider.topRatingMovies?[index].posterPath}",
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(
                                              color: OAppColors.green),
                                        );
                                      }
                                    },
                                  ),
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(height: 5),
                          if (homeProvider.topRatingMovies.isNotEmpty &&
                              currentPage >= 0 &&
                              currentPage <
                                  homeProvider.topRatingMovies.length) ...[
                            Center(
                              child: SizedBox(
                                width: 120,
                                child: PageViewDotIndicator(
                                  currentItem: currentPage,
                                  count:
                                      homeProvider.topRatingMovies?.length ?? 0,
                                  unselectedColor: OAppColors.darkBlue,
                                  selectedColor: OAppColors.secondary,
                                  boxShape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(7.0),
                                  size: const Size(20.0, 5.0),
                                  unselectedSize: const Size(18.0, 5.0),
                                  duration: const Duration(milliseconds: 300),
                                  onItemClicked: (index) {
                                    _pageController.animateToPage(index,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut);
                                  },
                                ),
                              ),
                            ),
                          ] else ...[
                            const Center(
                              child: Icon(
                                Icons.add,
                                size: 12,
                                color: OAppColors.white,
                              ),
                            )
                          ]
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    // For You Section
                    SizedBox(
                      height: 221,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Oheader(
                                  overflow: TextOverflow.ellipsis,
                                  text: 'For You',
                                  glow: true,
                                  fontSize: 18,
                                  color: OAppColors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, OAppRoutesHome.foryouMovies);
                                  },
                                  child: const Oheader(
                                    overflow: TextOverflow.ellipsis,
                                    text: "See All",
                                    fontSize: 14,
                                    color: OAppColors.secondary,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 180,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: homeProvider.foryou.length +
                                    (homeProvider.hasMoreTopMovies ? 1 : 0),
                                itemBuilder: (context, index) {
                                  if (index < homeProvider.foryou.length) {
                                    return GestureDetector(
                                      onTap: () {
                                        Oshowlog1(homeProvider.foryou[index]
                                            .toJson()
                                            .toString());

                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pushNamed(OAppRoutes.moviedetail,
                                                arguments: homeProvider
                                                    .foryou[index].id);
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 7.0, vertical: 0.0),
                                            width: 115,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7.0),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(7.0),
                                              child: CachedNetworkImage(
                                                progressIndicatorBuilder:
                                                    (context, url, progress) =>
                                                        Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: progress.progress,
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) {
                                                  return Image.asset(
                                                    OImage.defaultImage,
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                                fadeInDuration: const Duration(
                                                    milliseconds: 300),
                                                fadeOutDuration: const Duration(
                                                    milliseconds: 300),
                                                imageUrl:
                                                    "${OAppEndPoints.baseUrlfromDBImage}${homeProvider.foryou[index].posterPath}",
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 5,
                                            left: 12,
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 18,
                                                  width: 25,
                                                  decoration: BoxDecoration(
                                                      color: red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0)),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Oheader(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  text:
                                                      "${homeProvider.foryou[index].voteAverage}",
                                                  glow: true,
                                                  fontSize: 14,
                                                  color: OAppColors.white,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: red,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Categories
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Oheader(
                              overflow: TextOverflow.ellipsis,
                              text: 'Categories',
                              fontSize: 18,
                              glow: true,
                              color: OAppColors.white,
                              fontWeight: FontWeight.w800,
                            ),
                            const SizedBox(
                              height: 15,
                            ),

                            /// UnSize Boxes
                            OGridViewUnequal(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              items: 6,
                              builder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Oshowlog1(
                                        "Categorie clicked ${homeProvider.likeMovieModel?.genres?[index]}");

                                    Navigator.pushNamed(
                                        context, OAppRoutesHome.categorizemovie,
                                        arguments: homeProvider
                                            .likeMovieModel?.genres?[index]);
                                  },
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.48,
                                          height: (index % 5 + 2) * 30,
                                          child: Image.asset(
                                            homeProvider?.likeMovieModel
                                                    ?.genre_images[index] ??
                                                OImage.defaultImage,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 5,
                                        left: 8,
                                        child: OGlassMorphism(
                                          blur: 1,
                                          color: OAppColors.black,
                                          opacity: 0.6,
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 7.0, vertical: 1.0),
                                            child: Oheader(
                                              overflow: TextOverflow.ellipsis,
                                              text:
                                                  '${homeProvider.likeMovieModel?.genres?[index]?.name}'
                                                      .toUpperCase(),
                                              fontSize: 10,
                                              color: OAppColors.white,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    //// Now Playing In threaters
                    SizedBox(
                      height: 221,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Hero(
                                      transitionOnUserGestures: true,
                                      tag: "nowPlaying",
                                      child: Oheader(
                                        overflow: TextOverflow.ellipsis,
                                        text: 'Now Playing',
                                        glow: true,
                                        fontSize: 18,
                                        color: OAppColors.white,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Oheader(
                                        overflow: TextOverflow.ellipsis,
                                        text:
                                            '${homeProvider.maximumDate} - ${homeProvider.minimumDate}',
                                        fontSize: 10,
                                        glow: false,
                                        color: OAppColors.lightgray,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, OAppRoutesHome.allMovies);
                                  },
                                  child: const Oheader(
                                    overflow: TextOverflow.ellipsis,
                                    text: "See All",
                                    fontSize: 14,
                                    color: OAppColors.secondary,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 180,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: homeProvider.nowPlayingMovies.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Oshowlog1(homeProvider.foryou[index]
                                          .toJson()
                                          .toString());

                                      Navigator.of(context, rootNavigator: true)
                                          .pushNamed(OAppRoutes.moviedetail,
                                              arguments: homeProvider
                                                  .nowPlayingMovies[index].id);
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 7.0),
                                          width: 115,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7.0),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(7.0),
                                            child: CachedNetworkImage(
                                              progressIndicatorBuilder:
                                                  (context, url, progress) =>
                                                      Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  value: progress.progress,
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) {
                                                return Image.asset(
                                                  OImage.defaultImage,
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                              fadeInDuration: const Duration(
                                                  milliseconds: 300),
                                              fadeOutDuration: const Duration(
                                                  milliseconds: 300),
                                              imageUrl:
                                                  "${OAppEndPoints.baseUrlfromDBImage}${homeProvider.nowPlayingMovies[index].posterPath}",
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 5,
                                          left: 12,
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 18,
                                                width: 25,
                                                decoration: BoxDecoration(
                                                    color: red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0)),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Oheader(
                                                overflow: TextOverflow.ellipsis,
                                                text:
                                                    "${homeProvider.nowPlayingMovies?[index].voteAverage}",
                                                glow: true,
                                                fontSize: 14,
                                                color: OAppColors.white,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    //// Now Playing In TV
                    SizedBox(
                      height: 221,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Oheader(
                                  overflow: TextOverflow.ellipsis,
                                  text: 'Now on TV',
                                  glow: true,
                                  fontSize: 18,
                                  color: OAppColors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    homeProvider.selectScreen(2);
                                  },
                                  child: const Oheader(
                                    overflow: TextOverflow.ellipsis,
                                    text: "See All",
                                    fontSize: 16,
                                    color: OAppColors.secondary,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 160,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: homeProvider
                                        .nowPlayingTv?.results?.length ??
                                    0,
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 120,
                                        child: Stack(
                                          children: [
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 7.0),
                                              width: 220,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(7.0),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(7.0),
                                                child: CachedNetworkImage(
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              progress) =>
                                                          Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      value: progress.progress,
                                                    ),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) {
                                                    return Image.asset(
                                                      OImage.defaultImage,
                                                      fit: BoxFit.fill,
                                                    );
                                                  },
                                                  fadeInDuration:
                                                      const Duration(
                                                          milliseconds: 300),
                                                  fadeOutDuration:
                                                      const Duration(
                                                          milliseconds: 300),
                                                  imageUrl:
                                                      "${OAppEndPoints.baseUrlfromDBImage}${homeProvider.nowPlayingTv?.results?[index].backdropPath}",
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 5,
                                              left: 12,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 18,
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                        color: red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0)),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Oheader(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    text:
                                                        "${homeProvider.nowPlayingTv?.results?[index].voteAverage}",
                                                    glow: true,
                                                    fontSize: 14,
                                                    color: OAppColors.white,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: SizedBox(
                                          height: 20,
                                          child: Oheader(
                                            overflow: TextOverflow.ellipsis,
                                            text:
                                                "${homeProvider.nowPlayingTv?.results?[index].name}",
                                            fontSize: 16,
                                            color: OAppColors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: SizedBox(
                                          height: 15,
                                          child: Oheader(
                                            overflow: TextOverflow.ellipsis,
                                            text:
                                                "${homeProvider.nowPlayingTv?.results?[index].firstAirDate}",
                                            fontSize: 12,
                                            color: OAppColors.lightgray,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
