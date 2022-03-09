import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:shared_preference/constants/exporting.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AndroidInitializationSettings? initializationSettingsAndroid;
  IOSInitializationSettings? initializationSettingsIOS;
  InitializationSettings? initializationSettings;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  int? day = DateTime.now().day, hour, minute;

  String region = "Boshlangich";

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, subtitle, content) {});
    initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings!,
        onSelectNotification: (v) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (c) => Scaffold(
                    appBar: AppBar(
                      title: const Text('Hello'),
                    ),
                  )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.green,
        ),
        centerTitle: true,
        title: Text(region.toString()),
        backgroundColor: Colors.green,
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      value: "Toshkent",
                      child: const Text("Toshkent"),
                      onTap: () {
                        setState(() {
                          region = "Tashkent";
                        });
                      },
                    ),
                  ]),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: height(0.05)),
            height: height(0.12),
            width: width(1),
            color: Colors.green.withOpacity(0.6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Bomdodgacha qolgan vaqt: ",
                  style: TextStyle(
                    fontSize: width(0.04),
                    color: Colors.white,
                  ),
                ),
                Text(
                  "03:08:55",
                  style: TextStyle(
                    fontSize: width(0.1),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: height(0.05),
            ),
            child: Container(
              height: height(0.11),
              width: width(1),
              color: Colors.green.shade900.withOpacity(0.6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  timeDesign("Bomdod", "04:35"),
                  timeDesign("Peshin", "04:35"),
                  timeDesign("Asr", "04:35"),
                  timeDesign("Shom", "04:35"),
                  timeDesign("Hufton", "04:35"),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height(0.1)),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: width(0.11)),
              height: height(0.4),
              child: GridView.builder(
                  itemCount: 6,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: height(0.15),
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(2.0),
                      color: Colors.green.withOpacity(0.2),
                      child: Center(
                        child: Container(
                          height: height(0.1),
                          width: height(0.1),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Image(
                              height: height(0.06),
                              width: height(0.06),
                              image: const AssetImage('assets/icons/dua.png'),
                              color: Colors.white,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
      floatingActionButton: floatingButton(context),
    );
  }

  FloatingActionButton floatingButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.green,
      onPressed: () async {
        // await showDatePicker(
        //   context: context,
        //   initialDate: DateTime.now(),
        //   firstDate: DateTime(2022, 01, 01, 0, 0),
        //   lastDate: DateTime(2025),
        // ).then((value) async {
        //   day = value!.day;
        //   await showTimePicker(
        //     context: context,
        //     initialTime: {
        //     hour = value!TimeOfDay.now(),
        //   ).then((value) .hour;
        //     minute = value.minute;
        //   });
        //   b(day!, hour!, minute!);
        // });
        b();
        //FlutterAlarmClock.createAlarm(20, 08);
        
      },
      child: const Icon(Icons.send),
    );
  }

  timeDesign(String text, String time) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: width(0.03),
            color: Colors.white,
          ),
        ),
        const Icon(
          Icons.wb_sunny,
          color: Colors.white,
        ),
        Text(
          time,
          style: TextStyle(
            fontSize: width(0.03),
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  height(a) {
    return MediaQuery.of(context).size.height * a;
  }

  width(a) {
    return MediaQuery.of(context).size.width * a;
  }

  b() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      "My Channel Id",
      "my channel name",
      channelDescription: "My Channel description",
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'plain title',
      'plain body',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  a(int day, int hour, int minute) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        'Eslatma shu yerda',
        "Bodyni shu yerda yozish kerak",
        tz.TZDateTime.from(
          DateTime(2022, 1, day, hour, minute),
          tz.getLocation('America/Detroit'),
        ),
        const NotificationDetails(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }
}
