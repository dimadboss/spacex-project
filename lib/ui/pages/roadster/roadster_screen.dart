import 'package:flutter/material.dart';
import 'package:spacex/ui/pages/launch/widgets/youtube_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:spacex/ui/theme/extentions.dart';
import 'package:spacex/ui/widgets/title_text.dart';
import 'package:spacex_api/models/roadster.dart';

class RoadsterScreen extends StatelessWidget {
  final Roadster model;

  const RoadsterScreen({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(model.video);
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            YoutubeVideoPlayer(youtubeId: model.video.replaceFirst("https://youtu.be/", "")),
            TitleText(model.name, fontSize: 20).vP8,
            TitleText(
              model.details,
              fontSize: 14,
              textAlign: TextAlign.justify,
              fontWeight: FontWeight.w400,
            ).pO(bottom: 8, left: 8, right: 8),
            Divider(),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: OutlinedButton(
                onPressed: () {
                  launch(model.wikipedia);
                },
                child: TitleText("Wiki", fontSize: 16),
              ),
            ),
            Divider(),
            _RodsterListTile(title: "Distance", value: model.earthDistanceKm.toStringAsFixed(2)),
            _RodsterListTile(title: "Weight", value: model.launchMassKg.toStringAsFixed(2)),
            _RodsterListTile(title: "Orbit type", value: model.orbitType.toString()),
            _RodsterListTile(title: "Epoch", value: model.epochJd.toStringAsFixed(2)),
            _RodsterListTile(title: "ApoapsisAu", value: model.apoapsisAu.toStringAsFixed(2)),
            _RodsterListTile(title: "Periapsis Arg", value: model.periapsisArg.toStringAsFixed(2)),
            _RodsterListTile(title: "periapsis Au", value: model.periapsisAu.toStringAsFixed(2)),
            _RodsterListTile(title: "Semimajor Axis Au", value: model.semiMajorAxisAu.toStringAsFixed(2)),
            _RodsterListTile(title: "Eccentricity", value: model.eccentricity.toStringAsFixed(2)),
            _RodsterListTile(title: "Inclination", value: model.inclination.toStringAsFixed(2)),
            _RodsterListTile(title: "Longitude", value: model.longitude.toStringAsFixed(2)),
            _RodsterListTile(title: "Period Days", value: model.periodDays.toStringAsFixed(2)),
            _RodsterListTile(title: "Speed Kmph", value: model.speedKph.toStringAsFixed(2)),
            _RodsterListTile(title: "Speed Mph", value: model.speedMph.toStringAsFixed(2)),
            _RodsterListTile(title: "Earth Distance (Km)", value: model.earthDistanceKm.toStringAsFixed(2)),
            _RodsterListTile(title: "Earth Distance (Mi)", value: model.earthDistanceMi.toStringAsFixed(2)),
            _RodsterListTile(title: "Mars Distance (Km)", value: model.marsDistanceKm.toStringAsFixed(2)),
            _RodsterListTile(title: "Mars Distance (Mi)", value: model.marsDistanceMi.toStringAsFixed(2)),
          ],
        ),
      ),
    );
  }
}

class _RodsterListTile extends StatelessWidget {
  final String title, value;

  const _RodsterListTile({Key key, this.title, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TitleText(title, fontSize: 16, fontWeight: FontWeight.w400),
              TitleText(value, fontSize: 14, fontWeight: FontWeight.w400),
            ],
          ),
          SizedBox(height: 12),
          Divider(height: 0),
        ],
      ),
    );
  }
}
