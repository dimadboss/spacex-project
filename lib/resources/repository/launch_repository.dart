import 'package:flutter/material.dart';
import 'package:spacex/resources/service/api_gatway.dart';
import 'package:spacex_api/models/launch/launch.dart';

const itemsPerPage = 5;
class LaunchRepository extends ChangeNotifier {
  final ApiGateway apiGateway;
  final List<Launch> upcomingItems = [];

  final List<Launch> pastItems = [];
  var downloadedAll = false;

  LaunchRepository({
    @required this.apiGateway
  }) : assert( apiGateway != null);

 /* Future<List<Launch>> fetchAllLaunch(){
      return apiGateway.fetchAllLaunch();
  }*/

  Future<void> fetchAllUpcomingLaunch() async {
    var result = await apiGateway.fetchAllUpcomingLaunch();
    upcomingItems.clear();
    upcomingItems.addAll(result);
    notifyListeners();
  }

  Future<void> fetchPagePastLaunch() async {
    var result = await apiGateway.fetchPagePastLaunch(offset: pastItems.length, limit: itemsPerPage);
    if (result?.length == 0) {
      downloadedAll = true;
    }
    pastItems.addAll(result);
    notifyListeners();
  }

}
