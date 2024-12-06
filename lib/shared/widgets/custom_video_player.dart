import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ogo/core/constants/api_endpoints.dart';
import 'package:ogo/core/constants/colors.dart';
import 'package:ogo/features/homepage/provider/home_page_provider.dart';
import 'package:ogo/shared/widgets/custom_bottom_navigation.dart';
import 'package:ogo/shared/widgets/custom_glass_morphism.dart';
import 'package:ogo/shared/widgets/custom_header.dart';
import 'package:ogo/shared/widgets/custom_icon_button.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  const CustomVideoPlayer({super.key, required this.movie});
  final Map movie;

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController?
      controller; // Nullable to handle initialization properly
  bool isPlaying = false;
  bool isLoading = true;
  String? errorMessage;
  String? selectedQuality;
  Map<String, String>? qualities;
  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;

  double brightness = 0.5;
  double volume = 0.5;
  bool showControlls = false;
  bool showSettings = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initializeVideoPlayer();
    });
  }

  Future<void> _initializeVideoPlayer([String? qualityKey]) async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final provider = Provider.of<HomePageProvider>(context, listen: false);

    try {
      // Initialize qualities if not already initialized
      if (qualities == null) {
        await provider.getPlayableContent(widget.movie['movieid']);
        qualities = {
          "480p": provider.maincontent?.qualities?.quality_480P ?? "",
          "720p": provider.maincontent?.qualities?.quality_720P ?? "",
          "1080p": provider.maincontent?.qualities?.quality_1080P ?? "",
        }..removeWhere(
            (key, value) => value.isEmpty); // Remove unavailable qualities

        if (qualities == null || qualities!.isEmpty) {
          throw Exception("No playable content available");
        }

        selectedQuality = qualityKey ?? qualities!.keys.first;
      }

      final selectedUrl = qualities![qualityKey ?? selectedQuality];
      if (selectedUrl == null || selectedUrl.isEmpty) {
        throw Exception("Invalid URL for selected quality");
      }

      Uri url = Uri.parse('${OAppEndPoints.mainbaseUrl}/$selectedUrl');

      // Reuse or create a new controller
      if (controller != null && controller!.value.isInitialized) {
        final currentPosition = controller!.value.position;
        await controller!.dispose();
        controller = VideoPlayerController.networkUrl(url)
          ..initialize().then((_) {
            controller!.seekTo(currentPosition);
            if (isPlaying) controller!.play();
            setState(() {
              isLoading = false;
            });
          });
      } else {
        controller = VideoPlayerController.networkUrl(url)
          ..initialize().then((_) {
            setState(() {
              isLoading = false;
            });
          });
      }
      controller?.addListener(
        () {
          setState(() {
            currentPosition = controller!.value.position;
            totalDuration = controller!.value.duration;
          });
        },
      );
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  void adjustVolume(double delta) {
    setState(() {
      volume = (volume + delta).clamp(0.0, 1.0);
    });
    const platform = MethodChannel('pip_channel');
    platform.invokeMethod('setVolume', {'volume': (volume * 100).toInt()});
  }

  void adjustBrightness(double delta) {
    setState(() {
      brightness = (brightness + delta).clamp(0.0, 1.0);
    });
    const platform = MethodChannel('pip_channel');
    platform.invokeMethod('setBrightness', {'brightness': brightness});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showControlls = !showControlls;
          showSettings = false;
        });
      },
      onVerticalDragUpdate: (details) {
        double delta = details.primaryDelta ?? 0;
        if (details.localPosition.dx < MediaQuery.of(context).size.width / 2) {
          // Left side swipe - adjust brightness
          adjustBrightness(delta / MediaQuery.of(context).size.height);
        } else {
          // Right side swipe - adjust volume
          adjustVolume(-delta / MediaQuery.of(context).size.height);
        }
      },
      child: Scaffold(
        backgroundColor: OAppColors.primary,
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Error: $errorMessage",
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("Go Back"),
                        ),
                      ],
                    ),
                  )
                : Stack(
                    children: [
                      if (controller != null &&
                          controller!.value.isInitialized) ...[
                        AspectRatio(
                          aspectRatio: controller!.value.aspectRatio,
                          child: VideoPlayer(
                            controller!,
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (showControlls) ...[
                          Positioned.fill(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OiconButtons(
                                  onTap: () {
                                    final currentPos =
                                        controller!.value.position;
                                    const skipAmount = Duration(seconds: 10);

                                    final skipBackward =
                                        currentPos - skipAmount;
                                    controller!.seekTo(
                                        skipBackward < Duration.zero
                                            ? Duration.zero
                                            : skipBackward);
                                  },
                                  child: const Icon(
                                    Icons.skip_previous_rounded,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                OiconButtons(
                                  onTap: () {
                                    setState(() {
                                      if (controller!.value.isPlaying) {
                                        controller!.pause();
                                      } else {
                                        controller!.play();
                                      }
                                      // Hide controls after a delay if the video starts playing
                                      if (controller!.value.isPlaying) {
                                        Future.delayed(
                                                const Duration(seconds: 1))
                                            .then((_) {
                                          if (controller!.value.isPlaying) {
                                            setState(() {
                                              showControlls = false;
                                              showSettings = false;
                                            });
                                          }
                                        });
                                      }
                                    });
                                  },
                                  child: Icon(
                                    controller != null &&
                                            controller!.value.isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                OiconButtons(
                                  onTap: () {
                                    log("CLicked right side ");
                                    final currentPos =
                                        controller!.value.position;
                                    const skipAmount = Duration(seconds: 10);

                                    final skipForward = currentPos + skipAmount;
                                    final videoDuration =
                                        controller!.value.duration;
                                    controller!.seekTo(
                                        skipForward > videoDuration
                                            ? videoDuration
                                            : skipForward);
                                  },
                                  child: const Icon(
                                    Icons.skip_next_rounded,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 18,
                            right: 5,
                            child: GestureDetector(
                                onTap: () {
                                  SystemChrome.setPreferredOrientations(
                                    [
                                      DeviceOrientation.portraitUp,
                                      DeviceOrientation.portraitDown
                                    ],
                                  ).then((_) {
                                    Navigator.of(context).pop();
                                  });
                                },
                                child: const Icon(Icons.fullscreen_exit)),
                          ),
                          Positioned(
                            top: 18,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Oheader(
                                    textAlign: TextAlign.start,
                                    fontSize: 20,
                                    text: "${widget.movie['movieName']}",
                                    color: OAppColors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            const platform =
                                                MethodChannel('pip_channel');
                                            platform.invokeMethod('enterPiP');
                                          },
                                          child: const Icon(
                                            Icons.picture_in_picture_alt,
                                            color: OAppColors.white,
                                          )),
                                      GestureDetector(
                                          onTap: () {},
                                          child: const Icon(
                                            Icons.share,
                                            color: OAppColors.white,
                                          )),
                                      GestureDetector(
                                          onTap: () {
                                            OGlassMorphism(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                blur: 1,
                                                color: OAppColors.black,
                                                opacity: 0.1,
                                                // margin: const EdgeInsets.symmetric(
                                                //     horizontal: 12.0, vertical: 12.0),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: Container(
                                                  height: 100,
                                                  width: 50,
                                                  color: red,
                                                ));
                                          },
                                          child: const Icon(
                                            Icons.list,
                                            color: OAppColors.white,
                                          )),
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              showSettings = !showSettings;
                                            });
                                          },
                                          child: const Icon(
                                            Icons.settings,
                                            color: OAppColors.white,
                                          )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        // const SizedBox(height: 20),

                        Positioned(
                            bottom: 10,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (showControlls) ...[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 35.0, bottom: 0.0),
                                    child: Row(
                                      children: [
                                        Oheader(
                                          text:
                                              "${_formatDuration(currentPosition)} ",
                                          color: OAppColors.white,
                                        ),
                                        Oheader(
                                            text:
                                                " /  ${_formatDuration(totalDuration)}",
                                            color: OAppColors.primary),
                                      ],
                                    ),
                                  )
                                ],
                                SizedBox(
                                  height: 8,
                                  width: MediaQuery.of(context).size.width - 16,
                                  child: SliderTheme(
                                    data: SliderThemeData(
                                      thumbShape: showControlls == true
                                          ? const RoundSliderThumbShape(
                                              enabledThumbRadius: 7.0)
                                          : SliderComponentShape
                                              .noThumb, // Custom thumb size
                                      trackHeight: 2.0, // Custom track height
                                      activeTrackColor: OAppColors
                                          .secondary, // The color of the played portion
                                      inactiveTrackColor: OAppColors
                                          .grey, // The color of the unplayed portion
                                      thumbColor: OAppColors
                                          .secondary, // Color of the slider's thumb
                                    ),
                                    child: Slider(
                                      value:
                                          currentPosition.inSeconds.toDouble(),
                                      min: 0.0,
                                      max: totalDuration.inSeconds.toDouble(),
                                      onChanged: (double value) {
                                        setState(() {
                                          controller!.seekTo(
                                              Duration(seconds: value.toInt()));
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ],
                      if (qualities != null &&
                          qualities!.isNotEmpty &&
                          showSettings == true) ...[
                        Positioned(
                          top: 55,
                          right: 15,
                          child: OGlassMorphism(
                            blur: 1,
                            color: Colors.white.withOpacity(0.2),
                            opacity: 0.3,
                            width: 160,
                            borderRadius: BorderRadius.circular(7.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text(
                                      "Quality",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    DropdownButton<String>(
                                      value: selectedQuality,
                                      icon: null,
                                      dropdownColor:
                                          OAppColors.white.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(7.0),
                                      items: qualities!.keys
                                          .map((quality) => DropdownMenuItem(
                                                value: quality,
                                                child: Text(
                                                  quality,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ))
                                          .toList(),
                                      onChanged: (newQuality) async {
                                        if (newQuality != null &&
                                            newQuality != selectedQuality) {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          await _initializeVideoPlayer(
                                              newQuality);
                                          setState(() {
                                            selectedQuality = newQuality;
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
      ),
    );
  }
}
