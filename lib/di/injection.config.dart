// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:busha_app/core/network/dio_helper.dart' as _i884;
import 'package:busha_app/data/services/block_transaction_service.dart'
    as _i1063;
import 'package:busha_app/presentation/block_transaction/cubit/block_transaction_cubit.dart'
    as _i840;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i884.DioClientWrapper>(() => _i884.DioClientWrapper());
    gh.singleton<_i1063.BlockTransactionService>(
        () => _i1063.BlockTransactionService(gh<_i884.DioClientWrapper>()));
    gh.factory<_i840.BlockTransactionCubit>(() =>
        _i840.BlockTransactionCubit(gh<_i1063.BlockTransactionService>()));
    return this;
  }
}
