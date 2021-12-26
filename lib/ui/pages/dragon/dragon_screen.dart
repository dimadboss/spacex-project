import 'package:flutter/material.dart';
import 'package:spacex/ui/pages/dragon/dragon_detail.dart';
import 'package:spacex/ui/widgets/list_card.dart';
import 'package:spacex/ui/widgets/title_text.dart';
import 'package:spacex/ui/widgets/title_value.dart';
import 'package:spacex_api/models/dragon/dragon.dart';

class DragonScreen extends StatelessWidget {
  final List<Dragon> dragonList;

  const DragonScreen({Key key, this.dragonList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dragonList.length,
      itemBuilder: (context, index) => DragonCard(
        model: dragonList[index],
      ),
    );
  }
}

class DragonCard extends StatelessWidget {
  final Dragon model;

  const DragonCard({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListCard(
      imagePath: model.flickrImages?.first,
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => DragonDetail(model: model)));
      },
      bodyContent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          TitleText(model.name, fontSize: 14),
          TitleValue(
            title: "First flight date:",
            value: model.firstFlight,
          ),
          TitleValue(
            title: "Type:",
            value: model.type,
          ),
        ],
      ),
    );
  }
}
