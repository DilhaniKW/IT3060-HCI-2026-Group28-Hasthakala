import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/routes/app_routes.dart';
import 'config/routes/route_generator.dart';
import 'core/theme/app_theme.dart';
import 'features/account/presentation/state/auth_provider.dart';
import 'features/artisan/presentation/state/artisan_dashboard_provider.dart';
import 'features/artisan/presentation/state/artisan_orders_provider.dart';
import 'features/discovery/presentation/state/discovery_provider.dart';
import 'features/purchase/presentation/state/cart_provider.dart';

class HasthakalaApp extends StatelessWidget {
  const HasthakalaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => DiscoveryProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ArtisanDashboardProvider()),
        ChangeNotifierProvider(create: (_) => ArtisanOrdersProvider()),
      ],
      child: MaterialApp(
        title: 'Hasthakala',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
