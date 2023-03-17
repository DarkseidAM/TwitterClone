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
Account account(AccountRef ref) => Account(ref.watch(clientProvider));

@riverpod
Databases database(DatabaseRef ref) => Databases(ref.watch(clientProvider));

@riverpod
Storage storage(StorageRef ref) => Storage(ref.watch(clientProvider));

@riverpod
Realtime realtime(RealtimeRef ref) => Realtime(ref.watch(clientProvider));

@riverpod
Logger logger(LoggerRef ref) => Logger(
      printer: PrettyPrinter(
        printTime: true,
      ),
    );
