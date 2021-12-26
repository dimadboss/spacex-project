import 'package:flutter/foundation.dart';
import 'package:spacex/resources/service/api_gatway.dart';
import 'package:spacex_api/models/dragon/dragon.dart';

class DragonRepository {
  final ApiGateway apiGateway;

  DragonRepository({@required this.apiGateway}) : assert(apiGateway != null);

  Future<List<Dragon>> fetchAllDragon() {
    return apiGateway.fetchAllDragon();
  }
}
