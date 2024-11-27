import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ogo/core/constants/api_endpoints.dart';
import 'package:ogo/core/constants/assets.dart';
import 'package:ogo/features/homepage/models/top_rating_movies_model.dart';
import 'package:ogo/features/homepage/provider/home_page_provider.dart';
import 'package:ogo/routes/app_routes.dart';
import 'package:ogo/shared/widgets/custom_header.dart';

import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';

class ForYouMovies extends StatefulWidget {
  const ForYouMovies({super.key});

  @override
  State<ForYouMovies> createState() => _ForYouMoviesState();
}

class _ForYouMoviesState extends State<ForYouMovies> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OAppColors.primary,
      body: Consumer<HomePageProvider>(builder: (context, provider, _) {
        return CustomScrollView(
          // Attach ScrollController here
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
              flexibleSpace: const FlexibleSpaceBar(
                title: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: Oheader(
                    text: 'Trending for You',
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
                    if (index < provider.foryou.length) {
                      return GestureDetector(
                        onTap: (){
                           Navigator.of(context, rootNavigator: true).pushNamed(
                              OAppRoutes.moviedetail,
                              arguments: provider.foryou[index].id);
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
                                fadeInDuration: const Duration(milliseconds: 300),
                                fadeOutDuration:
                                    const Duration(milliseconds: 300),
                                imageUrl:
                                    "${OAppEndPoints.baseUrlfromDBImage}${provider.foryou[index].posterPath}",
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
                                        borderRadius: BorderRadius.circular(5.0)),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Oheader(
                                    overflow: TextOverflow.ellipsis,
                                    text: "${provider.foryou[index].voteAverage}",
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
                  childCount: provider.foryou.length +
                      (provider.hasMoreNowPlaying ? 1 : 0),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
