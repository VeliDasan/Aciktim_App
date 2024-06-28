import 'package:aciktim_app/data/entity/yemekler.dart';

class YemeklerCevap {
  List<Yemekler> yemekler;
  int success;

  YemeklerCevap({
    required this.yemekler,
    required this.success,
  });

  factory YemeklerCevap.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["yemekler"] as List? ?? [];  // Olası null değerleri kontrol edin
    var success = json["success"] != null ? int.parse(json["success"].toString()) : 0; // null kontrolü ekleyin

    var yemekler = jsonArray.map((jsonArrayNesnesi) => Yemekler.fromJson(jsonArrayNesnesi)).toList();

    return YemeklerCevap(yemekler: yemekler, success: success);
  }
}

