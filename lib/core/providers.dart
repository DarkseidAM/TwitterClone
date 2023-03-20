import 'package:appwrite/appwrite.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:twitter_clone/core/utils/constants.dart';

part 'providers.g.dart';

@riverpod
Client client(ClientRef ref) => Client()
  ..setEndpoint(AppWriteConstants.endPoint)
  ..setProject(AppWriteConstants.projectId)
  ..setSelfSigned();

@riverpod
Account account(AccountRef ref) {
  final Client client = ref.watch(clientProvider);
  return Account(client);
}

@riverpod
Databases databases(DatabasesRef ref) {
  final Client client = ref.watch(clientProvider);
  return Databases(client);
}

@riverpod
Storage storage(StorageRef ref) {
  final Client client = ref.watch(clientProvider);
  return Storage(client);
}

@riverpod
Realtime realtime(RealtimeRef ref) {
  final Client client = ref.watch(clientProvider);
  return Realtime(client);
}

@riverpod
Logger logger(LoggerRef ref) => Logger(
      printer: PrettyPrinter(
        printTime: true,
      ),
    );
