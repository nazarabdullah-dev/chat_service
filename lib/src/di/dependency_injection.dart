import 'package:chat_service/src/data/repository/impl/login_repository_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:chat_service/src/data/repository/login_repository.dart';
import 'package:chat_service/src/data/repository/message_repository.dart';
import 'package:chat_service/src/data/repository/impl/message_repository_impl.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  // Firebase

  // Repositories
  getIt.registerLazySingleton<MessageRepository>(() => MessageRepositoryImpl());
  getIt.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl());
}
