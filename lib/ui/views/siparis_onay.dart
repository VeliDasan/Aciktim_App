import 'package:aciktim_app/renkler.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';



class SiparisOnay extends StatelessWidget {
  const SiparisOnay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: anaRenk,
        foregroundColor: Colors.white,
        title:Text("Sipariş", style: TextStyle(fontFamily: "Dancing",color: yaziRenk2,fontSize: 40)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Lottie.network('https://lottie.host/0f3c524f-b41e-402f-b84f-1182a4ecb2a1/tSVGZOrYiB.json')
        ],
      ),
    );
  }
}