import 'package:flutter/material.dart';
import 'package:spacex/helper/utils.dart';

import 'package:spacex/ui/widgets/custom_heading_tile.dart';
import 'package:spacex/ui/widgets/custom_list_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:spacex/ui/theme/extentions.dart';
import 'package:spacex/ui/pages/launch/widgets/youtube_player.dart';
import 'package:spacex/ui/widgets/title_text.dart';
import 'package:spacex_api/models/launch/launch.dart';
import 'package:spacex_api/models/rocket/rocket.dart';

class LaunchDetail extends StatefulWidget {
  const LaunchDetail({Key key, this.model, this.rocket}) : super(key: key);
  final Launch model;
  final Rocket rocket;

  @override
  State<LaunchDetail> createState() => _LaunchDetailState();
}

class _LaunchDetailState extends State<LaunchDetail> {
  Widget _links(
    String title,
    String value,
    int from,
    int to,
  ) {
    String url = value;
    if (value != null) {
      value = value.substring(from, to);
    } else {
      value = "N/A";
    }
    return SListTile(title, value, onPressed: () {
      canLaunch(url).then((yes) {
        if (yes) {
          launch(url);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  title: Title(
                    color: theme.backgroundColor,
                    child: Text(widget.model.name),
                    title: widget.model.name,
                  ),
                  floating: true,
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      YoutubeVideoPlayer(
                        youtubeId: widget.model?.links?.youtubeId,
                      ),

                      SizedBox(height: widget.model.details == null ? 0 : 16),
                      widget.model.details == null
                          ? SizedBox.shrink()
                          : ListTile(
                              title: TitleText("Description", fontSize: 15),
                              subtitle: TitleText(
                                widget.model.details ?? "",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                textAlign: TextAlign.justify,
                              ).vP8,
                            ),
                      // SizedBox(height: model.details == null ? 0 : 16),
                      Divider(height: 0),
                      SListTile("Flight no", "#${widget.model.flightNumber}"),
                      Divider(height: 0),
                      SListTile(
                        "Launch date",
                        Utils.humanDateTime(widget.model.dateLocal),
                      ),
                      Divider(height: 0),
                      SListTile(
                        "Success",
                        widget.model.success == null
                            ? "N/A"
                            : widget.model.success
                                ? "Yes"
                                : "False",
                      ),
                      Divider(height: 0),
                      // SListTile("Location", model.launchSite.siteName),
                      Divider(height: 0),
                      //  SListTile("Rocket", model.rocket.rocketName),
                      Divider(height: 0),

                      /// Core
                      SHeadingTile("Core #1"),
                      SListTile("Serial", widget.model.cores[0].core
                          //widget.rocket.firstStage.cores.first.coreSerial,
                          ),
                      Divider(height: 0),
                      SListTile("Flight number", "#${widget.model.cores[0].flight}"),
                      Divider(height: 0),
                      SListTile(
                        "Reused",
                        widget.model.cores[0].reused == null
                            ? "N/A"
                            : widget.model.cores[0].reused
                                ? "Yes"
                                : "No",
                      ),
                      Divider(height: 0),
                      SListTile(
                        "Landing type",
                        widget.model.cores[0].landingType,
                      ),
                      Divider(height: 0),
                      SListTile(
                        "Landing Attempt",
                        widget.model.cores[0].landingAttempt == null
                            ? "N/A"
                            : widget.model.cores[0].landingAttempt
                                ? "Yes"
                                : "No",
                      ),
                      Divider(height: 0),
                      SListTile(
                        "Landing Sucess",
                        widget.model.cores[0].landingSuccess == null
                            ? "N/A"
                            : widget.model.cores[0].landingSuccess
                                ? "Yes"
                                : "No",
                      ),

                      /// Payload
                      /* SHeadingTile(
                        "Payload: ${widget.rocket.secondStage.payloads.compositeFairing model.rocket.secondStage.payloads.first.payloadId}",
                      ),
                      SListTile(
                        "Customers",
                        model.rocket.secondStage.payloads.first.customers.first,
                      ),
                      Divider(height: 0),
                      SListTile(
                        "Nationality",
                        model.rocket.secondStage.payloads.first.nationality,
                      ),
                      Divider(height: 0),
                      SListTile(
                        "Manufacturer",
                        model.rocket.secondStage.payloads.first.manufacturer,
                      ),
                      Divider(height: 0),
                      SListTile(
                        "Mass",
                        model.rocket.secondStage.payloads.first.payloadMassKg ==
                                null
                            ? "N/A"
                            : model.rocket.secondStage.payloads.first
                                    .payloadMassKg
                                    .toString() +
                                " Kg",
                      ),
                      Divider(height: 0),
                      SListTile(
                        "Orbit",
                        model.rocket.secondStage.payloads.first.orbit,
                      ),
                      Divider(height: 0),*/

                      /// Link
                      SHeadingTile("Links"),
                      // _links("Mission patch", model.links.missionPatch, 0, 26),
                      Divider(height: 0),
                      _links("Reddit campaign", widget.model.links.reddit.campaign, 8, 22),
                      Divider(height: 0),
                      _links("Reddit launch", widget.model.links.reddit.launch, 8, 22),
                      Divider(height: 0),
                      _links("Reddit recovery", widget.model.links.reddit.recovery, 8, 22),
                      Divider(height: 0),
                      _links("Reddit media", widget.model.links.reddit.media, 8, 22),
                      Divider(height: 0),
                      // _links("Article link", model.links.reddit., 0, 26),
                      Divider(height: 0),
                      _links("Wikipedia", widget.model.links.wikipedia, 0, 24),
                      Divider(height: 0),
                    ],
                    addAutomaticKeepAlives: true,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
