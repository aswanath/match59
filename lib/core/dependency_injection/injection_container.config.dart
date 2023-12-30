// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:match5/core/data/repository/ilocal_repository.dart' as _i4;
import 'package:match5/core/data/repository/local_repository.dart' as _i5;
import 'package:match5/core/dependency_injection/module/app_module.dart' as _i7;
import 'package:match5/src/game/presentation/bloc/game_bloc.dart' as _i6;
import 'package:shared_preferences/shared_preferences.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    await gh.factoryAsync<_i3.SharedPreferences>(
      () => appModule.prefs(),
      preResolve: true,
    );
    gh.factory<_i4.ILocalRepository>(
        () => _i5.LocalRepository(gh<_i3.SharedPreferences>()));
    gh.factory<_i6.GameBloc>(() => _i6.GameBloc(gh<_i4.ILocalRepository>()));
    return this;
  }
}

class _$AppModule extends _i7.AppModule {}
