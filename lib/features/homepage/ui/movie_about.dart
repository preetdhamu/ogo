import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ogo/core/constants/api_endpoints.dart';
import 'package:ogo/core/constants/assets.dart';
import 'package:ogo/core/constants/colors.dart';
import 'package:ogo/features/homepage/provider/home_page_provider.dart';
import 'package:ogo/shared/widgets/custom_header.dart';
import 'package:provider/provider.dart';

class AboutMovie extends StatefulWidget {
  const AboutMovie({super.key, required this.movieId});
  final int? movieId;

  @override
  State<AboutMovie> createState() => _AboutMovieState();
}

class _AboutMovieState extends State<AboutMovie> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        HomePageProvider provider =
            Provider.of<HomePageProvider>(context, listen: false);
        if (widget.movieId != null) {
          provider.getCredits(widget.movieId ?? 0);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageProvider>(
      builder: (context, provider, child) {
        return provider.moviecreditload
            ? const Center(
                child: CircularProgressIndicator(
                  color: OAppColors.secondary,
                ),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0, right: 48.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Oheader(
                              text: 'Audio Track',
                              fontSize: 16,
                            ),
                            Oheader(
                              text:
                                  '${provider.movieDetail?.spokenLanguages?.map((element) => element.englishName).join(', ')}',
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                              color: OAppColors.lightgray,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Oheader(
                              text: 'SubTitles',
                              fontSize: 16,
                            ),
                            Oheader(
                              text:
                                  '${provider.movieDetail?.originalLanguage?.toUpperCase()}',
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                              color: OAppColors.lightgray,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0, right: 38.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Oheader(
                              text: 'Country',
                              fontSize: 16,
                            ),
                            Oheader(
                              text:
                                  '${provider.movieDetail?.originCountry?.map((element) => element).toList().join(', ')}',
                              fontSize: 14,
                              color: OAppColors.lightgray,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Oheader(
                              text: 'Year',
                              fontSize: 16,
                            ),
                            Oheader(
                              text: '${provider.movieDetail?.releaseDate}',
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                              color: OAppColors.lightgray,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 291,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Oheader(
                            overflow: TextOverflow.ellipsis,
                            text: 'Casting',
                            glow: true,
                            fontSize: 18,
                            color: OAppColors.white,
                            fontWeight: FontWeight.w800,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 220,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  provider.moviecreditModel?.cast?.length ?? 0,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 180,
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
                                                    "${OAppEndPoints.baseUrlfromDBImage}${provider.moviecreditModel?.cast?[index].profilePath}",
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
                                                      "${provider.moviecreditModel?.cast?[index].popularity}",
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
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Oheader(
                                          overflow: TextOverflow.ellipsis,
                                          text:
                                              "${provider.moviecreditModel?.cast?[index].name}"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Oheader(
                                          overflow: TextOverflow.ellipsis,
                                          text:
                                              "${provider.moviecreditModel?.cast?[index].knownForDepartment}"),
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
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 291,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Oheader(
                            overflow: TextOverflow.ellipsis,
                            text: 'Crew',
                            glow: true,
                            fontSize: 18,
                            color: OAppColors.white,
                            fontWeight: FontWeight.w800,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 250,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  provider.moviecreditModel?.crew?.length ?? 0,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 180,
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
                                                    "${OAppEndPoints.baseUrlfromDBImage}${provider.moviecreditModel?.crew?[index].profilePath}",
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
                                                      "${provider.moviecreditModel?.crew?[index].popularity}",
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
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Oheader(
                                          overflow: TextOverflow.ellipsis,
                                          text:
                                              "${provider.moviecreditModel?.crew?[index].name}"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Oheader(
                                          overflow: TextOverflow.ellipsis,
                                          text:
                                              "${provider.moviecreditModel?.crew?[index].knownForDepartment}"),
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
              );
      },
    );
  }
}
