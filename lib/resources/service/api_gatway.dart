import 'package:spacex_api/models/crew.dart';
import 'package:spacex_api/models/dragon/dragon.dart';

import 'package:spacex_api/models/launch/launch.dart';
import 'package:spacex_api/models/roadster.dart';
import 'package:spacex_api/models/rocket/rocket.dart';

abstract class ApiGateway {
  Future<List<Launch>> fetchAllUpcomingLaunch();

  Future<List<Launch>> fetchPagePastLaunch({int offset, int limit});

  Future<Roadster> fetchRoadster();

  Future<List<Rocket>> fetchAllRocket();

  Future<Rocket> fetchRocketById(String id);

  Future<List<Dragon>> fetchAllDragon();

  Future<List<Crew>> fetchAllCrews();
}
