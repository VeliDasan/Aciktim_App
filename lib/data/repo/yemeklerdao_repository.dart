import 'package:aciktim_app/data/entity/yemekler.dart';
import 'package:aciktim_app/data/entity/yemekler_cevap.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

class YemeklerdaoRepository {
  List<Yemekler> parseYemekler(String cevap) {
    return YemeklerCevap.fromJson(json.decode(cevap)).yemekler;
  }

  Future<List<Yemekler>> yemekleriYukle() async {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var cevap = await Dio().get(url);
    return parseYemekler(cevap.data.toString());
  }
  Future<List<Yemekler>> ara(String aramaKelimesi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var veri = {"yemek_adi":aramaKelimesi};
    var cevap = await Dio().get(url,data: FormData.fromMap(veri));
    return parseYemekler(cevap.data.toString());
  }


  Future<void> SepeteEkle(String yemek_adi,String yemek_resim_adi,int yemek_fiyat,int yemek_siparis_adet,String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var veri = {"yemek_adi":yemek_adi,
      "yemek_resim_adi":yemek_resim_adi,
      "yemek_fiyat":yemek_fiyat,
      "yemek_siparis_adet":yemek_siparis_adet,
      "kullanici_adi":kullanici_adi,

    };
    var cevap = await Dio().post(url,data: FormData.fromMap(veri));
    print("Sepete Ekle : ${cevap.data.toString()}");
  }

}
