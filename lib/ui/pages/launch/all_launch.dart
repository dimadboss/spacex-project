import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/bloc/launches/bloc.dart';

import 'package:spacex/helper/app_font.dart';
import 'package:spacex/helper/utils.dart';
import 'package:spacex/resources/repository/launch_repository.dart';
import 'package:spacex/resources/repository/rocket_repository.dart';
import 'package:spacex/ui/pages/common/no_connection.dart';
import 'package:spacex/ui/pages/common/no_content.dart';
import 'package:spacex/ui/pages/launch/launch_detail.dart';
import 'package:spacex/ui/widgets/list_card.dart';
import 'package:spacex/ui/widgets/title_text.dart';
import 'package:spacex/ui/widgets/title_value.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:spacex_api/models/launch/launch.dart' as launch;
import 'package:spacex_api/models/rocket/rocket.dart';

class AllLaunch extends StatefulWidget {
  AllLaunch({Key key}) : super(key: key);

  @override
  _AllLaunchState createState() => _AllLaunchState();
}

class _AllLaunchState extends State<AllLaunch> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: Column(
        children: <Widget>[
          Card(
            elevation: 3,
            margin: EdgeInsets.all(0),
            child: TabBar(
              labelStyle: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              controller: _tabController,
              tabs: <Widget>[
                Text("Upcomming"),
                Text("Past"),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<LaunchBloc, LaunchState>(
              builder: (context, state) {
                if (state is Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LoadedState) {
                  if (state.allLaunch == null) return NoContent();

                  return TabBarView(
                    controller: _tabController,
                    children: [
                      LaunchList(
                        key: Key('upcomingLaunchKey'),
                        past: false,
                        /*list: state.allLaunch
                            .where((element) => element.upcoming)
                            .toList(),*/
                      ),
                      LaunchList(
                        key: Key('pastLaunchKey'),
                        past: true,
                        /*list: state.allLaunch
                            .where((element) => !element.upcoming)
                            .toList(),*/
                      )
                    ],
                  );
                } else if (state is NoConnectionDragonState) {
                  return NoInternetConnection(
                    message: state.errorMessage,
                    onReload: () {
                      BlocProvider.of<LaunchBloc>(context).add(LaunchInitial());
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LaunchList extends StatefulWidget {
  final bool past;

  const LaunchList({Key key, this.past}) : super(key: key);

  @override
  _LaunchListState createState() => _LaunchListState();
}

class _LaunchListState extends State<LaunchList> {
  LaunchRepository launchRepository;

  @override
  void initState() {
    super.initState();
    launchRepository = Provider.of<LaunchRepository>(context, listen: false);
    if (widget.past) {
      if (launchRepository?.pastItems?.isNotEmpty != true) {
        launchRepository.fetchPagePastLaunch();
      }
    } else {
      if (launchRepository?.upcomingItems?.isNotEmpty != true) {
        launchRepository.fetchAllUpcomingLaunch();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.past ? paginatedPast() : allUpcoming();
  }

  Widget allUpcoming() {
    return Consumer<LaunchRepository>(builder: (context, launchRepository, child) {
      return ListView.builder(
        itemCount: launchRepository.upcomingItems.length,
        itemBuilder: (context, index) => LaunchCard(
          model: launchRepository.upcomingItems[index],
        ),
      );
    });
  }

  Widget paginatedPast() {
    return Consumer<LaunchRepository>(
      builder: (context, launchRepository, child) {
        return ListView.builder(
          itemCount: launchRepository.pastItems.length,
          itemBuilder: (context, index) {
            final _model = launchRepository.pastItems[index];
            final isLast = launchRepository.pastItems.last == _model;
            final isEmpty = launchRepository.pastItems.isEmpty == true;
            if (!launchRepository.downloadedAll && (isLast || isEmpty)) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                launchRepository.fetchPagePastLaunch();
              });
            }
            return LaunchCard(
              model: launchRepository.pastItems[index],
            );
          },
        );
      },
    );
  }
}

class LaunchCard extends StatefulWidget {
  final launch.Launch model;

  const LaunchCard({Key key, this.model}) : super(key: key);

  @override
  State<LaunchCard> createState() => _LaunchCardState();
}

class _LaunchCardState extends State<LaunchCard> {
  Rocket rocket;
  RocketRepository rocketRepository;
  bool loading = false;

  Widget _row(IconData icon, String value, ThemeData theme) {
    if (value == null) {
      value = "N/A";
    }
    return Row(
      children: <Widget>[
        Icon(icon, size: 15, color: theme.colorScheme.onSurface.withOpacity(.8)),
        SizedBox(width: 10),
        Text(
          value,
          style: TextStyle(color: theme.colorScheme.onSurface),
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }

  void loadRocket(rocketId) async {
    setState(() {
      loading = true;
    });
    rocket = await rocketRepository.fetchRocketById(rocketId);
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    rocketRepository = Provider.of<RocketRepository>(context, listen: false);
    loadRocket(widget.model.rocket);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListCard(
      imagePath: widget.model.links?.patch?.small,
      imagePadding: EdgeInsets.all(10),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LaunchDetail(
              model: widget.model,
              rocket: rocket,
            ),
          ),
        );
      },
      bodyContent: loading
          ? CupertinoActivityIndicator()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TitleText(widget.model.name, fontSize: 14),
                TitleValue(title: "Flight no:", value: widget.model.flightNumber.toString()),
                _row(Icons.calendar_today, "${Utils.humanDateTime(widget.model.dateLocal)}", theme),
                _row(AppFont.rocket2, rocket.name, theme),
                //_row(Icons.location_on, model.launchSite.siteName, theme),
              ],
            ),
    );
  }
}
