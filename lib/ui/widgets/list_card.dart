import 'package:flutter/material.dart';
import 'package:spacex/ui/widgets/customWidgets.dart';
import 'package:spacex/ui/theme/extentions.dart';

class ListCard extends StatelessWidget {
  const ListCard({
    Key key,
    this.bodyContent,
    this.imagePath,
    this.hideImage = false,
    this.imagePadding = const EdgeInsets.all(0),
    this.onPressed,
    this.isCircle = false,
  }) : super(key: key);
  final Widget bodyContent;
  final String imagePath;
  final bool hideImage;
  final Function onPressed;
  final EdgeInsetsGeometry imagePadding;
  final bool isCircle;

  Widget _image(context) {
    if (imagePath == null) {
      return _noImage(context);
    }
    return Padding(
      padding: imagePadding,
      child: isCircle
          ? CircleAvatar(
              radius: 8,
              backgroundImage: NetworkImage(imagePath),
              backgroundColor: Theme.of(context).colorScheme.background.withAlpha(180),
            )
          : ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                topLeft: Radius.circular(8),
              ),
              child: customNetworkImage(
                imagePath,
                fit: BoxFit.cover,
                placeholder: _noImage(context),
              ),
            ),
    );
  }

  Widget _noImage(context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(8),
        topLeft: Radius.circular(8),
      ),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Stack(
          children: <Widget>[
            Image.asset(
              "assets/rocket_lauch.png",
              height: 100,
            ),
            CircleAvatar(
              radius: 50,
              backgroundColor: theme.colorScheme.background.withAlpha(180),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: theme.cardColor.withOpacity(.4),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      height: 128,
      child: Row(
        children: <Widget>[
          if (!hideImage)
            AspectRatio(
              aspectRatio: 1,
              child: _image(context),
            ),
          if (!hideImage) SizedBox(width: 16),
          Expanded(flex: 3, child: bodyContent)
        ],
      ).ripple(onPressed, borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }
}
