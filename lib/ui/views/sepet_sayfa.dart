import 'package:aciktim_app/data/entity/yemekler.dart';
import 'package:aciktim_app/renkler.dart';
import 'package:aciktim_app/ui/cubit/sepetsayfa_cubit.dart';
import 'package:aciktim_app/ui/views/siparis_onay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SepetSayfa extends StatefulWidget {
  const SepetSayfa({super.key});

  @override
  State<SepetSayfa> createState() => _CartPageState();
}

class _CartPageState extends State<SepetSayfa> {
  String baseUrl = "http://kasimadalan.pe.hu/yemekler/resimler";
  String username = "kullanici_adi";
  int totalPrice = 0;

  @override
  void initState() {
    super.initState();
    context.read<SepetsayfaCubit>().listCartItems(username);
  }

  void calculateTotalPrice(List<Yemekler> cartItems) {
    totalPrice = cartItems.fold(0, (sum, item) => sum + (item.yemek_fiyat));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: anaRenk,
        foregroundColor: Colors.white,
        title:  Text("Sepetim", style: TextStyle(fontFamily: "Dancing",color:yaziRenk2,fontSize: 40 )),
        centerTitle: true,
        actions: [
          BlocBuilder<SepetsayfaCubit, List<Yemekler>>(
            builder: (context, cartItems) {
              calculateTotalPrice(cartItems);
              return Row(
                children: [
                  Text(
                    "$totalPrice ₺",
                    style: TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Siparişiniz yola çıktı...")),
                      );
                      // SiparisOnay sayfasına geçiş yapılacak navigator işlemi
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SiparisOnay()),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart_checkout_outlined),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<SepetsayfaCubit, List<Yemekler>>(
        builder: (context, cartItems) {
          if (cartItems.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  var cartItem = cartItems[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Card(
                      color: Color(0xFFC7B7A3),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Row(
                          children: [
                            SizedBox(
                                width: 100,
                                child: Image.network("$baseUrl/${cartItem.yemek_resim_adi}")
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(cartItem.yemek_adi,
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                                ),
                                Text("${cartItem.yemek_fiyat}.00 ₺", style: const TextStyle(fontSize: 18)),
                                Text("${cartItem.yemek_siparis_adet} Adet", style: const TextStyle(fontSize: 18)),
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                context.read<SepetsayfaCubit>().deleteCartItem(cartItem.id, username).then((_) {
                                  context.read<SepetsayfaCubit>().listCartItems(username);
                                });
                              },
                              icon: Icon(Icons.delete_outline, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: Text("Sepetiniz boş, sepetinize yemek ekleyin.",
                style: TextStyle(fontSize: 18), textAlign: TextAlign.center,
              ),
            );
          }
        },
      ),
    );
  }
}
