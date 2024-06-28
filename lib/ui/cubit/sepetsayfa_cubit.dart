import 'package:aciktim_app/data/entity/yemekler.dart';
import 'package:aciktim_app/data/repo/sepet_dao_repository.dart';
import 'package:aciktim_app/data/repo/yemeklerdao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SepetsayfaCubit extends Cubit<List<Yemekler>>{
  SepetsayfaCubit():super(<Yemekler>[]);

  var yrepo=SepetDaoRepository();

  Future<void>listCartItems(String kullanici_adi)async{
    var liste=await yrepo.listCartItems(kullanici_adi);
    emit(liste);
  }
  Future<void> deleteCartItem(String id, String username) async {
    await yrepo.deleteCartItem(id, username);
    await yrepo.listCartItems(username);
  }

}