import 'package:flutter/material.dart';
import 'package:spacex/resources/service/api_gatway.dart';
import 'package:spacex_api/models/rocket/rocket.dart';

class RocketRepository extends ChangeNotifier {
  final ApiGateway apiGateway;
  final List<Rocket> items = [];

  RocketRepository({@required this.apiGateway}) : assert(apiGateway != null);

  Future<List<Rocket>> fetchAllRocket() async {
    final result = await apiGateway.fetchAllRocket();
    items.clear();
    items.addAll(result);
    return result;
  }

  Future<Rocket> fetchRocketById(String id) async {
    final element = items.firstWhere((element) => element.id == id, orElse: () => null);
    if (element != null) {
      return Future.value(element);
    } else {
      final result = await apiGateway.fetchRocketById(id);
      items.add(result);
      return Future.value(result);
    }
  }
}
