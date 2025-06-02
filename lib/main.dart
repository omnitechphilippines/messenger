import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import 'constants/colors.dart';
import 'models/location.dart';
import 'models/user.dart';
import 'pages/splash_page/splash_page.dart';

User user = User(
  name: "Romnick Muaña",
  email: "romnickmuana.fake.email@gmail.com",
  gender: "Male",
  phoneNumber: "+63 9999999999",
  birthDate: 498456350,
  location: Location(city: "Cebu", postcode: "124001", state: "Cebu", street: "New Street"),
  username: "romnickmuana",
  password: "79aa7b81bcdd14fd98282b810b61312b",
  firstName: "Romnick",
  lastName: "Muaña",
  title: "Full Stack Developer",
  uuid: "9b1deb4d-3b7d-4bad-9bdd-2b0d7b3dcb6d",
  picture: "assets/images/persons/romnick-muaña.png",
);

User rick = User(
  name: "Rick Rolland",
  email: "rick.fake.email@gmail.com",
  gender: "Male",
  phoneNumber: "8888888888",
  birthDate: 498456351,
  location: Location(city: "Rohtak", postcode: "124001", state: "Haryana", street: "New Street"),
  username: "rickkk",
  password: "79aa7b81bcdd14fd98282b810b61312a",
  firstName: "Rick",
  lastName: "Rolland",
  title: "Web Developer",
  uuid: "b1deb4d-3b7d-4bad-9bdd-2b0d7b3dcb6a",
  picture: "assets/images/persons/rick-rolland.webp",
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
    null,
    <NotificationChannel>[NotificationChannel(channelGroupKey: 'basic_channel_group', channelKey: 'basic_channel', channelName: 'Messenger', channelDescription: 'Messenger calling', defaultColor: greenColor, ledColor: Colors.white)],
    channelGroups: <NotificationChannelGroup>[NotificationChannelGroup(channelGroupKey: 'basic_channel_group', channelGroupName: 'Basic group')],
    debug: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Messenger', debugShowCheckedModeBanner: false, theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "SFProText"), home: const SplashPage());
  }
}
