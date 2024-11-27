import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ogo/core/constants/api_endpoints.dart';
import 'package:ogo/core/constants/assets.dart';
import 'package:ogo/features/homepage/models/like_movie_model.dart';
import 'package:ogo/features/homepage/provider/home_page_provider.dart';
import 'package:ogo/routes/app_routes.dart';
import 'package:ogo/shared/widgets/custom_header.dart';
import 'package:ogo/shared/widgets/custom_log.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';

class CategorizeMovies extends StatefulWidget {
  final Genres genre;
  const CategorizeMovies({super.key, required this.genre});

  @override
  State<CategorizeMovies> createState() => _CategorizeMoviesState();
}

class _CategorizeMoviesState extends State<CategorizeMovies> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<HomePageProvider>(context, listen: false);

    // Load the initial set of movies
    // provider.getNowPlayingMovies(pageNumber: provider.currentPage + 1);

    // Add scroll listener for infinite scrolling
    provider.getCategorizedMovies(widget.genre.id ?? 0, pageNumber: 1);

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          provider.hasMoreNowPlayingCategorizedMovies &&
          !provider.categorizeMovieload) {
        provider
            .getCategorizedMovies(widget.genre.id ?? 0,
                pageNumber: provider.incrementPageCount())
            .whenComplete(
              () => Oshowlog1("Completed Loading NEw Data "),
            );
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose(); // Dispose the ScrollController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OAppColors.primary,
      body: Consumer<HomePageProvider>(builder: (context, provider, _) {
        return CustomScrollView(
          controller: scrollController, // Attach ScrollController here
          slivers: [
            // Sliver App Bar
            SliverAppBar(
              floating: true,
              leading: GestureDetector(
                onTap: () => Navigator.pop(context), // Simplified navigation
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: OAppColors.white,
                ),
              ),
              expandedHeight: 50,
              pinned: true,
              backgroundColor: OAppColors.primary.withOpacity(0.8),
              flexibleSpace: FlexibleSpaceBar(
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Oheader(
                    text: "${widget.genre.name} Movies",
                    fontSize: 22,
                    glow: true,
                    lines: 2,
                    color: OAppColors.white,
                  ),
                ),
                centerTitle: true,
              ),
            ),

            // Movies Grid
            SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.7, // Adjust aspect ratio as needed
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index < provider.categorizedMovies.length) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pushNamed(
                              OAppRoutes.moviedetail,
                              arguments: provider.categorizedMovies[index].id);
                        },
                        child: Stack(
                          children: [
                            ClipRRect(
                              // height: 90,
                              // decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.0),
                              // ),
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
                                    fit: BoxFit.fitWidth,
                                    height: 400,
                                  );
                                },
                                fadeInDuration:
                                    const Duration(milliseconds: 300),
                                fadeOutDuration:
                                    const Duration(milliseconds: 300),
                                imageUrl:
                                    "${OAppEndPoints.baseUrlfromDBImage}${provider.categorizedMovies[index].posterPath}",
                                fit: BoxFit.fill,
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
                                        "${provider.categorizedMovies[index].voteAverage}",
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
                      // Show a loading spinner at the end of the grid
                      return const Center(
                        child: CircularProgressIndicator(
                          color: OAppColors.secondary,
                        ),
                      );
                    }
                  },
                  childCount: provider.categorizedMovies.length +
                      (provider.hasMoreNowPlayingCategorizedMovies ? 1 : 0),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
