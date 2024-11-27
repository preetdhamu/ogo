import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ogo/core/constants/api_endpoints.dart';
import 'package:ogo/core/constants/assets.dart';
import 'package:ogo/core/constants/colors.dart';
import 'package:ogo/features/homepage/provider/home_page_provider.dart';
import 'package:ogo/routes/app_routes.dart';
import 'package:ogo/shared/widgets/custom_header.dart';
import 'package:provider/provider.dart';

class SimilarMovieList extends StatefulWidget {
  const SimilarMovieList({super.key});

  @override
  State<SimilarMovieList> createState() => _SimilarMovieListState();
}

class _SimilarMovieListState extends State<SimilarMovieList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        HomePageProvider provider =
            Provider.of<HomePageProvider>(context, listen: false);
        if (provider.movieDetail?.id != null) {
          provider.getSimilarMovies(provider.movieDetail?.id ?? 0);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageProvider>(
      builder: (context, provider, child) {
        return provider.similarmovieload
            ? const Center(
                child: CircularProgressIndicator(
                  color: OAppColors.secondary,
                ),
              )
            : Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: provider.similarMovies?.results?.length ?? 0,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true)
                                .pushReplacementNamed(OAppRoutes.moviedetail,
                                    arguments: provider
                                        .similarMovies?.results?[index].id);
                          },
                          child: Stack(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 7.0),
                                width: 145,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(7.0),
                                  child: CachedNetworkImage(
                                    progressIndicatorBuilder:
                                        (context, url, progress) => Center(
                                      child: CircularProgressIndicator(
                                        value: progress.progress,
                                      ),
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
                                        "${OAppEndPoints.baseUrlfromDBImage}${provider.similarMovies?.results?[index].posterPath}",
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
                                              BorderRadius.circular(5.0)),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Oheader(
                                      overflow: TextOverflow.ellipsis,
                                      text:
                                          "${provider.similarMovies?.results?[index].voteAverage}",
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
                  const SizedBox(
                    height: 10,
                  ),
                ],
              );
      },
    );
  }
}
