import 'package:app_base_flutter/configs/global_constants.dart';
import 'package:app_base_flutter/configs/storages/base_prefs.dart';

class AppPrefStorage extends BasePrefsStorage {
  static Future<AppPrefStorage> instance() async {
    final _appPref = AppPrefStorage();
    await _appPref.init();
    return _appPref;
  }

  Future<void> saveActionsAcceptPolicyUseApp({required bool isAccept}) async {
    await setValueForKey(GlobalConstants.isAcceptPolicy, isAccept);
  }

  Future<bool> hasLoggedIn() async {
    return false;
  }

  Future<String> getToken() async {
    await getValueForKey(GlobalConstants.TokenUserLogin);
    return 'USER_TOKEN:Whsjdhasdioueindajskdsa';
  }

  Future<void> saveSkipOnboard({required bool isSkip}) async {
    await setValueForKey(GlobalConstants.kSkipOnboard, isSkip);
  }

  Future<String?> getLanguage() async {
    final _language = this.getValueForKey<String?>(GlobalConstants.kLanguage);
    return _language;
  }

  Future<void> savelanguage({required String languageCode}) async {
    await this.setValueForKey(GlobalConstants.kLanguage, languageCode);
  }

}
