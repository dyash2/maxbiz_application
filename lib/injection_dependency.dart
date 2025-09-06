import 'package:get_it/get_it.dart';
import 'package:maxbiz_app/core/network/api_client.dart';
import 'package:maxbiz_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:maxbiz_app/features/auth/data/repository/auth_repository.dart';
import 'package:maxbiz_app/features/auth/domain/repository/auth_repository.dart';

final locator = GetIt.instance;

void setup() {
  // Register DataSource
  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(),
  );

  // Register Dio
  locator.registerSingleton(ApiClient());

  // Register Repository
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(locator<AuthRemoteDataSource>()),
  );
}
