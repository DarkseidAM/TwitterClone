import 'package:appwrite/appwrite.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twitter_clone/core/utils/constants.dart';

final Provider<Client> clientProvider =
    Provider<Client>((ProviderRef<Client> ref) {
  return Client()
    ..setEndpoint(AppWriteConstants.endPoint)
    ..setProject(AppWriteConstants.projectId)
    ..setSelfSigned();
});

final Provider<Account> accountProvider =
    Provider<Account>((ProviderRef<Account> ref) {
  final Client client = ref.watch(clientProvider);
  return Account(client);
});

final Provider<Databases> databasesProvider =
    Provider<Databases>((ProviderRef<Databases> ref) {
  final Client client = ref.watch(clientProvider);
  return Databases(client);
});

final Provider<Storage> storageProvider =
    Provider<Storage>((ProviderRef<Storage> ref) {
  final Client client = ref.watch(clientProvider);
  return Storage(client);
});

final Provider<Realtime> realtimeProvider =
    Provider<Realtime>((ProviderRef<Realtime> ref) {
  final Client client = ref.watch(clientProvider);
  return Realtime(client);
});

final Provider<Logger> loggerProvider =
    Provider<Logger>((ProviderRef<Logger> ref) => Logger(
          printer: PrettyPrinter(
            printTime: true,
          ),
        ));
