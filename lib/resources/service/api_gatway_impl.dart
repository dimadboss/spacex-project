import 'package:spacex/resources/service/api_gatway.dart';
import 'package:spacex_api/models/crew.dart';
import 'dart:convert' as convert;
import 'package:spacex_api/models/dragon/dragon.dart';
import 'package:spacex_api/models/pagenated_response.dart';
import 'package:spacex_api/models/launch/launch.dart';
import 'package:spacex_api/models/roadster.dart';
import 'package:spacex_api/models/rocket/rocket.dart';
import 'package:spacex_api/models/query/options.dart' as options;
import 'package:spacex_api/utils.dart' as utils;
import 'package:spacex_api/spacex_api.dart';

class ApiGatewayImpl implements ApiGateway {
  final api = SpaceXApi();

  ApiGatewayImpl();

  @override
  Future<List<Launch>> fetchAllUpcomingLaunch() async {
    try {
      final response = await api.getAllUpcomingLaunches();
      if (response.statusCode == 200) {
        List<Launch> data = utils.Utils.convertResponseToList<Launch>(response, (e) => Launch.fromJson(e));
        print("fetchAllUpcomingLaunch: ${data.length}");
        return data;
      } else {
        print("statusCode != 200 while fetchAllUpcomingLaunch");
      }
    } catch (error) {
      print("Error while fetchAllUpcomingLaunch");
    }
    return [];
  }

  @override
  Future<List<Launch>> fetchPagePastLaunch({int offset, int limit}) async {
    final query = options.Options();
    query.limit = limit;
    query.offset = offset;
    query.pagination = true;
    query.upcoming = false;
    var queryJson = convert.jsonEncode(query.toJson());
    try {
      final response = await api.queryLaunches(query: queryJson);
      if (response.statusCode == 200) {
        final jsonResp = utils.Utils.parseResponseAsJson(response);
        PagenatedResponse pagenatedResponse = PagenatedResponse.fromJson(jsonResp);
        List<Launch> data = pagenatedResponse.docs.map((e) => Launch.fromJson(e)).cast<Launch>().toList();
        print("fetchPagePastLaunch: ${data.length}");
        return data;
      } else {
        print("statusCode != 200 while fetchPagePastLaunch");
      }
    } catch (error) {
      print("Error while fetchPagePastLaunch");
    }
    return [];
  }

  @override
  Future<Roadster> fetchRoadster() async {
    try {
      final response = await api.getRoadster();
      if (response.statusCode == 200) {
        final roadsterJson = utils.Utils.parseResponseAsJson(response);
        print("fetchRoadster: OK");
        return Roadster.fromJson(roadsterJson);
      } else {
        print("statusCode != 200 while fetchRoadster");
      }
    } catch (error) {
      print("Error while fetchRoadster");
    }
    return null;
  }

  @override
  Future<List<Rocket>> fetchAllRocket() async {
    try {
      final response = await api.getAllRockets();
      if (response.statusCode == 200) {
        List<Rocket> data = utils.Utils.convertResponseToList<Rocket>(response, (e) => Rocket.fromJson(e));
        print("fetchAllRocket ${data.length}");
        return data;
      } else {
        print("statusCode != 200 while fetchAllRocket");
      }
    } catch (error) {
      print("Error while fetchAllRocket");
    }
    return [];
  }

  @override
  Future<Rocket> fetchRocketById(String id) async {
    try {
      final response = await api.getRocketById(id: id);
      if (response.statusCode == 200) {
        final rocketJson = utils.Utils.parseResponseAsJson(response);
        print("fetchRocketById OK");
        return Rocket.fromJson(rocketJson);
      } else {
        print("statusCode != 200 while fetchRocketById");
      }
    } catch (error) {
      print("Error while fetchRocketById");
    }
    return null;
  }

  @override
  Future<List<Dragon>> fetchAllDragon() async {
    try {
      final response = await api.getAllDragons();
      if (response.statusCode == 200) {
        List<Dragon> data = utils.Utils.convertResponseToList<Dragon>(response, (e) => Dragon.fromJson(e));
        print("fetchAllDragon: ${data.length}");
        return data;
      } else {
        print("statusCode != 200 while fetchAllDragon");
      }
    } catch (error) {
      print("Error while fetchAllDragon");
    }
    return [];
  }

  @override
  Future<List<Crew>> fetchAllCrews() async {
    try {
      final response = await api.getAllCrews();
      if (response.statusCode == 200) {
        final data = utils.Utils.convertResponseToList<Crew>(response, (e) => Crew.fromJson(e));
        print("fetchAllCrews: ${data.length}");
        return data;
      } else {
        print("statusCode != 200 while fetchAllCrews");
      }
    } catch (error) {
      print("Error while fetchAllCrews");
    }
    return [];
  }
}
