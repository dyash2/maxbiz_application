import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'core/storage/token_storage.dart';
import 'core/network/dio_client.dart';
import 'package:maxbiz_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:maxbiz_app/features/auth/data/repository/auth_repository.dart';
import 'package:maxbiz_app/features/auth/domain/repository/iauth_repository.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/logout_usecase.dart';
import 'features/auth/domain/usecases/refresh_token_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

final locator = GetIt.instance;

Future<void> setup() async {
  // External
  locator.registerLazySingleton<Dio>(() => Dio());

  // Storage
  locator.registerLazySingleton<TokenStorage>(() => SharedPrefsTokenStorage());

  // Network
  locator.registerLazySingleton<DioClient>(
    () => DioClient(locator<Dio>(), locator<TokenStorage>()),
  );

  // Data sources (use the Dio inside DioClient so it has interceptor)
  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(locator<DioClient>().dio),
  );

  // Repository
  locator.registerLazySingleton<IAuthRepository>(
    () => AuthRepositoryImpl(
      remote: locator<AuthRemoteDataSource>(),
      storage: locator<TokenStorage>(),
    ),
  );

  // Use cases
  locator.registerLazySingleton(() => LoginUseCase(locator<IAuthRepository>()));
  locator.registerLazySingleton(() => RefreshTokenUsecase(locator<IAuthRepository>()));
  locator.registerLazySingleton(() => LogoutUseCase(locator<IAuthRepository>()));

  // Bloc
  locator.registerFactory(
    () => AuthBloc(
      loginUseCase: locator<LoginUseCase>(),
      logoutUseCase: locator<LogoutUseCase>(),
    ),
  );
}
