import 'package:spacex/resources/repository/launch_repository.dart';
import 'package:spacex/resources/service/api_gatway.dart';
import 'package:spacex/resources/service/api_gatway_impl.dart';
import 'package:get_it/get_it.dart';

void setUpDependency() {
  final serviceLocator = GetIt.instance;

  serviceLocator.registerLazySingleton<ApiGateway>(() => ApiGatewayImpl());

  GetIt.instance.registerSingleton<LaunchRepository>(LaunchRepository(apiGateway: GetIt.instance<ApiGateway>()));
}
