import 'package:flutter/services.dart';
import 'package:ogo/core/constants/colors.dart';
import 'package:ogo/shared/widgets/custom_icon_button.dart';
import 'package:ogo/shared/widgets/custom_log.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';

class CustomYoutubeVideoPlayer extends StatefulWidget {
  const CustomYoutubeVideoPlayer({super.key, required this.videoId});
  final String videoId;

  @override
  State<CustomYoutubeVideoPlayer> createState() =>
      _CustomYoutubeVideoPlayerState();
}

class _CustomYoutubeVideoPlayerState extends State<CustomYoutubeVideoPlayer> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight
        ]);
      },
    );
    Oshowlog1("essage");
    controller = YoutubePlayerController(
        initialVideoId: widget.videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          controlsVisibleAtStart: true,
          forceHD: true,
        ));
  }

  @override
  void dispose() {
    controller.dispose();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
        SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      },
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text("Youtbue Player"),
        //   actions: [
        //     OiconButtons(
        //         child: const Icon(Icons.close),
        //         onTap: () {
        //           Navigator.pop(context);
        //         })
        //   ],
        // ),
        body: YoutubePlayer(
          progressColors: const ProgressBarColors(
              backgroundColor: OAppColors.primary,
              bufferedColor: OAppColors.white,
              handleColor: OAppColors.secondary,
              playedColor: OAppColors.secondary),
          aspectRatio: PlaybackRate.half,
          controller: controller,
          showVideoProgressIndicator: true,
          onReady: () {
            Oshowlog("YOtube Player", "YOtube Player Ready");
          },
          onEnded: (data) {
            Oshowlog1('Video has ended.');
          },
          topActions: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.8),
            OiconButtons(
                child: const Icon(Icons.picture_in_picture_alt),
                onTap: () {
                  const platform = MethodChannel('pip_channel');
                  platform.invokeMethod('enterPiP');
                }),
            OiconButtons(
                child: const Icon(Icons.close),
                onTap: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
