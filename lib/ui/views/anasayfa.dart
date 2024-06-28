import 'package:aciktim_app/data/entity/yemekler.dart';
import 'package:aciktim_app/renkler.dart';
import 'package:aciktim_app/ui/cubit/anasayfa_cubit.dart';
import 'package:aciktim_app/ui/views/detay2_sayfa.dart';
import 'package:aciktim_app/ui/views/sepet_sayfa.dart'; // Import the SepetSayfa
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().yemekleriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Acıktım",
            style: TextStyle(
              color: yaziRenk2,
              fontFamily: "Dancing",
              fontSize: 40,
            ),
          ),
          backgroundColor: anaRenk,
          foregroundColor: Colors.white,
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SepetSayfa()),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<AnasayfaCubit, List<Yemekler>>(
            builder: (context, yemeklerListesi) {
              if (yemeklerListesi.isNotEmpty) {
                return GridView.builder(
                  itemCount: yemeklerListesi.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.8,
                  ),
                  itemBuilder: (context, indeks) {
                    var yemek = yemeklerListesi[indeks];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Detay2Sayfa(yemek: yemek)),
                        );
                      },
                      child: Card(
                        color: Color(0xFFC7B7A3),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}"),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("${yemek.yemek_fiyat} ₺", style: const TextStyle(fontSize: 24)),
                                Text("${yemek.yemek_adi}", style: const TextStyle(fontSize: 24)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
        ),
        );
    }
}