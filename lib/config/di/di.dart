import 'package:ecommerce_app_huma_volve/config/di/di.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true, // default
)
void configureDependencies() => getIt.init();
