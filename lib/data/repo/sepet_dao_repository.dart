import 'dart:convert';
import 'package:aciktim_app/data/entity/yemekler.dart';
import 'package:dio/dio.dart';

import '../entity/sepet_response.dart';


class SepetDaoRepository {

  List<Yemekler> parseCart(String response) {
    CartResponse cartResponse = CartResponse.fromJson(jsonDecode(response));
    return cartResponse.cartItems;
  }


  Future<List<Yemekler>> listCartItems(String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var data = {"kullanici_adi": kullanici_adi};

    try {
      var response = await Dio().post(url, data: FormData.fromMap(data));
      return parseCart(response.data.toString());
    } catch (e) {
      print("Sepet listesi alınırken hata oluştu: $e");
      return [];
    }
  }


  Future<void> addToCart(String name, String img_name, String price, String piece, String username) async {

    var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";

    var data = {"yemek_adi":name, "yemek_resim_adi":img_name, "yemek_fiyat":price,
      "yemek_siparis_adet":piece, "kullanici_adi":username};

    var response = await Dio().post(url, data: FormData.fromMap(data));

    print("Sepete Ekle: ${response.data.toString()}");
  }

  Future<void> deleteCartItem(String id, String username) async {

    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var data = {"sepet_yemek_id":id, "kullanici_adi":username};
    var response = await Dio().post(url, data: FormData.fromMap(data));

    print("Sepetten Yemek Sil : ${response.data.toString()}");
  }
}