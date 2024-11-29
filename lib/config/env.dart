import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
final class Env {
  @EnviedField(varName: 'APIKEY', obfuscate: true)
  static String apiKey = _Env.apiKey;

  @EnviedField(varName: 'APPID', obfuscate: true)
  static String appId = _Env.appId;

  @EnviedField(varName: 'MESSAGESENDERID', obfuscate: true)
  static String messageSenderId = _Env.messageSenderId;

  @EnviedField(varName: 'PROJECTID', obfuscate: true)
  static String projectId = _Env.projectId;

  @EnviedField(varName: 'STORAGEBUCKETID', obfuscate: true)
  static String storageBucketId = _Env.storageBucketId;

  @EnviedField(varName: 'FBUSER', obfuscate: true)
  static String fbUser = _Env.fbUser;

  @EnviedField(varName: 'FBENTERPRISE', obfuscate: true)
  static String fbEnterprise = _Env.fbEnterprise;

  @EnviedField(varName: 'FBCIRCLE', obfuscate: true)
  static String fbCircle = _Env.fbCircle;

  @EnviedField(varName: 'FBUSERSUBSCRIPTIONRECEIPT', obfuscate: true)
  static String fbUserSubscriptionReceipt = _Env.fbUserSubscriptionReceipt;
}
