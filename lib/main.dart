import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math';

import 'package:lottie/lottie.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SiraKimde(),
    );
  }
}

class SiraKimde extends StatefulWidget {
  SiraKimde({Key? key}) : super(key: key);

  @override
  State<SiraKimde> createState() => _SiraKimdeState();
}

class _SiraKimdeState extends State<SiraKimde>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  var rng = Random();
  TextEditingController number = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(

      duration: const Duration(seconds: 2),
      vsync: this,
    );

    controller.addStatusListener((status)async {
      if(status == AnimationStatus.completed) {
        Navigator.pop(context);
        controller.reset();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/aa.jpg'),
                fit: BoxFit.cover,
                opacity: 0.7,
              ),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 350.0),
                  const Text(
                    'Katılımcı Sayısı',
                    style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold,color: Colors.black),
                  ),
                  SizedBox(height: 40.0),
                  participantTextField(context),
                  SizedBox(height: 30.0),
                  customButton(context),
                  SizedBox(height: 110.0),
                ]),
          ),
        ),
      ),
    );
  }

  Widget participantTextField(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        color: Colors.white,
        child: TextField(
          controller: number,
          textAlign: TextAlign.center,
          textInputAction: TextInputAction.done,
        ),
      ),
    );
  }

  Widget customButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        var firstNum = int.parse(number.text);

        var num = rng.nextInt(firstNum);
        print('işte sayıı $num');
        await animation();
        //sleep(const Duration(seconds: 2));
        dialog(num);
      },
      child: Container(
        color: Colors.black,
        width: 200.0,
        height: 40.0,
        child: const Center(
            child: Text(
          'Bas',
          style: TextStyle(fontSize: 30.0,color: Colors.white),
        )),
      ),
    );
  }

  Future dialog(int sayi) {
    return showDialog(
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            backgroundColor: Colors.redAccent,
            contentTextStyle: const TextStyle(fontSize: 30.0,color: Colors.black),
              title: const Text('     ÇAYCI HÜSEYİN NO'),
              content: Text('              $sayi')),
        );
      },
      context: context,
    );
  }

  Future animation() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Lottie.asset(
            'assets/anim.json',
            repeat: true,
            controller: controller,
            onLoaded: (composition) {
              controller.forward();
            },
          );
        });
  }
}
