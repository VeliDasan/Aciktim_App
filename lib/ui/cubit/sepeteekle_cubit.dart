import 'package:aciktim_app/data/repo/yemeklerdao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SepeteekleCubit extends Cubit<void>{
  SepeteekleCubit():super(0);

  var yrepo=YemeklerdaoRepository();
  Future<void> SepeteEkle(String yemek_adi,String yemek_resim_adi,int yemek_fiyat,int yemek_siparis_adet,String kullanici_adi)async{
    await yrepo.SepeteEkle(yemek_adi,yemek_resim_adi,yemek_fiyat,yemek_siparis_adet,kullanici_adi);
  }
}