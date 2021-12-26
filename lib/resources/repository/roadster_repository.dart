import 'package:flutter/material.dart';
import 'package:spacex/resources/service/api_gatway.dart';
import 'package:spacex_api/models/roadster.dart';

class RoadsterRepository {
  final ApiGateway apiGateway;

  RoadsterRepository({@required this.apiGateway}) : assert(apiGateway != null);

  Future<Roadster> fetchRoadster() {
    return apiGateway.fetchRoadster();
  }
}
