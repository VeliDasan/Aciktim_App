import 'package:aciktim_app/data/entity/yemekler.dart';


class CartResponse {

  List<Yemekler> cartItems;
  int success;

  CartResponse({required this.cartItems, required this.success});

  factory CartResponse.fromJson(Map<String, dynamic> json) {

    var jsonArray = json["sepet_yemekler"] as List;
    int success = json["success"] as int;

    var cartItems = jsonArray.map((object) => Yemekler.fromJson(object)).toList();

    return CartResponse(cartItems: cartItems, success: success);
  }
}