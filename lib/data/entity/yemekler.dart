class Yemekler {
  String id;
  int yemek_id;
  String yemek_adi;
  String yemek_resim_adi;
  int yemek_fiyat;
  int yemek_siparis_adet;
  String kullanici_adi;

  Yemekler({
    required this.id,
    required this.yemek_id,
    required this.yemek_adi,
    required this.yemek_resim_adi,
    required this.yemek_fiyat,
    required this.yemek_siparis_adet,
    required this.kullanici_adi,
  });

  factory Yemekler.fromJson(Map<String, dynamic> json) {
    return Yemekler(
      id: json["sepet_yemek_id"] as String? ?? "", // null kontrolü ekleyin
      yemek_id: json["yemek_id"] != null ? int.tryParse(json["yemek_id"].toString()) ?? 0 : 0,
      yemek_adi: json["yemek_adi"] as String? ?? "",
      yemek_resim_adi: json["yemek_resim_adi"] as String? ?? "",
      yemek_fiyat: json["yemek_fiyat"] != null ? int.tryParse(json["yemek_fiyat"].toString()) ?? 0 : 0,
      yemek_siparis_adet: json["yemek_siparis_adet"] != null ? int.tryParse(json["yemek_siparis_adet"].toString()) ?? 0 : 0,
      kullanici_adi: json["kullanici_adi"] as String? ?? "kullanici_adi",
    );
  }
}
