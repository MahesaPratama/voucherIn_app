import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voucherin/view/Screen/contact_us.dart';
import 'package:voucherin/view/Screen/forgot_password.dart';
import 'package:voucherin/view/Screen/create_pin.dart';
import 'package:voucherin/view/Screen/create_pin_confirm.dart';
import 'package:voucherin/view/Screen/pin_confirm.dart';
import 'package:voucherin/view/Screen/saldo.dart';
import 'package:voucherin/view/Screen/splashscreen.dart';
import 'package:voucherin/view/Screen/start.dart';
import 'package:voucherin/ViewModel/pulsa_payment_provider.dart';
import 'package:voucherin/view/Screen/akun.dart';
import 'package:voucherin/ViewModel/pulsa_api_provider.dart';
import 'package:voucherin/view/Screen/home.dart';
import 'package:voucherin/view/Screen/pulsa_payment.dart';
import 'package:voucherin/view/Screen/pulsa_payment_success.dart';
import 'package:voucherin/view/Screen/pulsa_product.dart';
import 'package:voucherin/view/theme/style.dart';
import 'package:voucherin/ViewModel/pulsa_product_provider.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:voucherin/ViewModel/top_up_provider.dart';
import 'view/Screen/pin_confirm_buy.dart';
import 'view/Screen/navbar.dart';

void main() async {
  //Untuk menginisialisasi firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //Untuk membuat notifikasi
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: royalBlue,
          ledColor: Colors.white)
    ],
    debug: true,
  );
  //Mendaftarkan provider yang ada
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => PulsaProductProvider()),
      ChangeNotifierProvider(create: (context) => PulsaPaymentProvider()),
      ChangeNotifierProvider(create: (context) => PulsaProvider()),
      ChangeNotifierProvider(create: (context) => TopUpProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          iconTheme: IconThemeData(color: royalBlue, size: 40),
          appBarTheme: AppBarTheme(
              elevation: 0,
              centerTitle: true,
              backgroundColor: background,
              titleTextStyle: blueTextStyle.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ))),
      routes: {
        '/': (context) => const SplashScreen(),
        '/start': (context) => const StartedPage(),
        '/navbar': (context) => const NavbarPage(),
        '/home': (context) => const HomePage(),
        '/pulsa': (context) => const PulsaProductPage(),
        '/payment': (context) => const PulsaPaymentPage(),
        '/success': (context) => const PulsaPaymentSuccessPage(),
        '/akun': (context) => const AkunPage(),
        '/forgot': (context) => const ForgotPasswordPage(),
        '/pin': (context) => const CreatePinPage(),
        '/create_confirm': (context) => const CreatePinConfirmPage(),
        '/pin_confirm': (context) => const PinConfirmPage(),
        '/pin_buy': (context) => const PinConfirmBuyPage(),
        '/cs': (context) => const ContactUsPage(),
        '/saldo': (context) => const SaldoPage(),
      },
    );
  }
}
