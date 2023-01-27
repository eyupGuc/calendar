import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/date_bloc.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DateBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: DiziGunler(),
          ),
        ),
      ),
    );
  }
}

class DiziGunler extends StatefulWidget {
  @override
  _DiziGunlerState createState() => _DiziGunlerState();
}

class _DiziGunlerState extends State<DiziGunler> {
  List<String> diziGunler = [];
  List<int> diziAyinGunleri = [];
  List<String> gunler = [];
  List<String> name = ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cts', 'Paz'];
  List<String> names = [
    'Pazartesi',
    'Salı',
    'Çarşamba',
    'Perşembe',
    'Cuma',
    'Cumartesi',
    'Pazar'
  ];
  List<String> aylar = [
    'Ocak',
    'Şubat',
    'Mart',
    'Nisan',
    'Mayıs',
    'Haziran',
    'Temmuz',
    'Ağustos',
    'Eylül',
    'Ekim',
    'Kasım',
    'Aralık'
  ];

  List<int> aylarInt = [];
  late int today;
  //String selectedDate = "";
  //bool openDate = true;
  String selectMonth = "";
  int selectedDayofMonth = 1;
  String selectDayofWeek = "";
  var now = DateTime.now();

  @override
  void initState() {
    super.initState();
    Timer.run(() {
      setState(() {
        today = DateTime.now().weekday;
        print(today);
        print(now.month);
        print("try ${DateTime.now().subtract(Duration(days: 1))}");
        for (int i = today; i >= 0; i--) {
          DateTime date = DateTime.now().subtract(Duration(
              days: i -
                  1)); // print("try ${DateTime.now().subtract(Duration(days:1))}"); tam olarak 1 gün öncesine gider
          print(date);
          aylarInt.add(date.month);
          print(aylarInt);
          diziGunler.add(date.day.toString() + ' ' + name[date.weekday - 1]);
          diziAyinGunleri.add(date.day);
          gunler.add(name[date.weekday - 1]);
        }
        for (int i = 1; i < 7 - today; i++) {
          DateTime date =
              DateTime.now().add(Duration(days: i + 1)); // sonrasına gider
          diziGunler.add(date.day.toString() + ' ' + name[date.weekday - 1]);
          diziAyinGunleri.add(date.day);
          gunler.add(name[date.weekday - 1]);
          aylarInt.add(date.month);
          print(aylarInt);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My calendar")),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: diziGunler.length,
              itemBuilder: (context, index) {
                print("index ,$index");
                return ListTile(
                  hoverColor: Colors.green.shade200,
                  title: index == today - 1
                      ? Column(children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.blue.shade300,
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Text(gunler[index]),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        diziAyinGunleri[index].toString(),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ])
                      : Column(
                          children: [
                            Text(
                              gunler[index],
                            ),
                            Text(diziAyinGunleri[index].toString())
                          ],
                        ),
                  onTap: () {
                    context.read<DateBloc>().add(NewDateEvent(
                        date:
                            ("${diziAyinGunleri[index]} ${aylar[aylarInt[index] - 1]} , ${names[index]}")));
                  },
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                ExpansionTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: BlocBuilder<DateBloc, DateState>(
                    builder: (context, state) {
                      return Text(state.date);
                    },
                  ),
                  backgroundColor: Colors.white60,
                  children: const [
                    Text("Open to ExpansionTile"),
                    Text("data")
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
