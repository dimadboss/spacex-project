import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:spacex/ui/theme/extentions.dart';
import 'package:spacex/ui/widgets/customWidgets.dart';
import 'package:spacex/ui/widgets/list_card.dart';
import 'package:spacex/ui/widgets/title_value.dart';
import 'package:spacex_api/models/crew.dart';
import 'package:url_launcher/url_launcher.dart';

class CrewScreen extends StatefulWidget {
  final List<Crew> list;

  const CrewScreen({Key key, this.list}) : super(key: key);

  @override
  _CrewScreenState createState() => _CrewScreenState();
}

class _CrewScreenState extends State<CrewScreen> {
  final cache = {};

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.77;
    return CarouselSlider(
      items: widget.list.map((crew) {
        return Builder(
          builder: (BuildContext context) {
            if (!cache.containsKey(crew.image)) {
              cache[crew.image] = customNetworkImage(crew.image, fit: BoxFit.fitWidth);
            }
            return Column(
              children: [
                Spacer(),
                InkWell(
                  onTap: () => launch(crew.wikipedia),
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
                    child: cache[crew.image],
                  ),
                ),
                Spacer(),
                CrewCard(model: crew),
              ],
            );
          },
        );
      }).toList(),
      options: CarouselOptions(height: height, autoPlay: true),
    );
  }
}

class CrewCard extends StatelessWidget {
  final Crew model;

  const CrewCard({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListCard(
      hideImage: true,
      imagePadding: const EdgeInsets.all(5),
      bodyContent: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TitleValue(title: "Name:", value: model.name),
            TitleValue(title: "Agency:", value: model.agency),
            TitleValue(title: "Status:", value: model.status),
          ],
        ).hP4,
      ),
      onPressed: () => launch(model.wikipedia),
    );
  }
}
