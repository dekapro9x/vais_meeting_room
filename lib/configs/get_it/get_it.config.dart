import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:app_base_flutter/configs/storages/app_prefs.dart' as _i4;
import 'get_it.dart' as _i6;
import 'package:app_base_flutter/repositories/data_repository.dart' as _i5;

Future<_i1.GetIt> $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final appModule = _$AppModule();
  await gh.factoryAsync<_i4.AppPrefStorage>(
    () => appModule.appPrefs,
    preResolve: true,
  );
  gh.lazySingleton<_i5.DataRepository>(() => _i5.DataRepository());
  return getIt;
}
class _$AppModule extends _i6.AppModule {}