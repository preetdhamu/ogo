import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ogo/core/constants/assets.dart';
import 'package:ogo/core/constants/colors.dart';
import 'package:ogo/features/homepage/provider/home_page_provider.dart';
import 'package:ogo/routes/app_routes.dart';
import 'package:ogo/shared/widgets/custom_glass_morphism.dart';
import 'package:ogo/shared/widgets/custom_header.dart';
import 'package:ogo/shared/widgets/custom_icon_button.dart';
import 'package:ogo/shared/widgets/custom_log.dart';
import 'package:provider/provider.dart';

class MovieTrailerList extends StatefulWidget {
  const MovieTrailerList({super.key});

  @override
  State<MovieTrailerList> createState() => _MovieTrailerListState();
}

class _MovieTrailerListState extends State<MovieTrailerList> {
  bool showPlayButton = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        HomePageProvider provider =
            Provider.of<HomePageProvider>(context, listen: false);
        if (provider.movieDetail?.id != null) {
          provider.getMovieVideo(provider.movieDetail?.id ?? 0);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageProvider>(
      builder: (context, provider, child) {
        return provider.movievideoload
            ? const Center(
                child: CircularProgressIndicator(
                color: OAppColors.secondary,
              ))
            : ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(
                    top: 0, bottom: 15, left: 0, right: 0),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pushNamed(
                          OAppRoutes.youtubePlayer,
                          arguments:
                              provider.movieVideoModel?.results?[index].key);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 8.0),
                      height: 100,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: OAppColors.secondary,
                                        borderRadius:
                                            BorderRadius.circular(7.0)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(7.0),
                                      child: CachedNetworkImage(
                                        filterQuality: FilterQuality.medium,
                                        progressIndicatorBuilder:
                                            (context, url, progress) {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: progress.progress,
                                            ),
                                          );
                                        },
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
                                            "https://img.youtube.com/vi/${provider.movieVideoModel?.results?[index].key}/mqdefault.jpg",
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      left: 66,
                                      top: 33,
                                      child: OiconButtons(
                                          extra: false,
                                          child: const Icon(
                                            Icons.play_arrow_rounded,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                          onTap: () {
                                            // Navigator.pop(context);
                                          })),
                                ],
                              )),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.0)),
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  "${provider.movieVideoModel?.results?[index].name}",
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: OAppColors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              )),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: provider.movieVideoModel?.results?.length ?? 0,
              );
      },
    );
  }
}
