import 'package:aciktim_app/data/entity/yemekler.dart';
import 'package:aciktim_app/renkler.dart';
import 'package:aciktim_app/ui/cubit/sepeteekle_cubit.dart';
import 'package:aciktim_app/ui/views/sepet_sayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Detay2Sayfa extends StatefulWidget {

  Yemekler yemek;

  Detay2Sayfa({required this.yemek});

  @override
  State<Detay2Sayfa> createState() => _DetailPageState();
}

class _DetailPageState extends State<Detay2Sayfa> {

  String baseUrl = "http://kasimadalan.pe.hu/yemekler/resimler";
  int counter = 1;
  int totalPrice = 0;
  String username = "kullanici_adi";

  @override
  void initState() {

    super.initState();
    totalPrice = int.parse(widget.yemek.yemek_fiyat.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: anaRenk,
        foregroundColor: Colors.white,
        title:Text("Yemek Detayı", style: TextStyle(fontFamily: "Dancing",color: yaziRenk2,fontSize: 40)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Image.network(
                "http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim_adi}"
            ),
            Text(widget.yemek.yemek_adi, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("${widget.yemek.yemek_fiyat}.00 ₺", style: const TextStyle(fontSize: 30)),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: anaRenk,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      if(counter == 1) {
                        return;
                      }

                      else {
                        counter--;
                        totalPrice -= int.parse(widget.yemek.yemek_fiyat.toString());
                      }
                    });
                  },
                  child: const Text("-", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text("${counter.toString()} Adet", style: const TextStyle(fontSize: 25)),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: anaRenk,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      counter++;
                      totalPrice += int.parse(widget.yemek.yemek_fiyat.toString());
                    });
                  },
                  child: const Text("+", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const Spacer(),
            TextButton.icon(
              style: TextButton.styleFrom(
                  backgroundColor: anaRenk,
                  foregroundColor: Colors.white,

              ),
              onPressed: () {
                context.read<SepeteekleCubit>().SepeteEkle(widget.yemek.yemek_adi, widget.yemek.yemek_resim_adi,
                    totalPrice.toInt(), counter.toInt(), username);

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SepetSayfa()));
              },
              label: const Text("Sepete Ekle", style: TextStyle(fontSize: 25)),
              icon: const Icon(Icons.shopping_cart_outlined),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
              child: Text("Toplam : $totalPrice.00 ₺", style: const TextStyle(fontSize: 22)),
            ),
          ],
        ),
      ),
    );
  }
}