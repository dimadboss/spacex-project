import 'package:flutter/material.dart';
import 'package:spacex/ui/theme/theme.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoPlayer extends StatefulWidget {
  YoutubeVideoPlayer({Key key, this.youtubeId}) : super(key: key);
  final String youtubeId;

  @override
  _YoutubePlayerState createState() => _YoutubePlayerState();
}

class _YoutubePlayerState extends State<YoutubeVideoPlayer> {
  YoutubePlayerController _controller;
  @override
  void initState() {
    if (widget.youtubeId != null) {
      _controller = YoutubePlayerController(
        initialVideoId: widget.youtubeId,
        flags: YoutubePlayerFlags(
          autoPlay: false,
          loop: false,
          mute: true,
        ),
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return widget.youtubeId != null
        ? AspectRatio(
            aspectRatio: 16 / 9,
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressColors: ProgressBarColors(
                playedColor: theme.primaryColor,
                handleColor: theme.primaryColorLight,
              ),
            ),
          )
        : Container(
            width: AppTheme.fullWidth(context),
            height: 200,
            color: theme.colorScheme.primary.withOpacity(.3),
            child: Center(
              child: Text(
                "No Video Available".toUpperCase(),
                style: theme.textTheme.subtitle1.copyWith(fontSize: 14)
              ),
            ),
          );
  }
}
