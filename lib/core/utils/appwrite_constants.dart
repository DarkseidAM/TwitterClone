class AppWriteConstants {
  AppWriteConstants._();
  static const String databaseId = '64a703b51602a4a3dbbf';
  static const String projectId = '64a6fecc809941e49953';
  static const String endPoint = 'http://192.168.1.4/v1';

  static const String usersCollection = '64a712839855aad07bd5';
  static const String tweetsCollection = '64a71634d22f1a05c273';

  static const String imagesBucket = '64a71971a86bb3445e85';

  static String imageUrl(String imageId) =>
      '$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
}
