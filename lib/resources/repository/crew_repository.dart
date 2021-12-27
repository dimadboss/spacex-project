import 'package:flutter/foundation.dart';
import 'package:spacex/resources/service/api_gatway.dart';
import 'package:spacex_api/models/crew.dart';

const itemsPerPage = 5;

class CrewRepository extends ChangeNotifier {
  final ApiGateway apiGateway;
  final List<Crew> items = [];
  var downloadedAll = false;

  CrewRepository({@required this.apiGateway}) : assert(apiGateway != null);

  Future<List<Crew>> fetchAllCrews() async {
    final result = await apiGateway.fetchAllCrews();
    notifyListeners();
    return result;
  }
}
