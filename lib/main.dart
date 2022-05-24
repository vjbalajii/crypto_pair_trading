import 'package:crypto_pair_trading/model/repository/trading_repository.dart';
import 'package:crypto_pair_trading/view/screens/home_screen.dart';
import 'package:crypto_pair_trading/view_model/trading_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    TradingRepository repo = TradingRepositoryImpl();
    TradingViewModel tradingViewModel = TradingViewModelImpl(repo: repo);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: tradingViewModel),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Crypto Pair Trading',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(),
          primarySwatch: Colors.purple,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
        },
      ),
    );
  }
}
