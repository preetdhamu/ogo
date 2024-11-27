import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ogo/core/constants/api_endpoints.dart';
import 'package:ogo/core/constants/assets.dart';
import 'package:ogo/core/constants/colors.dart';
import 'package:ogo/features/homepage/provider/home_page_provider.dart';
import 'package:ogo/features/homepage/ui/movie_about.dart';
import 'package:ogo/features/homepage/ui/movie_similar_list.dart';
import 'package:ogo/features/homepage/ui/movie_trailers_list.dart';
import 'package:ogo/shared/widgets/custom_button.dart';
import 'package:ogo/shared/widgets/custom_glass_morphism.dart';
import 'package:ogo/shared/widgets/custom_header.dart';
import 'package:ogo/shared/widgets/custom_icon_button.dart';
import 'package:provider/provider.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key, required this.movieId});
  final int movieId;

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  int selectedTabbar = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        HomePageProvider provider =
            Provider.of<HomePageProvider>(context, listen: false);
        provider.getMovieDetails(widget.movieId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          backgroundColor: OAppColors.primary,
          body: Consumer<HomePageProvider>(builder: (context, provider, _) {
            return provider.moviedetailload
                ? const Center(
                    child: CircularProgressIndicator(
                    color: OAppColors.secondary,
                  ))
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              height: 480,
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
                                    fit: BoxFit.cover,
                                  );
                                },
                                fadeInDuration:
                                    const Duration(milliseconds: 300),
                                fadeOutDuration:
                                    const Duration(milliseconds: 300),
                                imageUrl:
                                    "${OAppEndPoints.baseUrlfromDBImage}${provider.movieDetail?.posterPath}",
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Positioned(
                                top: 70,
                                left: 10,
                                child: OiconButtons(
                                    child: const Padding(
                                      padding: EdgeInsets.only(left: 6.0),
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                    })),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: OGlassMorphism(
                                width: MediaQuery.of(context).size.width,
                                blur: 1,
                                color: OAppColors.primary,
                                opacity: 0.6,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(22),
                                    topRight: Radius.circular(22)),
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
                                                    BorderRadius.circular(5.0)),
                                          ),
                                          const SizedBox(width: 5),
                                          Oheader(
                                            overflow: TextOverflow.ellipsis,
                                            text:
                                                "${provider.movieDetail?.voteAverage}",
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
                                        text: provider.movieDetail?.title ?? '',
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
                                            width: 55,
                                            height: 25,
                                            text:
                                                "${provider.movieDetail?.releaseDate?.split('-').firstOrNull}",
                                            fontSize: 12.0,
                                            onPressed: () {},
                                            textColor: Colors.white,
                                            borderRadius: 25.0,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Obutton(
                                            width: 100,
                                            height: 25,
                                            text:
                                                "${provider.movieDetail?.genres?.first.name}",
                                            fontSize: 12.0,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 2.0),
                                            onPressed: () {},
                                            textColor: Colors.white,
                                            borderRadius: 25.0,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Obutton(
                                            width: 55,
                                            height: 25,
                                            text:
                                                "${provider.movieDetail?.originalLanguage?.toUpperCase()}",
                                            fontSize: 12.0,
                                            onPressed: () {},
                                            textColor: Colors.white,
                                            borderRadius: 25.0,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              OiconButtons(
                                                  child: const Icon(
                                                    Icons.download,
                                                    size: 16,
                                                    color: Colors.white,
                                                  ),
                                                  onTap: () {}),
                                              const SizedBox(width: 10),
                                              OiconButtons(
                                                  child: const Icon(
                                                    Icons
                                                        .bookmark_border_rounded,
                                                    size: 16,
                                                    color: Colors.white,
                                                  ),
                                                  onTap: () {}),
                                              const SizedBox(width: 10),
                                              OiconButtons(
                                                  child: const Icon(
                                                    Icons.share,
                                                    size: 16,
                                                    color: Colors.white,
                                                  ),
                                                  onTap: () {}),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "P-${provider.movieDetail?.id}z : ${provider.lengthofMovie(provider.movieDetail?.runtime ?? 0)}",
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                  fontSize: 14, color: OAppColors.lightwhite),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "${provider.movieDetail?.overview}",
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                                fontSize: 14, color: OAppColors.lightwhite),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TabBar(
                            splashFactory: NoSplash.splashFactory,
                            labelStyle:
                                const TextStyle(color: OAppColors.secondary),
                            indicatorColor: OAppColors.secondary,
                            isScrollable: false,
                            unselectedLabelColor: OAppColors.gray,
                            dividerHeight: 0,
                            dividerColor: Colors.transparent,
                            onTap: (index) {
                              setState(() {
                                selectedTabbar = index;
                              });
                            },
                            tabs: const [
                              Tab(
                                text: "Trailers",
                              ),
                              Tab(
                                text: "More Like this",
                              ),
                              Tab(
                                text: "About",
                              ),
                            ]),
                        const SizedBox(
                          height: 5,
                        ),
                        // SizedBox(
                        //   height: 753,
                        //   child: TabBarView(children: [
                        //     const MovieTrailerList(),
                        //     const SimilarMovieList(),
                        //     AboutMovie(movieId: provider.movieDetail?.id),
                        //   ]),
                        // )

                        Builder(
                          builder: (context) {
                            switch (selectedTabbar) {
                              case 0:
                                return const MovieTrailerList();
                              case 1:
                                return const SimilarMovieList();
                              case 2:
                                return AboutMovie(
                                    movieId: provider.movieDetail?.id);

                              default:
                                return const MovieTrailerList();
                            }
                          },
                        )
                      ],
                    ),
                  );
          })),
    );
  }
}
