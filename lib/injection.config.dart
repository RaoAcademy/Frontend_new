// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:EdTestz/application/auth/auth_provider.dart' as _i15;
import 'package:EdTestz/application/firebase/firebase_notification_provider.dart'
    as _i6;
import 'package:EdTestz/application/home/home_provider.dart' as _i16;
import 'package:EdTestz/application/other/other_provider.dart' as _i9;
import 'package:EdTestz/application/payment/payment_provider.dart' as _i17;
import 'package:EdTestz/application/splash/splash_provider.dart' as _i12;
import 'package:EdTestz/application/test/test_provider.dart' as _i18;
import 'package:EdTestz/core/utli/api_client.dart' as _i3;
import 'package:EdTestz/domain/auth/auth_repo.dart' as _i4;
import 'package:EdTestz/domain/home/home_repo.dart' as _i7;
import 'package:EdTestz/domain/payment/payment_repo.dart' as _i10;
import 'package:EdTestz/domain/test_x/test_repo.dart' as _i13;
import 'package:EdTestz/infrastructure/auth/imp_auth_repo.dart' as _i5;
import 'package:EdTestz/infrastructure/home/imp_home_repo.dart' as _i8;
import 'package:EdTestz/infrastructure/payment/imp_payment_repo.dart'
    as _i11;
import 'package:EdTestz/infrastructure/test_x/imp_test_repo.dart' as _i14;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.APIClient>(() => _i3.APIClient());
    gh.lazySingleton<_i4.AuthRepo>(() => _i5.ImpAuthRepo(gh<_i3.APIClient>()));
    gh.factory<_i6.FirebaseNotificationProvider>(
        () => _i6.FirebaseNotificationProvider());
    gh.lazySingleton<_i7.HomeRepo>(() => _i8.ImpHomeRepo(gh<_i3.APIClient>()));
    gh.factory<_i9.OtherProvider>(() => _i9.OtherProvider());
    gh.lazySingleton<_i10.PaymentsRepo>(() => _i11.ImpPaymentRepo());
    gh.factory<_i12.SplashProvider>(() => _i12.SplashProvider());
    gh.lazySingleton<_i13.TestRepo>(() => _i14.ImpTestRepo());
    gh.factory<_i15.AuthAppProvider>(() => _i15.AuthAppProvider(gh<_i4.AuthRepo>()));
    gh.factory<_i16.HomeProvider>(() => _i16.HomeProvider(gh<_i7.HomeRepo>()));
    gh.factory<_i17.PaymentProvider>(
        () => _i17.PaymentProvider(gh<_i10.PaymentsRepo>()));
    gh.factory<_i18.TestProvider>(() => _i18.TestProvider(gh<_i13.TestRepo>()));
    return this;
  }
}
