import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:spacex/ui/pages/rockets/rocket_detail.dart';
import 'package:spacex/ui/theme/extentions.dart';
import 'package:spacex/ui/widgets/customWidgets.dart';
import 'package:spacex/ui/widgets/list_card.dart';
import 'package:spacex/ui/widgets/title_text.dart';
import 'package:spacex/ui/widgets/title_value.dart';
import 'package:spacex_api/models/rocket/rocket.dart';

class RocketScreen extends StatelessWidget {
  final List<Rocket> rockets;
  final cache = {};

  RocketScreen({Key key, this.rockets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.77;
    return Column(
      children: [
        CarouselSlider(
          items: rockets.map((rocket) {
            return Builder(
              builder: (BuildContext context) {
                if (!cache.containsKey(rocket.flickrImages.first)) {
                  cache[rocket.flickrImages.first] =
                      customNetworkImage(rocket.flickrImages.first, fit: BoxFit.fitWidth);
                }
                return Column(
                  children: [
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => RocketDetail(model: rocket)));
                      },
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
                        child: cache[rocket.flickrImages.first],
                      ),
                    ),
                    Spacer(),
                    RocketCard(model: rocket),
                  ],
                );
              },
            );
          }).toList(),
          options: CarouselOptions(height: height, autoPlay: true, viewportFraction: 0.95),
        ),
      ],
    );
  }
}

class RocketCard extends StatelessWidget {
  final Rocket model;

  const RocketCard({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListCard(
      hideImage: true,
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => RocketDetail(model: model)));
      },
      bodyContent: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TitleText(model.name, fontSize: 14),
          TitleValue(
            title: "Layout:",
            value: model.engines.layout ?? 'N/A',
          ),
          TitleValue(
            title: "First flight date:",
            value: model.firstFlight ?? 'N/A',
          ),
         TitleValue(
            title: "Success rate",
            value: "${model.successRatePct ?? 'N/A'} %",
          ),
        ],
      ).hP4,
    );
  }
}
