class AppWriteConstants {
  AppWriteConstants._();
  static const String databaseId = '6412bee2dcdab9913240';
  static const String projectId = '6412a24513d51396ace7';
  static const String endPoint = 'http://127.0.0.1:80/v1';

  static const String usersCollection = '6417d45c5aaba9ac540b';
  static const String tweetsCollection = '641d64a00caa2431fcba';

  static const String imagesBucket = '641d8930080f1db07d78';

  static String imageUrl(String imageId) =>
      '$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
}
