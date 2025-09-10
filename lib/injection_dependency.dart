import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:maxbazaar/features/auth/domain/usecases/registration_usecase.dart';
import 'package:maxbazaar/features/auth/domain/usecases/sendOtp_usecase.dart';
import 'package:maxbazaar/features/auth/domain/usecases/verifyOtp_usecase.dart';
import 'core/storage/token_storage.dart';
import 'core/network/dio_client.dart';
import 'package:maxbazaar/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:maxbazaar/features/auth/data/repository/auth_repository.dart';
import 'package:maxbazaar/features/auth/domain/repository/iauth_repository.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/logout_usecase.dart';
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

  // Data sources (using the Dio inside DioClient so it has interceptor)
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
  locator.registerLazySingleton(
    () => RegistrationUsecase(locator<IAuthRepository>()),
  );
  locator.registerLazySingleton(() => LoginUseCase(locator<IAuthRepository>()));
  locator.registerLazySingleton(
    () => LogoutUseCase(locator<IAuthRepository>()),
  );
  locator.registerLazySingleton(
    () => SendotpUsecase(locator<IAuthRepository>()),
  );
  locator.registerLazySingleton(
    () => VerifyotpUsecase(locator<IAuthRepository>()),
  );

  // Bloc
  locator.registerFactory(
    () => AuthBloc(
      registrationUsecase: locator<RegistrationUsecase>(),
      loginUseCase: locator<LoginUseCase>(),
      logoutUseCase: locator<LogoutUseCase>(),
      sendotpUsecase: locator<SendotpUsecase>(),
      verifyotpUsecase: locator<VerifyotpUsecase>(),
    ),
  );
}
